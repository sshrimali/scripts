import libxml2
import libxslt

styledoc = libxml2.parseFile("junit-noframes.xsl")
style = libxslt.parseStylesheetDoc(styledoc)
doc = libxml2.parseFile("results.xml")
result = style.applyStylesheet(doc, None)
style.saveResultToFilename("foo", result, 0)
style.freeStylesheet()
doc.freeDoc()
result.freeDoc()
