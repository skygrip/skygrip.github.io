---
layout: post
title: 'Investigating the redaction techniques in the Mueller Report: Part 1'
DateTime: 2020-11-23 17:00:00 +1100
feature-img: "assets/img/pexels/book-glass.jpeg"
thumbnail: "assets/img/pexels/book-glass.jpeg"
tags:
    - Cyber Security
    - Cyber Intelligence
    - Forensics and Incident Response
---

The Mueller Report was released a few years ago now to great controversy about the large amounts of redaction used within the report. Im using this as an excuse to explore PDF file formats to see how effective the redaction's are, and the kind of techniques your redaction system needs to address if you wish to keep your secrets hidden.

Ultimately the redaction methods used in this report were thankfully robust. Were they not robust i would not be writing about them at all!

There are two versions of the Mueller Report released at different times. The first version was released as a scanned version of the printed report, and the second was a much smaller size digital version.

If you are new to PDF documents, have a read of my introduction to PDF files [here](/2020/05/01/Understanding-PDF-Files.html)

The First version of the report
-------------------------------

The first place to look is File Metadata. This information is often forgotten and is especially relevant as it often contains the creation date and the program that created it. Then we will look at some basic information about file structure, mainly the number of images.

Let's start with looking at the first version of the report with the command pdfinfo, then listing the number of embedded image files with pdfimages, and finally the types of objects in the PDF file with pdfid.

    ~/Downloads % pdfinfo MuellerReport1.pdf
    Title:          
    Creator:        RICOH MP C6502
    Producer:       RICOH MP C6502
    CreationDate:   Thu Apr 18 08:23:21 2019 AEST
    ModDate:        Thu Apr 18 08:59:41 2019 AEST
    Tagged:         no
    UserProperties: no
    Suspects:       no
    Form:           AcroForm
    JavaScript:     no
    Pages:          448
    Encrypted:      no
    Page size:      792 x 612 pts (letter)
    Page rot:       270
    File size:      145,509,755 bytes
    Optimized:      yes
    PDF version:    1.6

    ~/Downloads % pdfimages -list MuellerReport1.pdf
    page   num  type   width height color comp bpc  enc interp  object ID x-ppi y-ppi size ratio
    --------------------------------------------------------------------------------------------
       1     0 image    2200  1700  rgb     3   8  jpeg   no      2382  0   259   155  111K 1.0%
       2     1 image    2200  1700  rgb     3   8  jpeg   no         3  0   259   155 73.7K 0.7%
       3     2 image    2200  1700  rgb     3   8  jpeg   no         7  0   259   155  266K 2.4%
       4     3 image    2200  1700  rgb     3   8  jpeg   no        11  0   259   155  278K 2.5%
       5     4 image    2200  1700  rgb     3   8  jpeg   no        15  0   259   155  265K 2.4%
       6     5 image    2200  1700  rgb     3   8  jpeg   no        19  0   259   155  273K 2.5%
       7     6 image    2200  1700  rgb     3   8  jpeg   no        23  0   259   155  244K 2.2%
       8     7 image    2200  1700  rgb     3   8  jpeg   no        27  0   259   155 73.5K 0.7%
       9     8 image    2200  1700  rgb     3   8  jpeg   no        31  0   259   155  392K 3.6%
      10     9 image    2200  1700  rgb     3   8  jpeg   no        35  0   259   155  346K 3.2%
      ....

      ~/Downloads % ~/Build/pdf-tools/pdfid.py MuellerReport1.pdf
      PDFiD 0.2.7 MuellerReport1.pdf
       PDF Header: %PDF-1.6
       obj                 1803
       endobj              1802
       stream              1352
       endstream           1352
       xref                   0
       trailer                0
       startxref              2
       /Page                448
       /Encrypt               0
       /ObjStm              452
       /JS                    2
       /JavaScript            0
       /AA                    2
       /OpenAction            0
       /AcroForm              1
       /JBIG2Decode           0
       /RichMedia             0
       /Launch                0
       /EmbeddedFile          0
       /XFA                   0
       /URI                   0
       /Colors > 2^24         0

The report was scanned by a RICOH MP C6502 multifunction printer, and every page is single image. There is no JavaScript objects (The 2 JS objects are false positives). From a view of the image quality of the scan, its clear the redaction was done digitally and then printed.

Printing out a digitally redacted version and then scanning it back in is a pretty robust way to avoid any metadata being disclosed. While it does break a lot of features such as keyword search or copy paste, and results in a horridly large PDF file, if you don't have the time or resources to validate your redaction process works, this will always be a good option.

The Second version of the Report
--------------

The second report however is a fraction of the size and appears to be a fully digital version, with searchable text. This copy does provide some potential artifacts, but it will require digging around in the depths of the PDF format.

First lets look at the files metadata.

    ~/Downloads % pdfinfo MuellerReport2.pdf
    Title:          Report on the Investigation into Russian Interference in the 2016 Presidential Election
    Subject:        Investigation into Russian Interference in the 2016 Presidential Election
    Keywords:       2016 Presidential Election; Special Counsel; U.S. Department of Justice; Robert S. Mueller;
    Author:         Special Counsel’s Office
    Creator:        Adobe Acrobat Pro DC 19.12.20036
    Producer:       Adobe Acrobat Pro DC 19.12.20036
    CreationDate:   Fri Aug 30 03:13:28 2019 AEST
    ModDate:        Wed Sep  4 03:22:42 2019 AEST
    Tagged:         yes
    UserProperties: no
    Suspects:       no
    Form:           AcroForm
    JavaScript:     no
    Pages:          448
    Encrypted:      no
    Page size:      612 x 792 pts (letter)
    Page rot:       0
    File size:      11,446,226 bytes
    Optimized:      no
    PDF version:    1.7

Now lets look at the embedded images

    ~/Downloads % pdfimages -list MuellerReport2.pdf
    page   num  type   width height color comp bpc  enc interp  object ID x-ppi y-ppi size ratio
    --------------------------------------------------------------------------------------------
      28     0 image    1430   587  index   1   8  image  no       163  0   300   301  972B 0.1%
      39     1 image     566   911  rgb     3   8  image  no       271  0   300   300  527K  35%
      42     2 image     710  1002  rgb     3   8  image  no       308  0   300   300 1491K  72%
      94     3 image     699   394  rgb     3   8  jpeg   no       715  0   140   151 61.5K 7.6%
      99     4 image    1328   745  rgb     3   8  jpeg   no       734  0   216   247  121K 4.2%
     100     5 image     591   873  index   1   8  image  no       739  0   160   181  102K  20%
     121     6 image    1987   502  rgb     3   8  jpeg   no       883  0   300   300  138K 4.7%
     397     7 image    1704  2200  gray    1   1  ccitt  no      2151  0   201   200 26.0K 5.7%
     427     8 image    1700  2200  rgb     3   8  jpeg   no      2406  0   200   200  254K 2.3%
     428     9 image    1725  2221  rgb     3   8  jpeg   no      2414  0   200   200  219K 2.0%
     429    10 image    1721  2217  rgb     3   8  jpeg   no      2423  0   200   200  276K 2.5%
     430    11 image    1700  2200  rgb     3   8  jpeg   no      2433  0   200   200  329K 3.0%
     431    12 image    1700  2200  rgb     3   8  jpeg   no      2443  0   200   200  292K 2.7%
     432    13 image    1700  2200  rgb     3   8  jpeg   no      2451  0   200   200  267K 2.4%
     433    14 image    1721  2217  rgb     3   8  jpeg   no      2461  0   200   200  230K 2.1%
     434    15 image    1725  2221  rgb     3   8  jpeg   no      2471  0   200   200  243K 2.2%
     435    16 image    1700  2200  rgb     3   8  jpeg   no      2480  0   200   200  266K 2.4%
     436    17 image    1700  2200  rgb     3   8  jpeg   no      2489  0   200   200  349K 3.2%
     437    18 image    1700  2200  rgb     3   8  jpeg   no      2497  0   200   200  314K 2.9%
     438    19 image    1700  2200  rgb     3   8  jpeg   no      2507  0   200   200  276K 2.5%
     439    20 image    1700  2200  rgb     3   8  jpeg   no      2516  0   200   200  143K 1.3%
     439    21 stencil     1     1  -       1   1  image  no   [inline]   0.955     2    1B   -


Now lets use pdfid to have a look at the kinds of PDF objects in this document.

     ~/Downloads % ~/Build/pdf-tools/pdfid.py MuellerReport2.pdf
     PDFiD 0.2.7 MuellerReport2.pdf
      PDF Header: %PDF-1.7
      obj                 4038
      endobj              4038
      stream              3509
      endstream           3509
      xref                   0
      trailer                0
      startxref              2
      /Page                  0
      /Encrypt               0
      /ObjStm              910
      /JS                    1
      /JavaScript            0
      /AA                    0
      /OpenAction            0
      /AcroForm              1
      /JBIG2Decode           0
      /RichMedia             0
      /Launch                0
      /EmbeddedFile          0
      /XFA                   0
      /URI                   0
      /Colors > 2^24         0

This time we have a much more complex PDF file that has embedded text, however again no JavaScript.

Another trick some PDF files use are incremental updates. These are updates added to the end of a PDF file that overwrite parts of the document without needing to re-render the whole document. We can check for incremental updates by checking for multiple end of file strings.

    grep --byte-offset --text %%EOF MuellerReport2.pdf
    11435195:%%EOF
    11446220:%%EOF


We have found a incremental update, lets pull out the content of the incremental update and have a look at what it contains.

    dd if=MuellerReport2.pdf of=MuellerReport_IU2.pdf bs=1 skip=11435202

Incremental updates are not fully valid PDF files so reviewing their content must be done manually with a text editor. Opening this incremental update file in a text editor reveals that the Incremental update only updates two objects, object 2651 and 3937. Review of the new content shows that the major task the update.
