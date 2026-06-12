#!/usr/bin/env python3
"""
extract_messages.py — Extract readable transcripts from ~/Library/Messages/chat.db

Usage:
    python3 extract_messages.py --list
    python3 extract_messages.py --list 20
    python3 extract_messages.py --id 42
    python3 extract_messages.py --id 42 --out thread.md
    python3 extract_messages.py --id 42 --tail 50
    python3 extract_messages.py --name "marion@mac.com"
    python3 extract_messages.py --name "+1503"
    python3 extract_messages.py --search "LLM"

Thread IDs come from --list. --name does a substring match against handle IDs,
chat_identifier, and display_name (case-insensitive). --search scans message text.
"""

import plistlib
import re
import sqlite3
import sys
import argparse
from datetime import datetime
from pathlib import Path

DB = Path.home() / "Library/Messages/chat.db"
DEFAULT_CONTACTS = Path.home() / ".config/extract_messages/contacts.tsv"

# Contacts dict loaded at startup: handle → display name
CONTACTS: dict[str, str] = {}


def load_contacts(path: Path) -> None:
    """Populate CONTACTS from a tab-separated file: handle\tname."""
    if not path.exists():
        return
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        parts = line.split("\t", 1)
        if len(parts) == 2:
            handle, name = parts[0].strip(), parts[1].strip()
            if handle and name:
                CONTACTS[handle] = name


def resolve(handle: str) -> str:
    """Return contact name for handle, or handle itself if not found."""
    return CONTACTS.get(handle, handle)


# Apple's Core Data epoch starts 2001-01-01; Unix epoch starts 1970-01-01.
# Difference in seconds:
APPLE_EPOCH_OFFSET = 978307200

# item_type labels for group/system events
ITEM_TYPE = {
    1: "member added",
    2: "member removed",
    3: "group renamed",
    4: "group photo changed",
    6: "keep-in-messages changed",
}

# Tapback reaction labels keyed by associated_message_type
TAPBACK = {
    2001: "❤️",
    2002: "👍",
    2003: "👎",
    2004: "😂",
    2005: "‼️",
    2006: "❓",
}

# Whole band of tapback-related associated_message_type values.
# 2001-2006 are classic adds; 3001-3006 are removes; other values in the
# band appear in iOS 16+ "compatibility" text messages (e.g. 'Loved "..."')
# that duplicate the tapback for cross-platform recipients.
# Matches the exclusion range used in search_messages.py.
TAPBACK_BAND = range(2000, 4000)

# Verb prefix → emoji for new-style compatibility messages.
_TAPBACK_VERB = {
    "Loved": "❤️",
    "Liked": "👍",
    "Disliked": "👎",
    "Laughed at": "😂",
    "Emphasized": "‼️",
    "Questioned": "❓",
}
_TAPBACK_VERB_RE = re.compile(
    r"^(" + "|".join(re.escape(v) for v in _TAPBACK_VERB) + r')\s+["\u201c]'
)


# ── attributedBody decoder ───────────────────────────────────────────────────


def decode_attributed_body(blob):
    """
    Extract plain text from iMessage's attributedBody BLOB.

    Two formats exist in the wild:
    - NSArchiver streamtyped (starts with \x04\x0b'streamtyped'): the format
      used by macOS Messages; string encoded as '+' type-tag + length + UTF-8.
      Length encoding: < 0x80 → 1-byte direct; 0x81 → 2-byte little-endian uint16.
    - NSKeyedArchiver binary plist (starts with 'bplist'): navigate $objects
      array via the root UID's NSString reference.
    """
    if not blob:
        return None
    raw = bytes(blob)

    if raw[:13] == b"\x04\x0bstreamtyped":
        return _decode_streamtyped(raw)

    if raw[:6] == b"bplist":
        try:
            plist = plistlib.loads(raw)
            objects = plist.get("$objects", [])
            root_ref = plist.get("$top", {}).get("root")
            if root_ref is None:
                return None
            root_obj = objects[root_ref.data]
            if not isinstance(root_obj, dict):
                return None
            ns_str_ref = root_obj.get("NSString")
            if ns_str_ref is None:
                return None
            text = objects[ns_str_ref.data]
            if isinstance(text, str) and text != "$null":
                return text.strip() or None
        except Exception:
            pass

    return None


def _decode_streamtyped(raw):
    """
    Parse NSArchiver streamtyped NSAttributedString blob and return the string.

    After the NSString class descriptor, the string value is written as:
      '+' (0x2b, C-string type tag)
      length  — 1 byte if < 0x80; or 0x81 followed by a 2-byte little-endian
                uint16 for longer strings
      UTF-8 bytes (no null terminator)
    """
    ns_pos = raw.find(b"NSString")
    if ns_pos == -1:
        return None

    # Locate '+' type tag in the ~20 bytes following the class name.
    # Guard against false positives by requiring a plausible length byte next.
    plus_pos = -1
    search_end = min(ns_pos + 28, len(raw) - 1)
    for i in range(ns_pos + 8, search_end):
        if raw[i] == 0x2B:  # '+'
            nxt = raw[i + 1] if i + 1 < len(raw) else 0
            if nxt < 0x80 or nxt == 0x81:
                plus_pos = i
                break
    if plus_pos == -1:
        return None

    pos = plus_pos + 1  # points at the first length byte
    b0 = raw[pos]

    if b0 < 0x80:
        length = b0
        text_start = pos + 1
    elif b0 == 0x81 and pos + 3 <= len(raw):
        length = raw[pos + 1] | (raw[pos + 2] << 8)  # little-endian uint16
        text_start = pos + 3
    else:
        return None

    if length == 0 or text_start + length > len(raw):
        return None

    try:
        text = raw[text_start : text_start + length].decode("utf-8")
        # U+FFFC is the object-replacement character used for inline attachments.
        # Replace with newline so surrounding text paragraphs stay separated.
        text = text.replace("\ufffc", "\n").strip()
        text = re.sub(r"\n{3,}", "\n\n", text).strip()
        return text or None
    except UnicodeDecodeError:
        return None


# ── DB ────────────────────────────────────────────────────────────────────────


def connect():
    if not DB.exists():
        sys.exit(f"Database not found: {DB}")
    con = sqlite3.connect(str(DB))
    con.execute("PRAGMA query_only = ON")
    con.row_factory = sqlite3.Row
    return con


# ── Date helpers ──────────────────────────────────────────────────────────────


def apple_ts_to_unix(ts):
    """Convert Apple nanosecond timestamp to Unix seconds (float)."""
    if not ts:
        return 0
    # Values > 1e15 are nanoseconds; older entries may be seconds
    if ts > 1_000_000_000_000_000:
        ts = ts / 1_000_000_000
    return ts + APPLE_EPOCH_OFFSET


def fmt_ts(ts):
    """Format Apple nanosecond timestamp as local datetime string."""
    if not ts:
        return "?"
    unix = apple_ts_to_unix(ts)
    return datetime.fromtimestamp(unix).strftime("%Y-%m-%d %H:%M:%S")


def fmt_date_only(ts):
    if not ts:
        return "?"
    unix = apple_ts_to_unix(ts)
    return datetime.fromtimestamp(unix).strftime("%Y-%m-%d")


# ── Thread listing ────────────────────────────────────────────────────────────


def load_threads(con):
    """Return list of thread dicts ordered by most recent message."""
    cur = con.cursor()
    cur.execute("""
        SELECT
            c.ROWID                             AS chat_id,
            c.chat_identifier,
            c.display_name,
            c.service_name,
            c.is_archived,
            COUNT(cmj.message_id)               AS msg_count,
            MAX(cmj.message_date)               AS last_date
        FROM chat c
        LEFT JOIN chat_message_join cmj ON c.ROWID = cmj.chat_id
        GROUP BY c.ROWID
        ORDER BY last_date DESC NULLS LAST
    """)
    threads = [dict(r) for r in cur.fetchall()]

    # Attach handle IDs for each thread
    handle_map = {}
    cur.execute("""
        SELECT chj.chat_id, GROUP_CONCAT(h.id, ' | ') AS handles
        FROM chat_handle_join chj
        JOIN handle h ON chj.handle_id = h.ROWID
        GROUP BY chj.chat_id
    """)
    for row in cur.fetchall():
        handle_map[row["chat_id"]] = row["handles"] or ""

    for t in threads:
        t["handles"] = handle_map.get(t["chat_id"], "")

    return threads


def thread_label(t):
    """Human-readable label for a thread, with contact names resolved."""
    if t.get("display_name"):
        return t["display_name"]
    if t.get("handles"):
        parts = [h.strip() for h in t["handles"].split("|")]
        resolved = [resolve(h) for h in parts]
        # Deduplicate while preserving order (e.g. June appears via two handles)
        seen = set()
        unique = []
        for name in resolved:
            if name not in seen:
                seen.add(name)
                unique.append(name)
        return " | ".join(unique)
    return t.get("chat_identifier") or f"chat {t['chat_id']}"


def list_threads(con, n=None):
    threads = load_threads(con)
    if n:
        threads = threads[:n]

    print(f"{'ID':>5}  {'Last message':<20}  {'Msgs':>5}  {'Svc':<8}  Contact / Name")
    print("-" * 90)
    for t in threads:
        label = thread_label(t)[:50]
        svc = (t.get("service_name") or "")[:8]
        arc = " [arc]" if t.get("is_archived") else ""
        print(
            f"{t['chat_id']:>5}  {fmt_ts(t['last_date']):<20}  "
            f"{t['msg_count']:>5}  {svc:<8}  {label}{arc}"
        )


# ── Thread search by name ─────────────────────────────────────────────────────


def find_threads_by_name(con, query):
    """Return threads whose handle IDs, chat_identifier, display_name, or resolved contact names match query."""
    threads = load_threads(con)
    q = query.lower()
    return [
        t
        for t in threads
        if q in (t.get("handles") or "").lower()
        or q in (t.get("chat_identifier") or "").lower()
        or q in (t.get("display_name") or "").lower()
        or q in thread_label(t).lower()
    ]


# ── Message search ────────────────────────────────────────────────────────────


def search_messages(con, query, n=20):
    """Print threads + snippets containing query text (text column + attributedBody).
    Smart case: case-insensitive if query is all lowercase, sensitive otherwise.
    """
    threads = load_threads(con)
    thread_label_map = {t["chat_id"]: thread_label(t) for t in threads}
    smart_case = query == query.lower()  # all lowercase → case-insensitive

    cur = con.cursor()

    # Query 1: text column
    # SQLite LIKE is case-insensitive for ASCII by default.
    # For case-sensitive, use GLOB or INSTR on UPPER().
    if smart_case:
        text_filter = "m.text LIKE ?"
        text_param = f"%{query}%"
    else:
        text_filter = "INSTR(m.text, ?) > 0"
        text_param = query

    cur.execute(
        f"""
        SELECT m.ROWID, m.text AS snippet_text, m.date, m.is_from_me,
               cmj.chat_id, h.id AS sender_id, 0 AS from_blob
        FROM message m
        JOIN chat_message_join cmj ON m.ROWID = cmj.message_id
        LEFT JOIN handle h ON m.handle_id = h.ROWID
        WHERE {text_filter}
        ORDER BY m.date DESC
        LIMIT ?
    """,
        (text_param, n),
    )
    text_rows = [dict(r) for r in cur.fetchall()]
    text_ids = {r["ROWID"] for r in text_rows}

    # Query 2: attributedBody blobs — LIKE doesn't work on BLOB columns in SQLite,
    # so fetch all null-text messages and decode in Python.
    cur.execute(
        """
        SELECT m.ROWID, m.attributedBody, m.date, m.is_from_me,
               cmj.chat_id, h.id AS sender_id
        FROM message m
        JOIN chat_message_join cmj ON m.ROWID = cmj.message_id
        LEFT JOIN handle h ON m.handle_id = h.ROWID
        WHERE m.text IS NULL
          AND m.attributedBody IS NOT NULL
          AND m.item_type = 0
        ORDER BY m.date DESC
    """,
        (),
    )
    blob_rows = []
    for r in cur.fetchall():
        if r["ROWID"] in text_ids:
            continue  # already captured
        decoded = decode_attributed_body(r["attributedBody"])
        if decoded and (
            query in decoded if not smart_case else query.lower() in decoded.lower()
        ):
            blob_rows.append(
                {
                    "ROWID": r["ROWID"],
                    "snippet_text": decoded,
                    "date": r["date"],
                    "is_from_me": r["is_from_me"],
                    "chat_id": r["chat_id"],
                    "sender_id": r["sender_id"],
                    "from_blob": 1,
                }
            )

    rows = sorted(text_rows + blob_rows, key=lambda r: r["date"], reverse=True)[:n]

    if not rows:
        print(f"No messages found containing '{query}'")
        return

    print(f"Found {len(rows)} message(s) containing '{query}' (most recent first):\n")
    for row in rows:
        chat_id = row["chat_id"]
        label = thread_label_map.get(chat_id, f"chat {chat_id}")
        sender = "Me" if row["is_from_me"] else resolve(row["sender_id"] or "?")
        print(f"  [{chat_id}] {label}")
        print(f"  {fmt_ts(row['date'])}  {sender}")
        text = (row["snippet_text"] or "").replace("\n", " ")
        print(f"  {text[:120]}")
        print()


# ── Message loading ───────────────────────────────────────────────────────────


def load_messages(con, chat_id, tail=None):
    """Load all messages for a chat, ordered by date."""
    cur = con.cursor()

    query = """
        SELECT
            m.ROWID,
            m.guid,
            m.text,
            m.attributedBody,
            m.date,
            m.is_from_me,
            m.associated_message_type,
            m.associated_message_guid,
            m.cache_has_attachments,
            m.item_type,
            m.group_title,
            m.group_action_type,
            m.reply_to_guid,
            m.date_edited,
            m.expressive_send_style_id,
            h.id AS sender_id
        FROM message m
        JOIN chat_message_join cmj ON m.ROWID = cmj.message_id
        LEFT JOIN handle h ON m.handle_id = h.ROWID
        WHERE cmj.chat_id = ?
        ORDER BY m.date ASC
    """
    cur.execute(query, (chat_id,))
    messages = [dict(r) for r in cur.fetchall()]

    if tail and len(messages) > tail:
        total = len(messages)
        messages = messages[-tail:]
    else:
        total = len(messages)

    return messages, total


def load_attachments_for_chat(con, chat_id):
    """Return dict mapping message ROWID → list of attachment filenames."""
    cur = con.cursor()
    cur.execute(
        """
        SELECT maj.message_id, a.transfer_name, a.mime_type, a.filename
        FROM message_attachment_join maj
        JOIN attachment a ON maj.attachment_id = a.ROWID
        JOIN chat_message_join cmj ON maj.message_id = cmj.message_id
        WHERE cmj.chat_id = ?
    """,
        (chat_id,),
    )
    result = {}
    for row in cur.fetchall():
        mid = row["message_id"]
        result.setdefault(mid, []).append(
            {
                "name": row["transfer_name"] or row["filename"] or "attachment",
                "mime": row["mime_type"] or "",
            }
        )
    return result


# ── Rendering ─────────────────────────────────────────────────────────────────


def render_text(text):
    """
    Render message text as markdown.
    Split on blank lines into paragraphs; fence paragraphs that contain
    lines with 2+ leading spaces, apply HTML escaping + hard line breaks
    to the rest.
    """
    paragraphs = re.split(r"\n{2,}", text)
    rendered = []
    for para in paragraphs:
        if any(line.startswith("  ") for line in para.split("\n")):
            rendered.append(f"```\n{para}\n```")
        else:
            safe = para.replace("<", "&lt;").replace(">", "&gt;")
            safe = safe.replace("\n", "  \n")
            rendered.append(safe)
    return "\n\n".join(rendered)


def collect_tapbacks(messages):
    """
    Build dict: message_guid → list of (emoji, sender_label) tuples.
    Covers both classic tapbacks (associated_message_type 2001–2006) and
    the iOS 16+ compatibility text messages ('Loved "..."' etc.) that use
    other values in the 2000–3999 band.  All are collected here so they
    can be rendered as annotations on the target message.
    """
    tapbacks = {}
    for msg in messages:
        amt = msg.get("associated_message_type") or 0
        if amt not in TAPBACK_BAND:
            continue
        # Resolve emoji: use the TAPBACK dict for classic values; for new-style
        # compatibility messages parse the verb prefix from the text. The text
        # may live in the text column or only in attributedBody (same fallback
        # as the body renderer).
        emoji = TAPBACK.get(amt)
        if emoji is None:
            text = (msg.get("text") or "").strip()
            if not text:
                text = decode_attributed_body(msg.get("attributedBody")) or ""
            m = _TAPBACK_VERB_RE.match(text)
            emoji = _TAPBACK_VERB.get(m.group(1), "👆") if m else "👆"
        target_guid = msg.get("associated_message_guid") or ""
        # guids sometimes have a "/p:N/" prefix — strip to bare guid
        if "/" in target_guid:
            target_guid = target_guid.split("/")[-1]
        if not target_guid:
            continue  # no target to annotate; message will be suppressed silently
        sender = "Me" if msg["is_from_me"] else resolve(msg.get("sender_id") or "?")
        tapbacks.setdefault(target_guid, []).append((emoji, sender))
    return tapbacks


def render_thread(chat_id, chat_info, messages, attachments, tail=None, total=None):
    """Render a thread to a markdown string."""
    label = thread_label(chat_info)
    lines = []

    # Header
    lines += [
        f"# {label}",
        f"Chat ID:      {chat_id}",
        f"Service:      {chat_info.get('service_name', '?')}",
        f"Participants: {chat_info.get('handles') or chat_info.get('chat_identifier', '?')}",
        f"Messages:     {total or len(messages)}"
        + (f"  (last {tail} shown)" if tail else ""),
        "",
    ]

    tapbacks = collect_tapbacks(messages)

    # Skip tapback messages — they appear as annotations on the target instead.
    # Use the full TAPBACK_BAND (2000-3999) to catch both classic tapbacks and
    # the iOS 16+ compatibility text messages ('Loved "..."' etc.).

    prev_date = None
    for msg in messages:
        amt = msg.get("associated_message_type") or 0
        if amt in TAPBACK_BAND:
            continue  # rendered as annotation on target, not standalone

        # Date separator
        msg_date = fmt_date_only(msg.get("date"))
        if msg_date != prev_date:
            lines.append(f"\n### {msg_date}\n")
            prev_date = msg_date

        # Sender + timestamp
        sender = (
            "**Me**"
            if msg["is_from_me"]
            else f"**{resolve(msg.get('sender_id') or '?')}**"
        )
        ts = fmt_ts(msg.get("date"))
        lines.append(f"{sender} · {ts}")

        # System / group events
        item_type = msg.get("item_type") or 0
        if item_type != 0:
            group_title = msg.get("group_title")
            if group_title:
                lines.append(f"*Group renamed to: {group_title}*")
            else:
                label = ITEM_TYPE.get(item_type, f"system event {item_type}")
                lines.append(f"*[{label}]*")
            lines.append("")
            continue

        # Message body — text column first, attributedBody blob as fallback
        text = (msg.get("text") or "").strip()
        blob_was_photo = False
        if not text:
            blob = msg.get("attributedBody")
            decoded = decode_attributed_body(blob)
            if decoded:
                text = decoded
            elif blob is not None:
                # Blob exists but decoded to nothing — it contained only \ufffc
                # (object-replacement char), meaning the message IS the attachment
                blob_was_photo = True
        edited = msg.get("date_edited")
        style = msg.get("expressive_send_style_id") or ""

        if text:
            rendered = render_text(text)
            if style:
                style_label = style.replace("com.apple.MobileSMS.expressivesend.", "")
                lines.append(f"*[{style_label}]*\n\n{rendered}")
            else:
                lines.append(rendered)
            if edited:
                lines.append(f"*(edited {fmt_ts(edited)})*")

        # Attachments — skip plugin payload blobs (iMessage app content)
        atts = attachments.get(msg["ROWID"], [])
        real_atts = [
            a for a in atts if not a["name"].endswith(".pluginPayloadAttachment")
        ]
        plugin_atts = [
            a for a in atts if a["name"].endswith(".pluginPayloadAttachment")
        ]
        for att in real_atts:
            mime = f" `{att['mime']}`" if att["mime"] else ""
            lines.append(f"📎 {att['name']}{mime}")
        if plugin_atts and not text and not real_atts:
            lines.append("*[iMessage app content]*")

        if not text and not real_atts and not plugin_atts:
            if blob_was_photo or msg.get("cache_has_attachments"):
                lines.append("*(photo/media)*")
            else:
                lines.append("*(no text)*")

        # Tapback annotations
        guid = msg.get("guid") or ""
        if guid in tapbacks:
            reactions = tapbacks[guid]
            reaction_str = "  ".join(f"{e} {s}" for e, s in reactions)
            lines.append(f"  › {reaction_str}")

        lines.append("")

    return "\n".join(lines)


# ── Attachment listing ───────────────────────────────────────────────────────────────


def list_attachments(con, n=20, chat_id=None):
    """Print the N largest attachments, optionally filtered to one thread."""
    cur = con.cursor()

    if chat_id:
        cur.execute(
            """
            SELECT a.ROWID, a.transfer_name, a.mime_type, a.total_bytes,
                   a.created_date, a.filename,
                   cmj.chat_id
            FROM attachment a
            JOIN message_attachment_join maj ON a.ROWID = maj.attachment_id
            JOIN chat_message_join cmj ON maj.message_id = cmj.message_id
            WHERE a.total_bytes > 0 AND cmj.chat_id = ?
            ORDER BY a.total_bytes DESC
            LIMIT ?
        """,
            (chat_id, n),
        )
    else:
        cur.execute(
            """
            SELECT a.ROWID, a.transfer_name, a.mime_type, a.total_bytes,
                   a.created_date, a.filename,
                   cmj.chat_id
            FROM attachment a
            JOIN message_attachment_join maj ON a.ROWID = maj.attachment_id
            JOIN chat_message_join cmj ON maj.message_id = cmj.message_id
            WHERE a.total_bytes > 0
            ORDER BY a.total_bytes DESC
            LIMIT ?
        """,
            (n,),
        )

    rows = cur.fetchall()
    if not rows:
        print("No attachments found.")
        return

    threads = load_threads(con)
    thread_label_map = {t["chat_id"]: thread_label(t) for t in threads}

    scope = f"thread {chat_id}" if chat_id else "all threads"
    print(f"Top {len(rows)} largest attachments ({scope}):\n")
    print(f"  {'Size':>8}  {'Date':<12}  {'Thread':<25}  {'Type':<20}  File")
    print("  " + "-" * 95)

    for row in rows:
        size_mb = row["total_bytes"] / 1_048_576
        date = fmt_date_only(row["created_date"]) if row["created_date"] else "?"
        label = thread_label_map.get(row["chat_id"], f"chat {row['chat_id']}")[:25]
        mime = (row["mime_type"] or "?")[:20]
        name = row["transfer_name"] or Path(row["filename"] or "").name or "?"
        fpath = (row["filename"] or "").replace("/var/mobile", str(Path.home()))
        print(f"  {size_mb:>7.1f}M  {date:<12}  {label:<25}  {mime:<20}  {name}")
        if fpath:
            print(f"  {'':>8}  {fpath}")


# ── Extraction entry point ────────────────────────────────────────────────────


def extract(con, chat_id, out_file=None, tail=None):
    threads = load_threads(con)
    chat_map = {t["chat_id"]: t for t in threads}

    if chat_id not in chat_map:
        sys.exit(f"Chat ID {chat_id} not found. Run --list to see available threads.")

    chat_info = chat_map[chat_id]
    messages, total = load_messages(con, chat_id, tail=tail)
    attachments = load_attachments_for_chat(con, chat_id)

    output = render_thread(
        chat_id, chat_info, messages, attachments, tail=tail, total=total
    )

    if out_file:
        Path(out_file).write_text(output, encoding="utf-8")
        print(f"Written to {out_file}")
    else:
        print(output)


# ── CLI ───────────────────────────────────────────────────────────────────────


if __name__ == "__main__":
    ap = argparse.ArgumentParser(
        prog="extract_messages",
        description="Extract iMessage threads from ~/Library/Messages/chat.db",
    )

    mode = ap.add_mutually_exclusive_group(required=True)
    mode.add_argument(
        "--list",
        nargs="?",
        const=30,
        metavar="N",
        type=int,
        help="List N most recent threads (default 30)",
    )
    mode.add_argument(
        "--id",
        type=int,
        metavar="CHAT_ID",
        help="Extract thread by chat ROWID",
    )
    mode.add_argument(
        "--name",
        metavar="STRING",
        help="Find thread(s) matching handle ID, phone, or display name (substring)",
    )
    mode.add_argument(
        "--search",
        metavar="TEXT",
        help="Search message text across all threads",
    )
    mode.add_argument(
        "--attachments",
        nargs="?",
        const=20,
        metavar="N",
        type=int,
        help="List N largest attachments across all threads, or for --chat (default 20)",
    )

    ap.add_argument(
        "--chat",
        type=int,
        metavar="CHAT_ID",
        help="Filter --attachments to a specific thread",
    )
    ap.add_argument(
        "--contacts",
        metavar="FILE",
        help=f"TSV file of handle→name mappings (default: {DEFAULT_CONTACTS})",
    )
    ap.add_argument(
        "--out", metavar="FILE", help="Write output to FILE (default: stdout)"
    )
    ap.add_argument(
        "--tail",
        type=int,
        metavar="N",
        help="Only show the last N messages of the thread",
    )
    ap.add_argument(
        "--results",
        type=int,
        default=20,
        metavar="N",
        help="Max results for --search (default: 20)",
    )

    args = ap.parse_args()
    load_contacts(Path(args.contacts) if args.contacts else DEFAULT_CONTACTS)
    con = connect()

    try:
        if args.list is not None:
            list_threads(con, n=args.list)

        elif args.id is not None:
            extract(con, args.id, out_file=args.out, tail=args.tail)

        elif args.name:
            matches = find_threads_by_name(con, args.name)
            if not matches:
                print(f"No threads found matching '{args.name}'")
            elif len(matches) == 1:
                extract(con, matches[0]["chat_id"], out_file=args.out, tail=args.tail)
            else:
                print(f"Multiple matches for '{args.name}' — pick one with --id:\n")
                for t in matches:
                    print(
                        f"  {t['chat_id']:>5}  {fmt_ts(t['last_date']):<20}  {thread_label(t)}"
                    )

        elif args.search:
            search_messages(con, args.search, n=args.results)

        elif args.attachments is not None:
            list_attachments(con, n=args.attachments, chat_id=args.chat)

    finally:
        con.close()
