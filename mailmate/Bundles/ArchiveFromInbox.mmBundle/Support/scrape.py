#!/usr/bin/python3
import json
import sys
import logging
import argparse
import platform

p = argparse.ArgumentParser("scrape", description="translate ID/mailbox into actions")
p.add_argument("-f", "--flag", help="add flag")
p.add_argument("-r", "--remove-flag", help="remove flag")
p.add_argument("-a", "--archive", help="archive emails", action="store_true")
args = p.parse_args(sys.argv[1:])

logging.basicConfig(filename="/tmp/mmfilter", level=logging.INFO, filemode="w")
log = logging.getLogger("filter")


if platform.node().startswith('abrams'):
    mbox =  "imap://scogland1%40llnl.gov@localhost/"
else:
    mbox = "imap://scogland1%40llnl.gov@outlook.office365.com/"

targets = {
    "INBOX": "Archive",
    "screen": "Archive",
    "feed": "feed/archive",
    "News": "feed/archive",
    "paper_trail": "paper_trail/archive",
    "feed/by_subject": "feed/by_subject_archive",
    "feed/by_to": "feed/by_to_archive",
    "paper_trail/by_subject": "paper_trail/by_subject_archive",
    "paper_trail/by_to": "paper_trail/by_to_archive",
}

log.info("starting filter")
# list of id, target tuples
ids = []
for l in sys.stdin:
    message_id, box = l.split(":^:")
    log.info("got: %s and %s", message_id, box)
    box = box.strip(' \n"')
    message_id = message_id.strip(' \n"')
    if box in targets.keys():
        #log.info("appending: %s", message_id)
        ids.append((int(message_id), targets[box]))
actions = []
for mid, tgt in ids:
    if args.archive:
        actions.append(
            {
                "type": "moveMessage",
                "mailbox": mbox + tgt,
                "ids": [mid],
            }
        )
    if args.flag:
        actions.append({"type": "changeFlags", "enable": ["\\Flagged"], "ids": [mid]},)
if not actions:
    sys.exit(0)
out = {
    "actions": actions,
}
print(json.dumps(out))
    #log.info("actions: %s", out)
    # print(json.dumps(out), file=open("/tmp/meh",'w'))
