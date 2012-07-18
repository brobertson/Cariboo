#!/bin/bash
BINDIR="/home/ubuntu/Dropbox/Cariboo-Summer/bin"
TMPDIR="/tmp"
#perl -pe 's/<body>/<body lang="grc">/' $1
xsltproc  $BINDIR/grecify.xsl $1  
