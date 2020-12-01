#!/usr/bin/python3
import json
import sys
# import logging
import argparse

p = argparse.ArgumentParser("scrape", description="translate ID/mailbox into actions")
p.add_argument("-f", "--flag", help="add flag")
p.add_argument("-r", "--remove-flag", help="remove flag")
p.add_argument("-a", "--archive", help="archive emails", action="store_true")
args = p.parse_args(sys.argv[1:])

#logging.basicConfig(filename="/tmp/mmfilter", level=logging.ERROR, filemode="w")
#log = logging.getLogger("filter")


#log.info("starting filter")
ids = []
for l in sys.stdin:
    message_id, box = l.split(":^:")
    #log.info("got: %s and %s", message_id, box)
    box = box.strip(' \n"')
    message_id = message_id.strip(' \n"')
    if box == "INBOX":
        #log.info("appending: %s", message_id)
        ids.append(message_id)
if ids:
    ids = [int(s) for s in ids]
    actions = []
    if args.archive:
        actions.append(
            {
                "type": "moveMessage",
                "mailbox": "imap://scogland1%40llnl.gov@localhost/Archive",
                "ids": ids,
            }
        )
    if args.flag:
        actions.append({"type": "changeFlags", "enable": ["\\Flagged"], "ids": ids},)
    if not actions:
        sys.exit(0)
    out = {
        "actions": actions,
    }
    print(json.dumps(out))
    #log.info("actions: %s", out)
    # print(json.dumps(out), file=open("/tmp/meh",'w'))
