linked-pathway
==============
* Setup
    $ cd $HOME  
    $ git clone https://github.com/ryotay/linked-pathway  
* RDFize CellDesigner SBML
    $ npm install node_xslt
    $ node xslt.js sbml2rdf-0.0.2.xsl sample01.xml > sample01.tmp.ttl
    $ (cat header.ttl > sample01.ttl; cat sample01.tmp.ttl | /usr/bin/sed -e "s/\//-/g" >> sample01.ttl)
