#!/usr/bin/env python3
"""Emit row<TAB>url<TAB>label<TAB>date<TAB>service for every HYPERLINK in column A.

Reads content.xml straight out of the .ods, so each row's formula and values
come from the same <table:table-row> and can't drift apart.
Usage: odsLinks.py FILE.ods [SHEET_NAME]
"""

import argparse
import re
import sys
import zipfile
import xml.etree.ElementTree as ET

T = "{urn:oasis:names:tc:opendocument:xmlns:table:1.0}"
O = "{urn:oasis:names:tc:opendocument:xmlns:office:1.0}"
CELLS = (T + "table-cell", T + "covered-table-cell")
LINK = re.compile(r'^of:=HYPERLINK\("((?:[^"]|"")*)";"((?:[^"]|"")*)"\)$')


def cell_value(c):
    if c is None:
        return ""
    return (
        c.get(O + "date-value")
        or c.get(O + "string-value")
        or c.get(O + "value")
        or "".join(c.itertext())
    ).strip()


def main():
    ap = argparse.ArgumentParser(
        description=__doc__.split("\nUsage:")[0],
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    ap.add_argument("ods", help="spreadsheet to read, e.g. All_watched_by_title.ods")
    ap.add_argument("sheet", nargs="?", help="sheet name (default: first sheet)")
    args = ap.parse_args()
    path, want = args.ods, args.sheet
    with zipfile.ZipFile(path) as z:
        root = ET.fromstring(z.read("content.xml"))
    sheets = list(root.iter(T + "table"))
    sheet = next((s for s in sheets if s.get(T + "name") == want), sheets[0])

    rownum = 0
    for row in sheet.iter(T + "table-row"):
        rownum += int(row.get(T + "number-rows-repeated", "1"))
        cells = []
        for c in row:
            if c.tag in CELLS:
                cells.extend(
                    [c] * min(int(c.get(T + "number-columns-repeated", "1")), 3)
                )
            if len(cells) >= 3:
                break
        cells += [None] * (3 - len(cells))
        m = LINK.match(cells[0].get(T + "formula", "") if cells[0] is not None else "")
        if not m:
            continue
        url, label = (s.replace('""', '"') for s in m.groups())
        print(
            "\t".join(
                [str(rownum), url, label, cell_value(cells[1]), cell_value(cells[2])]
            )
        )


if __name__ == "__main__":
    main()
