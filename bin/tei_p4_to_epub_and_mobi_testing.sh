#!/bin/bash
BINDIR="/home/ubuntu/Cariboo/bin"
TMPDIR="/tmp"
TEI2EPUBDIR=$BINDIR/tei2epub
TEI2EPUBBUILD=/tmp/tei2epubBuild
#TEI2EPUBDIR=/media/sda3/Summer_Work_Tine/Summer_Work_Backup/Cariboo-Summer/tei2epub
COVERIMAGE="/home/ubuntu/Cariboo/Covers/Cariboo-cover.jpg"
XML_CATALOG_FILES="/home/ubuntu/Cariboo/bin/lib/xmlcatalog.xml"
short=$(basename $1)
filename=${short%.*}
extension=${short##*.}
mkdir $TEI2EPUBBUILD
echo "Converting $1 to epub document ./$filename.epub"
#echo $short
#echo $filename
#echo $extension
grecified=$TMPDIR/${filename}_gr_1.xml
unicode=$TMPDIR/${filename}_gr_unic_2.xml
p5=$TMPDIR/${filename}_gr_unic_p5_3.xml
epub=$TMPDIR/${filename}.epub
echo "Generating unicode TEI..."
#perl -pe 's/<body>/<body lang="grc">/' $1 > $grecified
XML_CATALOG_FILES=$XML_CATALOG_FILES xsltproc  $BINDIR/grecify.xsl $1 > $grecified
java -classpath $BINDIR/lib -jar $BINDIR/transcoder-1.1-SNAPSHOT.jar -s $grecified -o ${unicode} -se BetaCode -oe UnicodeC
#$BINDIR/transcode_perseus_tei.sh $grecified $unicode
echo "Converting from P4 TEI to P5..."
XML_CATALOG_FILES=$XML_CATALOG_FILES xsltproc $BINDIR/p4top5.xsl $unicode > $p5
echo "Creating EPUB Document $p5"
$TEI2EPUBDIR/bin/tei2epub.py $p5 ${filename} 
mv ${filename} $TEI2EPUBBUILD/${filename}
echo "Creating image for $1 from $2" 
echo "Grabbing author and title from xml..."
XML_CATALOG_FILES=$XML_CATALOG_FILES author=`XML_CATALOG_FILES=$XML_CATALOG_FILES xsltproc $BINDIR/author.xsl $1 | tail -1`; 
XML_CATALOG_FILES=$XML_CATALOG_FILES title=`XML_CATALOG_FILES=$XML_CATALOG_FILES xsltproc $BINDIR/title.xsl $1 | tail -1`;
title=${title/Machine readable text/}  
echo "Now making image..."
convert "$COVERIMAGE" -font Helvetica-Bold -fill black -pointsize 30 -annotate +44+460 "$author" $TMPDIR/${filename}_cover_temp.jpg
convert -background white -fill black -font Helvetica-BoldOblique -pointsize 30 -size 320x -gravity West caption:"$title" $TMPDIR/${filename}_title_temp.jpg
convert -composite $TMPDIR/${filename}_cover_temp.jpg $TMPDIR/${filename}_title_temp.jpg -geometry +43+472 $TMPDIR/${filename}_cover.jpg
rm $TMPDIR/${filename}_title_temp.jpg
rm $TMPDIR/${filename}_cover_temp.jpg
echo "Uncompressing Epub for modification ..."
$BINDIR/unepub-me $TEI2EPUBBUILD/${filename}.epub
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
$BINDIR/epub-me $TEI2EPUBBUILD/${filename} 
rm -rf $TEI2EPUBBUILD/${filename}
echo "Creating MOBI Document..."
ebook-convert $TEI2EPUBBUILD/${filename}.epub $TEI2EPUBBUILD/${filename}.mobi
echo "Done conversion of $1"
