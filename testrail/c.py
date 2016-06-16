import xml.etree.ElementTree as ET
tree = ET.parse('results.xml')
root = tree.getroot()

for child in root:
	print child.tag
