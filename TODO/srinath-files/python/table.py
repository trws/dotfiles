from textutils import *
# import string

table1 = [['a.11', 'a.12'], ['a.21', 'a.22']]

fotable1 = FormatTable(table1, ROW_SPACE=1)

table2 = [['11', '12', '13'], 
          ['21', fotable1, '23'], 
		  ['31', '32', '33']]

fotable2 = FormatTable(table2, ROW_SPACE=1, COL_SPACE=1)

# text1 = '11 12\n21 a.11 a.12\n   a.21 a.22\n31 32'
# text2 = ' 13\n 23\n\n 33'
# 
# print VertCatString(text1, None, text2)

# print fotable1
print fotable2
