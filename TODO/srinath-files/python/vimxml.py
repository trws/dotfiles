import vimformat
import xml.dom.minidom
import string
import re

# Okay. so I import *. Shoot me.
from textutils import *
from domutils import *

################################################################################
# Generalized function for handling dom elements.
################################################################################
# IsInlineTag(self): {{{
def IsInlineTag(self):
    if self.nodeType == self.TEXT_NODE \
        or (
            self.nodeType == self.ELEMENT_NODE and
            inlineTags.get(self.tagName, 0)
           ):
        return 1
    else:
        return 0


# }}}
# getChildrenByTagName(self, name): {{{
# Description: extension to the xml.dom.minidom.Element class.
#              returns all direct descendants of this Element.
def getChildrenByTagName(self, name):
    nodeList = []

    child = self.firstChild
    while not child.nextSibling is None:
        if child.nodeType == child.ELEMENT_NODE and child.nodeName == name:
            nodeList.append(child)

        child = child.nextSibling

    return nodeList

xml.dom.minidom.Element.getChildrenByTagName = getChildrenByTagName

# }}}
# handleElement(rootElement, width=vimformat.TEXT_WIDTH): {{{
def handleElement(rootElement, width=vimformat.TEXT_WIDTH, strict=0):
    """
    handleElement(rootElement, width=vimformat.TEXT_WIDTH):

    Generalized function to handle an Element node in a DOM tree.
    """
    
    if rootElement.hasAttributes():
        print "This element has attributes"
        print rootElement.attributes

    retText = ""
    child = rootElement.firstChild
    while not child is None:

        # if the child is an Element and if a handler exists, then call it.
        if not IsInlineTag(child):
            if handlerMaps.has_key(child.tagName):
                # offset the child text by the current indentation value
                retText += handlerMaps[child.tagName](child, width)

            child = child.nextSibling

        # if its a text node, collect consecutive text nodes into a single
        # paragraph and indent it.
        elif IsInlineTag(child):

            text = ""
            while not child is None and IsInlineTag(child):
                if child.nodeType == child.TEXT_NODE:
                    text += child.data
                elif child.nodeType == child.ELEMENT_NODE:
                    if handlerMaps.has_key(child.tagName):
                        text += handlerMaps[child.tagName](child, width)
                    else:
                        text += GetText(child.childNodes)
                child = child.nextSibling

            retText += IndentParagraphs(text, width)

    # return IndentParagraphs(retText, width)
    return retText

# }}}

################################################################################
# Functions for handling various xml tags
################################################################################
# handleOption(option, width): {{{
def handleOption(option, width):
    retText = ""
    names = GetTextFromElementNode(option, "name")

    for name in names:
        retText += string.rjust("*"+name+"*", width) + "\n"

    nameTexts = ""
    maxNameLen = -1
    for name in names:
        maxNameLen = max(maxNameLen, len(name + "    "))
        nameTexts += name + "    \n"

    desc = option.getChildrenByTagName("desc")[0]
    descText = handleElement(desc, width=width-maxNameLen)

    retText += VertCatString(nameTexts + "    ", None, descText)

    return retText + "\n"

# }}}
# handleOptionDefault(default, width): {{{
def handleOptionDefault(default, width):
    type = string.join(GetTextFromElementNode(default, "type"), "\n")
    extra = string.join(GetTextFromElementNode(default, "extra"), "\n")
    return type + "\t(" + extra + ")"

# }}}
# handleTable(root, width): {{{
def handleTable(root, width):
    """
    dom_HandleTable(root)

    Given a Element instance, handles the table inside of it.
    """

    # First calculate how many columns are large... i.e occupy more than
    # width/cols wide space.
    maxwidths = {}
    text = []
    rows = root.getChildrenByTagName("row")
    for row in rows:
        cols = row.getChildrenByTagName("col")

        rowtext = []
        colwidths = []
        for col in cols:
            coltext = handleElement(col, width)
            rowtext.append(coltext)

            # This is the 'width' of the current cell including the
            # whitespace padding.
            colwidths.append(max(map(len, coltext.split("\n"))) \
                                + vimformat.COL_SPACE)

        text.append(rowtext)
        # update the widths of the columns by finding the maximum
        # width of all cells in this column.
        for i in range(len(colwidths)):
            maxwidths[i] = max(colwidths[i], maxwidths.get(i, -1))

    # now find out how many columns exceed the maximum permitted width.
    # nlarge: number of columns which are too wide.
    # remainingWidth: width which these large columns can share.
    nlarge = 0
    remainingWidth = width
    for colwidth in maxwidths.values():
        if colwidth > width/len(maxwidths):
            nlarge += 1
        else:
            remainingWidth += -colwidth

    # newmaxwidth: width which each of the large columns is allowed.
    newmaxwidth = remainingWidth/max(nlarge, 1)

    # make another run and this time ask each cell to restrict itself to
    # newmaxwidth as calculated above.
    text = []
    rows = root.getChildrenByTagName("row")
    for row in rows:
        cols = row.getChildrenByTagName("col")
        # print "finding %d columns" % len(cols)

        rowtext = []
        for col in cols:
            coltext = handleElement(col, newmaxwidth)

            rowtext.append(coltext)
            # print "rowtext = [%s]" % rowtext

        text.append(rowtext)

    # finally, generate the table.
    retText = FormatTable(text, ROW_SPACE = 1, 
                          COL_SPACE = vimformat.COL_SPACE, justify=0)
    return retText

# }}}
# handleCode(code, width): {{{
def handleCode(code, width):
    retText =  GetText(code.childNodes)
    return " >\n" + VertCatString("    ", 4, retText) + "\n&codeend;"


# }}}
# handleList(list, width, marker=0): {{{
def handleList(list, width, marker=0):
    retText = ""
    items = list.getChildrenByTagName("item")
    for item in items:
        itemText = handleElement(item, width - len("- "))
        itemText = VertCatString("- ", None, itemText)

        retText += itemText + "\n"

    return retText

# }}}
# handleNote(note, width): {{{
def handleNote(note, width):
    noteText = handleElement(note, width-len("NOTE: "))
    noteText = VertCatString("NOTE: ", None, noteText)

    return noteText

# }}}
# handleLineBreak(lbr, width): {{{
def handleLineBreak(lbr, width):
    return "\n"

# }}}
# handleParBreak(parbrk, width): {{{
def handleParBreak(parbrk, width):
    return "\n\n"

# }}}
# handleParagraph(paragraph, width): {{{
def handleParagraph(paragraph, width):
    partext = handleElement(paragraph, width, strict=0)

    partext = re.sub(r'\n+$', '', partext)
    partext = re.sub(r'^\n+', '', partext)

    return partext + "\n\n"

# }}}
# handleBlockQuote(block, width): {{{
def handleBlockQuote(block, width):
    text = handleElement(block, width - vimformat.BLOCK_QUOTE)
    text = VertCatString(" "*vimformat.BLOCK_QUOTE,  \
                         vimformat.BLOCK_QUOTE, text)

    return text

# }}}
# handleTag(tag, width): {{{
def handleTag(tag, width):
    text = GetText(tag.childNodes)

    return '|' + text + '|'

# }}}
# handleLinks(links, width): {{{
def handleLinks(links, width): 
    text = ''
    for link in getChildrenByTagName(links, 'link'):
        text += '*' + GetText(link.childNodes) + '*' + ' '

    text = IndentParagraphs(text, width/2)
    return RightJustify(text, width) + "\n"

# }}}
# handleLink(link, width): {{{
def handleLink(link, width):
    text = '*' + GetText(link.childNodes) + '*'

    return text.rjust(vimformat.TEXT_WIDTH) + "\n"

# }}}
# handleSection(section, width): {{{
def handleSection(section, width):
    title = section.getChildrenByTagName('sectiontitle')[0]
    name = GetTextFromElementNode(title, 'name')[0]
    tags = GetTextFromElementNode(title, 'tag')

    tagsformatted = ''
    for tag in tags:
        tagsformatted = tagsformatted + '*' + tag + '* '

    tagsformatted = IndentParagraphs(tagsformatted, 20)
    name = name + " "*(58 - len(name))

    header = VertCatString(name, None, tagsformatted)

    text = handleElement(section, width)

    return "\n\n" + "="*vimformat.TEXT_WIDTH + "\n" + header + "\n\n" + text

# }}}

################################################################################
# A dictionary for mapping xml tags to functions.
#
# TODO: Ideally, each function would be responsible for registering itself
################################################################################
handlerMaps = {
    'file': handleElement,
    'option': handleOption,
    'optionDefault': handleOptionDefault,
    'table': handleTable,
    'code': handleCode,
    'programlisting': handleCode,
    'list': handleList,
    'linebreak': handleLineBreak,
    'par': handleParBreak,
    'para': handleParagraph,
    'br': handleLineBreak,
    'note': handleNote,
    'tag': handleTag,
    'links': handleLinks,
    'link': handleLink,
    'section': handleSection,
    'blockquote': handleBlockQuote,
}
inlineTags = {'tag':1}

# vim:et:sts=4:fdm=marker
