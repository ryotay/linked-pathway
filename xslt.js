xslt = require('node_xslt')
var args = process.argv;
stylesheet = xslt.readXsltFile('./sbml2rdf-0.0.2.xsl');
document = xslt.readXmlFile('./sbml_sample01.xml');
transformedString = xslt.transform(stylesheet, document, []);
console.log(transformedString);
