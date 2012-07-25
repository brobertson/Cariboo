#!/bin/bash
BINDIR="$HOME/Cariboo/bin"
TMPDIR="/tmp"
TEI2EPUBDIR=$BINDIR/tei2epub
TEI2EPUBBUILD=/tmp/tei2epubBuild
#TEI2EPUBDIR=/media/sda3/Summer_Work_Tine/Summer_Work_Backup/Cariboo-Summer/tei2epub
COVERIMAGE="$HOME/Cariboo/Covers/Cariboo-cover.jpg"
XML_CATALOG_FILES="$HOME/Cariboo/bin/lib/xmlcatalog.xml"

while [ $# -ne 0 ]
do
echo "Processing File $#: $1 ..."
echo "Replacing '.' in original filename..."
cleanname=${1//./_}
short=$(basename $cleanname)
filename=${short%.*}
extension=${short##*.}
if [ ! -d $TEI2EPUBBUILD ]; then
mkdir $TEI2EPUBBUILD
fi
echo "Converting $cleanname to epub document ./$filename.epub"
grecified=$TMPDIR/${filename}_gr_1.xml
unicode=$TMPDIR/${filename}_gr_unic_2.xml
p5=$TMPDIR/${filename}_gr_unic_p5_3.xml
epub=$TMPDIR/${filename}.epub
echo "Generating unicode TEI..."
XML_CATALOG_FILES=$XML_CATALOG_FILES xsltproc  $BINDIR/grecify.xsl $1 > $grecified
java -classpath $BINDIR/lib -jar $BINDIR/transcoder-1.1-SNAPSHOT.jar -s $grecified -o ${unicode} -se BetaCode -oe UnicodeC
echo "Converting from P4 TEI to P5..."
XML_CATALOG_FILES=$XML_CATALOG_FILES xsltproc $BINDIR/p4top5.xsl $unicode > $p5
echo "Creating EPUB Document $p5"
PATH=$PATH:$BINDIR $TEI2EPUBDIR/bin/tei2epub.py $p5 ${filename} 
rm -rf $TEI2EPUBBUILD/${filename}
mv ${filename}.epub $TEI2EPUBBUILD/${filename}.epub
echo "Creating image for $cleanname" 
echo "Grabbing author and title from xml..."
XML_CATALOG_FILES=$XML_CATALOG_FILES author=`XML_CATALOG_FILES=$XML_CATALOG_FILES xsltproc $BINDIR/author.xsl $1 | tail -1`; 
XML_CATALOG_FILES=$XML_CATALOG_FILES title=`XML_CATALOG_FILES=$XML_CATALOG_FILES xsltproc $BINDIR/title.xsl $1 | tail -1`;
title=${title/Machine readable text/}  
echo "Now making image..."
convert "$COVERIMAGE" -font Helvetica -fill black -pointsize 100 -annotate +44+900 "$author" $TMPDIR/${filename}_cover_temp.jpg
convert -background '#BB9E26' -fill black -font Helvetica-Oblique -pointsize 100 -size 890x -gravity West caption:"$title" $TMPDIR/${filename}_title_temp.jpg
convert -composite $TMPDIR/${filename}_cover_temp.jpg $TMPDIR/${filename}_title_temp.jpg -geometry +43+972 $TMPDIR/${filename}_cover.jpg
rm $TMPDIR/${filename}_title_temp.jpg
rm $TMPDIR/${filename}_cover_temp.jpg
echo "Uncompressing Epub for modification ..."
PATH=$PATH:$BINDIR $BINDIR/unepub-me $TEI2EPUBBUILD/${filename}.epub
echo "Processing content.opf..."
XML_CATALOG_FILES=$XML_CATALOG_FILES xsltproc $BINDIR/modify_content.xsl $TEI2EPUBBUILD/${filename}/OEBPS/content.opf >  $TMPDIR/${filename}_new_content.opf
echo "Creating flyleaf ..."
XML_CATALOG_FILES=$XML_CATALOG_FILES xsltproc $BINDIR/flyleaf.xsl $1 > $TMPDIR/${filename}_chapter-01.html
echo "Putting new content in epub filestructure ..." 
cp $TMPDIR/${filename}_new_content.opf $TEI2EPUBBUILD/${filename}/OEBPS/content.opf
cp $TMPDIR/${filename}_cover.jpg $TEI2EPUBBUILD/${filename}/OEBPS/cover.jpg
cp $BINDIR/lib/EpubFiles/* $TEI2EPUBBUILD/${filename}/OEBPS/
cp $TMPDIR/${filename}_chapter-01.html $TEI2EPUBBUILD/${filename}/OEBPS/chapter-01.html
echo "Recompressing epub archive ..."
PATH=$PATH:$BINDIR $BINDIR/epub-me $TEI2EPUBBUILD/${filename} 
rm -rf $TEI2EPUBBUILD/${filename}
echo "Deleting temp files ..."
rm $grecified
rm $unicode
rm $p5
#echo "Creating MOBI Document..."
#ebook-convert $TEI2EPUBBUILD/${filename}.epub $TEI2EPUBBUILD/${filename}.mobi
echo "Done conversion of $1"
shift 
done
