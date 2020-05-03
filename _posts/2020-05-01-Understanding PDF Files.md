---
layout: post
title: 'PDF Malware: Part 1 Understanding PDF Files'
DateTime: 2020-05-01 17:00:00 +1100
feature-img: "assets/img/pexels/book-glass.jpeg"
thumbnail: "assets/img/pexels/book-glass.jpeg"
tags:
    - Cyber Security
    - Cyber Intelligence
    - Forensics and Incident Response
---

WORK IN PROGRESS

Introduction
===========

PDF files are unanimous in all aspects of business, and have been a attack surface.

PDF Structure
=============

PDF files are 8 bit ASCII formatted files, meaning they can be opened and read in a text editor. This basic structure has largely been unchanged since its release in 1993, with the exception of Incremental updates and Linearized PDF files (that we will talk about later).

PDF files contains the following structure:

![Diagram 1](/assets/img/posts/2020-05-01/diag1.svg)

# PDF Header

The PDF header will start with "%PDF-" followed by the PDF version. for example:

    %PDF-1.7

Note that this version can be overwritten from PDF version 1.5 with a version number contained in the Catalog object, or with a incremental update.

# PDF Body Structure
The PDF body has a collection of objects similar to the structure of folders and files in common file-system. Objects have types, and can reference other objects resulting in a hierarchy. The important object types to know are:

|Catalog| This is the root object, it must reference a Pages object|
|Pages| an object that contains a list of page objects for each page|
|Page| An object that defines a single page, will reference a "Content" object|

# PDF xref Table

The xref table or Cross-Reference table is a table that permits the random access of objects through the use of byte offsets for those objects. A program can use this table to quickly find object within a file without scanning the entire file for the object locations.

    xref
    0 11
    0000000000 65535 f
    0000000015 00000 n

Many PDF readers will open a PDF file without a xref table, and it can be helpful to not have a xref table when hand writing PDF files. If you do this be sure to also remove the xref byte offset in the trailer

# Footer

The file footer contains 3 important components. The trailer text contain information about what the root object is that is necessary to identify the Catalog object. The startxref defines the byte offset of the xref table used to speed up random access of pdf objects, and lastly the end of file footer that indicates the PDF file has ended.

    trailer << /Info 2 0 R /Root 1 0 R /Size 11 /ID [<493d5628c7b96ab973dcdc9551e3d318><493d5628c7b96ab973dcdc9551e3d318>] >>
    startxref
    1493
    %%EOF

Because a PDF reader needs to know the root object and where the xref table is, many PDF programs start reading a PDF file from the end of the file. This introduced a limitation with the PDF file being unable to be opened until all the file had been downloaded, this limitation is addressed in part through the introduction of Linearized PDF files.


# PDF Hello World

When you put it all together you get the following file:

    %PDF-1.4

    1 0 obj <</Type /Catalog /Pages 2 0 R>>
    endobj

    2 0 obj <</Type /Pages /Kids [3 0 R] /Count 1>>
    endobj

    3 0 obj<</Type /Page /Parent 2 0 R /Resources 4 0 R /MediaBox [0 0 500 800] /Contents 6 0 R>>
    endobj

    4 0 obj<</Font <</F1 5 0 R>>>>
    endobj

    5 0 obj<</Type /Font /Subtype /Type1 /BaseFont /Helvetica>>
    endobj

    6 0 obj
    <</Length 44>>
    stream
    BT /F1 24 Tf 175 720 Td (Hello World!)Tj ET
    endstream
    endobj

    xref
    0 7
    0000000000 65535 f
    0000000009 00000 n
    0000000056 00000 n
    0000000111 00000 n
    0000000212 00000 n
    0000000250 00000 n
    0000000317 00000 n

    trailer <</Size 7/Root 1 0 R>>
    startxref
    406
    %%EOF

The source of this example PDF file is from [here](https://blog.idrsolutions.com/2010/10/make-your-own-pdf-file-part-4-hello-world-pdf/)


# Incremental Updates
A PDF file can be updated without rewriting the file completely through a process of Incremental Updates. Adjustments can be added after the original file and the object references in this incremental update will

![Diagram 2](/assets/img/posts/2020-05-01/diag1 incremental.svg)

From PDF version 1.4 the PDF version can be updated with a incremental update through updating the Version entry in the documents Catalog object.

# Stream Compression

To save space, the data in a steam object can be compressed with LZW and (beginning with PDF 1.2) Deflate compression. This compression saves substantial amount of space but makes the object information impossible to read without first decompressing it. The compression functions will return binary data, and any text data will need to be converted to ASCII base-85 encoding to return it to 7bit ASCII.

    10 0 obj
        << /Length 140 /Filter /FlateDecode >>
        stream
        .......................................................................
        ..............................................................endstream
    endobj

# Object Streams

Objects steams are a way of allowing indirect objects to be stored within an object and was introduced in PDF 1.5. This object stream can also be compressed allowing for the contents of the stream to be encrypted and/or compressed. This also requires the Cross-Reference table information to be changed for these embedded objects to be accessed. Some PDF tools may not parse Object Streams and they may miss these objects within objects, care should be taken to use tools that support object steams as they are very common.

A new object type of /ObjStm has been introduced to indicate that it contains objects:

    60 0 obj
    <<
      /Filter /FlateDecode
      /First 8
      /Length 79
      /N 1
      /Type /ObjStm
    >>
    stream
    ...........................................................................
    endstream
    endobj

Within the stream is object 26:

    26 0 <</C[/CM1/CM69]/ID 26744 0 R/K[1 2]/P 24220 0 R/Pg 1096 0 R/S/H3/T()>>

Some objects cannot be stored in a object stream, this includes:

* Other stream objects including object stream objects
* Objects with a generation number other than 0 (if applicable)
* The Encryption Dictionary object (if applicable)
* The linearization dictionary and page objects (if applicable)

If you need to review the file in a hex editor it can help to remove object Streams with the following command:

    mutool clean -d orig.pdf orig.uncompressed.pdf

# Linearized PDF files

Linearized PDF files are an optional extension of PDF 1.2 and later documents. When a Linearized PDF file is generated it benefits PDF readers that support it with:

* Faster loading of the first page
* Load PDF files incrementally over the network, permitting the display of pages before all the document has been transfered
* Optimised loading of pages

This is achieved through the implementation of a new Linearization object, hint table objects, a new xref table for just first page objects near the start of the document, and rules rules around the ordering of objects.

![Diagram 3](/assets/img/posts/2020-05-01/diag1 linear.svg)

These documents are still backwards compatible with PDF readers that do not support Linearized PDF files, but are not compatible with incremental updates. any incremental updates applied to a Linearized PDF file invalidate the Linearized features.

# Text Encoding

TODO

# Special note: Cmaps

TODO
