#!/usr/bin/python3
import re
from urllib.parse import urlparse, parse_qs, unquote
import sys

for input_url in sys.stdin:
    prev = ""
    while "urldefense" in input_url and prev != input_url:
        prev = input_url
        u = urlparse(input_url)
        # print(u)

        if u.query:  # there is a query
            q = parse_qs(u.query)
            # print(q)
            if q.get("u"):
                input_url = unquote(q["u"][0].replace("-", "%").replace("_", "/"))
                continue

        input_url = re.sub("^.*?__", "", u.path)
        input_url = re.sub("__.*$", "", input_url)
        input_url = re.sub(r"\*", "#", input_url)

        # print(u.path)

    print(input_url)
