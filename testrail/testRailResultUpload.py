import xml.etree.ElementTree as ET
tree = ET.parse('results.xml')
root = tree.findall("testcase")
for testcase in root:
    print testcase.get('name')
