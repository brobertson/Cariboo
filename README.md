
Cariboo
=======

Linux tools to convert Perseus TEI P4 documents into epub files.

<b>Bug Report:</b>

A full list of which documents are affecting by which bugs can be found here: https://docs.google.com/spreadsheet/ccc?key=0Aokb5XTFASILdGkwaTF4aUtQbGhKMkllenlSSVcwNnc

<i>NO CONTENT:</i>

In some of the documents there exists only a cover and flyleaf, without any content of the text itself. So far it seems to be due to a lack of div tags within the xml document. If we can insert a line of code within tei2epub which asks it to insert a generic div tag surrounding the text, this should solve the issue. 

<i>REPEATED CHAPTERS:</i>

Once again due to div tags, chapters are being repeated throughout the epub document. The issue here lies in the separation of the document into individual html files. Tei2epub is obviously coded to create an html file for every div. However, when divs are nested into one another, it begins to repeat itself. For example, if a text look like this:


&lt;div&gt;
&lt;div&gt;
Hello! My name is George!
&lt;/div&gt;
&lt;div&gt;
I work in a shoe factory.
&lt;/div&gt;
&lt;div&gt; 
I have three children. 
&lt;div&gt; Their names are Sarah, John and Mark. &lt;/div&gt;
&lt;/div&gt;
&lt;/div&gt;


The final document would appear:

Hello! My name is George.
I work in a shoe factory.
I have three children. 
Their names are Sarah, John and Mark.
I work in a shoe factory.
I have three children.
Their names are Sarah, John and Mark.
Their names are Sarah, John and Mark.

I have the following code, which should fix the issue:


&lt;xsl:if test="not(ancestor::div)"&gt;
&lt;/xsl:if&gt;


If we can find exactly where the html files are being created, we should be able to slip this in and fix the issue.

<i>PAGEBREAKS:</i>

In many documents only a few lines/words are appearing on each page when viewed. While I'm not entirely d=sure why this is happening, it is likely due to either a paragraphing issue in the xml itself or another issue with generic div tags.

<i>NO TOC:</i>

This is not so much a bug as it is a formatting choice. We have written into tei2epub that certain Dramas should not have any sort of TOC. This was originally due to a titling issue wherein chapters were made every few lines with names such as "episode etc.". While we may wish to edit this later, this has been documented for us to distinguish between those that are affected by this code and those that aren't. 

<i>NO AUTHOR:</i>

This could be simply due to the fact that we do not yet know the author of a work and therefore it is unlisted. However, in case this is due to an issue with the program it has been documented. 

<i>EXCESS BOLD:</i>

In these documents the first few pages are entirely bolded as if they were being read as a heading by tei2epub. It is possible this is because the text is in fact coded as a heading and serves an intended purpose. Since I don't know which of these are intended and which are not, all have been recorded in the linked chart. 

<i>AUTHOR RUNS OFF:</i>

Occasionally, the author's name is so long that it does not fit on the cover image. To fix this we simply need to define a maximum size for the authors name and code it to resize the text to fit. These edits should be found in the included bash script which creates the cover image. 

<i>TITLE RUNS OFF:</i>

In this case, much like the author, the title occasionally is simply too long to fit on the cover image. The same code which would fix this bug for the author's name should be applied to the title as well. 

<i>TEXT IN LINE-NUMBERS:</i>

Within the text itself very rarely it seems to incorporate large sections of text into the css for line-numbers, changing its colour and orientation. These seem very unique and may be attributed to malformed xml code. 

<i>ODD TOC TITLES:</i>

In some of the Tables of Contents, the listed titles are slightly longer and look peculiar. Someone with knowledge for the texts may be able to recognize if these are intended or simple a bug that needs to be addressed. 

<i>'MACHINE READABLE TEXT':</i>

This text, while eliminated from the cover titles, still appears in the document title under the <title> element, meaning on devices it is still listed with this text included. This needs to be removed so that it does not appear in the official title for the epub.
