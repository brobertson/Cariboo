#!/bin/bash
BINDIR="/home/ubuntu/Dropbox/Cariboo-Summer/bin"
TMPDIR="/tmp"
TEI2EPUBDIR="/home/ubuntu/Dropbox/Cariboo-Summer/tei2epub"
short=$(basename $1)
filename=${short%.*}
extension=${short##*.}
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
xsltproc  $BINDIR/grecify.xsl $1 > $grecified
java -classpath $BINDIR/lib -jar $BINDIR/transcoder-1.1-SNAPSHOT.jar -s $grecified -o ${unicode} -se BetaCode -oe UnicodeC
#$BINDIR/transcode_perseus_tei.sh $grecified $unicode
echo "Converting from P4 TEI to P5..."
xsltproc $BINDIR/p4top5.xsl $unicode > $p5
echo "Creating EPUB Document..."
$TEI2EPUBDIR/bin/tei2epub.py $p5 ${filename} 
#echo "Creating image for $1 from $2" 
#echo "Grabbing author and title from xml..."
#author=`xsltproc author.xsl $1 | tail -1`; 
#title=`xsltproc title.xsl $1 | tail -1`;
#title=${title/Machine readable text/}  
#filename=$(basename $1)
#filename=${filename%.*}
#echo "Now making image..."
#convert "$2" -font Helvetica-Bold -fill black -pointsize 30 -annotate +40+400 "$author" ${filename}_cover_temp.jpg
#convert -background white -fill black -font Helvetica-BoldOblique -pointsize 30 -size 320x -gravity West caption:"$title" ${filename}_title_temp.jpg
#convert -composite ${filename}_cover_temp.jpg ${filename}_title_temp.jpg -geometry +40+412 ${filename}_cover.jpg
#rm ${filename}_title_temp.jpg
#rm ${filename}_cover_temp.jpg
#echo "Creating MOBI Document..."
#ebook-convert ${filename}.epub ${filename}.mobi
echo "Done conversion of $1"
