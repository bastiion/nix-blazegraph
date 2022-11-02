#!/usr/bin/env sh

trap 'rm -f "$PROPFILE"' EXIT

PROPFILE=$(mktemp --suffix .properties)

cat <<EOT >> $PROPFILE
quiet=false
verbose=2
# namespace=kb
com.bigdata.journal.AbstractJournal.file=blazegraph.jnl
com.bigdata.rdf.store.AbstractTripleStore.quads=false
com.bigdata.rdf.store.AbstractTripleStore.axiomsClass=com.bigdata.rdf.axioms.OwlAxioms
#Files to load
baseURI=http://ontology.gra.one
fileOrDirs=$1
propertyFile=$PROPFILE
EOT

java -server -Xmx4g -Dcom.bigdata.rdf.sail.webapp.ConfigParams.propertyFile=$PROPFILE -Djetty.port=9999 -jar $BLAZEGRAPH_JAR
