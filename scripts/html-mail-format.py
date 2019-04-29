#!/usr/bin/env python3
import re
import sys
import html2text

if len(sys.argv) > 1 and sys.argv[1] != '-':
    s = open(sys.argv[1], 'r').read()
else:
    s = sys.stdin.read()

# remove stupid MS tags
s = re.sub('</?o:[^>]*>','',s)

text_maker = html2text.HTML2Text()
text_maker.body_width = 0
text_maker.unicode_snob = True
text_maker.wrap_links = False
text_maker.protect_links = True
text_maker.images_with_size = True
text_maker.single_line_break = True

md = text_maker.handle(s)
final = re.sub(r'^(\s*)[*]*(From|Sent|Date|To|Cc|Subject):[*]*', r'\1\2:', md, flags=re.MULTILINE)
print(final)

# add a prefix space to make mutt play nice
# for l in text_maker.handle(s).splitlines():
#     if len(l) == 0:
#         print()
#         continue
#     m = re.match('^((\s*[>]\s*)*)', l)
#     if m:
#         # print ("group", m.group(1))
#         tw = textwrap.TextWrapper(subsequent_indent=m.group(1), width=88)
#         for il in tw.wrap(l):
#             print(" ", il, sep='')
#     else:
#         print(" ", l, sep='')
#
