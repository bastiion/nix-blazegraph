#!/usr/bin/env sh

trap 'rm -f "$PROPFILE"' EXIT

PROPFILE=$(mktemp --suffix .properties)

cat <<EOT >> $PROPFILE
quiet=false
verbose=2
# False prevents renaming loaded datasets with extension .good or .fail
durableQueues=false
# namespace=kb
com.bigdata.journal.AbstractJournal.file=blazegraph.jnl
com.bigdata.rdf.store.AbstractTripleStore.quads=false
com.bigdata.rdf.store.AbstractTripleStore.axiomsClass=com.bigdata.rdf.axioms.NoAxioms
#Files to load
baseURI=http://ontology.gra.one
propertyFile=$PROPFILE
EOT

java -Xmx6g -cp $BLAZEGRAPH_JAR com.bigdata.rdf.sail.ExportKB -outdir $1 -format N-Quads $PROPFILE

