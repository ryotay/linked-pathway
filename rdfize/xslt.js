xslt = require('node_xslt')
var args = process.argv;
stylesheet = xslt.readXsltFile(args[2]);
document = xslt.readXmlFile(args[3]);
transformedString = xslt.transform(stylesheet, document, []);
console.log(transformedString);
