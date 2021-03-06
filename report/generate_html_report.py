from lxml import etree

def transform(xmlPath, xslPath):
  # read xsl file
  xslRoot = etree.fromstring(open(xslPath).read())

  transform = etree.XSLT(xslRoot)

  # read xml
  xmlRoot = etree.fromstring(open(xmlPath).read())

  # transform xml with xslt
  transRoot = transform(xmlRoot)

  # return transformation result
  return etree.tostring(transRoot,pretty_print=True)

if __name__ == '__main__':
  print(transform('./results.xml', 'report_template.xsl'))
