import lxml.etree as ET
#from lxml import etree

dom = ET.parse("results.xml")
xslt = ET.parse("junit-noframes.xsl")
transform = ET.XSLT(xslt)
newdom = transform(dom)
#print (transform)
#print(ET.tostring(newdom, pretty_print=True))
print(ET.tostring(newdom))
