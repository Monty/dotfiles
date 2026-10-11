#!/usr/bin/env python3
"""Print every non-empty row of an .ods spreadsheet as tab-separated text.

Each line is:  row <TAB> cell A <TAB> cell B ...
(with the sheet name first when the file has more than one sheet).
Cells show what LibreOffice displays, so dates look like "Mon 11/06/23".
With -f, formula cells show their formula instead, e.g. of:=HYPERLINK("url";"label").

Every cell comes from its own <table:table-row>, so columns can't drift apart.
Works as a ripgrep preprocessor:
    rg --pre odsRows.py --pre-glob '*.ods' PATTERN *.ods

Usage: odsRows.py [-f] [-s SHEET] FILE.ods
"""

import argparse
import sys
import zipfile
import xml.etree.ElementTree as ET

T = "{urn:oasis:names:tc:opendocument:xmlns:table:1.0}"
TX = "{urn:oasis:names:tc:opendocument:xmlns:text:1.0}"
CELLS = (T + "table-cell", T + "covered-table-cell")


def para_text(el):
    """Text of a <text:p>, honouring <text:s>, <text:tab> and <text:line-break>."""
    out = [el.text or ""]
    for child in el:
        if child.tag == TX + "s":
            out.append(" " * int(child.get(TX + "c", "1")))
        elif child.tag in (TX + "tab", TX + "line-break"):
            out.append(" ")
        else:
            out.append(para_text(child))
        out.append(child.tail or "")
    return "".join(out)


def cell_text(cell, formulas):
    if formulas and cell.get(T + "formula"):
        text = cell.get(T + "formula")
    else:
        text = " ".join(para_text(p) for p in cell.findall(TX + "p"))
    # keep one cell per field and one row per line
    return text.replace("\t", " ").replace("\r", " ").replace("\n", " ")


def sheet_rows(sheet, formulas):
    """Yield (row number, [cell texts]) for every non-empty row."""
    rownum = 0
    for row in sheet.iter(T + "table-row"):
        repeat = int(row.get(T + "number-rows-repeated", "1"))
        cells = []
        for c in row:
            if c.tag not in CELLS:
                continue
            text = cell_text(c, formulas)
            n = int(c.get(T + "number-columns-repeated", "1"))
            # huge repeats are only the empty filler out to column AMJ
            cells.extend([text] * (n if text else min(n, 1)))
        while cells and not cells[-1]:
            cells.pop()
        if cells:
            for i in range(repeat):
                yield rownum + i + 1, cells
        rownum += repeat


def main():
    ap = argparse.ArgumentParser(
        description=__doc__.split("\nUsage:")[0],
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    ap.add_argument("ods", help="spreadsheet to read, e.g. All_watched_by_title.ods")
    ap.add_argument("-f", "--formulas", action="store_true",
                    help="show formulas instead of displayed values")
    ap.add_argument("-s", "--sheet", help="only this sheet (default: all sheets)")
    if len(sys.argv) == 1:
        ap.print_help(sys.stderr)
        sys.exit(1)
    args = ap.parse_args()

    try:
        with zipfile.ZipFile(args.ods) as z:
            root = ET.fromstring(z.read("content.xml"))
    except (OSError, zipfile.BadZipFile, KeyError, ET.ParseError) as e:
        sys.exit(f"odsRows.py: can't read {args.ods}: {e}")

    sheets = list(root.iter(T + "table"))
    if args.sheet:
        sheets = [s for s in sheets if s.get(T + "name") == args.sheet]
        if not sheets:
            sys.exit(f"odsRows.py: no sheet named {args.sheet!r} in {args.ods}")
    multi = len(sheets) > 1

    try:
        for sheet in sheets:
            prefix = [sheet.get(T + "name")] if multi else []
            for rownum, cells in sheet_rows(sheet, args.formulas):
                print("\t".join(prefix + [str(rownum)] + cells))
    except BrokenPipeError:
        sys.stderr.close()


if __name__ == "__main__":
    main()
