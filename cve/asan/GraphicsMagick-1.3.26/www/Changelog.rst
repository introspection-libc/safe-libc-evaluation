2017-07-04  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - NEWS.txt: Make sure is up to date.

  - www/index.rst: Update for 1.3.26 release.

  - version.sh: Update library versioning for 1.3.26 release.

  - magick/command.c (BatchCommand): Add ferror() checks around
    batch input loop.

2017-07-03  Glenn Randers-Pehrson  <glennrp@simple.dallas.tx.us>

  - coders/png.c: Reject a PNG file if the file size is too small
    (less than 61 bytes).  Reject a JNG file if it is too small (less
    than 147 bytes).
  - coders/jpeg.c: Reject a JPEG file if the file size is too small
    (less than 107 bytes).

2017-07-02  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - coders/dpx.c (ReadDPXImage): Compute required file size and
    verify that sufficient data exists in file before allocating
    memory to decode the image data.  Resolves problem with DPX file
    with valid header (but a huge claimed image width) provided
    provided via email on Thu, 29 Jun 2017 by LCatro.  This issue has
    been assigned CVE-2017-10799.

2016-07-02  Fojtik Jaroslav  <JaFojtik@seznam.cz>

  - coders/mat.c Check whether reported object size overflows file size.

2016-07-01  Fojtik Jaroslav  <JaFojtik@seznam.cz>

  - coders/mat.c Safety check for forged and or corrupted data.
    This issue has been assigned CVE-2017-10800.

2017-07-01  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - coders/tiff.c ("QuantumTransferMode"): Use a generalized method
    to enforce that buffer overflow can not happen while importing
    pixels.  Resolves problem with RGB TIFF claiming only one sample
    per pixel provided via email on Thu, 29 Jun 2017 by LCatro.  This
    issue has been assigned CVE-2017-10794.

2017-06-29  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - magick/command.c: Convert bare 'unsigned int' to MagickPassFail
    where suitable to make intentions clear.  Convert True/False to
    MagickTrue/MagickFalse or MagickPass/MagickFail according to
    purpose.  This is a continuation of a gradual migration and does
    not represent an API change.

2017-06-25  Glenn Randers-Pehrson  <glennrp@simple.dallas.tx.us>

  - coders/png.c: Avoid NULL dereference when MAGN chunk processing
    fails (https://sourceforge.net/p/graphicsmagick/bugs/426/). Expand
    TABs.

2017-06-25  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - NEWS.txt: Update NEWS with changes since the previous release.

  - www/programming.rst: Switch the Lua link to
    https://github.com/arcapos/luagraphicsmagick, which is a more
    complete and direct interface from Lua to GraphicsMagick's Wand
    API.

2017-06-24  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - VisualMagick/installer/gm-foo-dll.iss: Remove PerlMagick from
    the slim Inno Setup installer builder and remove mention of
    PerlMagick from the installer documentation.

  - TclMagick/generic/TclMagick.c (magickCmd): Resolve SourceForge
    patch #51 "TclMagick: memory access error; possible segfault".
    (newMagickObj): Fix formatting of pointer value so it is 64-bit
    safe.  Resolves SourceForge patch #50 "TclMagick: 64-bit
    portability issue".

  - coders/pict.c (ReadPICTImage): Avoid possible use of negative
    value when indexing array, which would cause buffer overflow.
    Resolves SourceForge issue #427 "One possible buffer overflow
    vulnerability in
    GraphicsMagick-1.3.25/coders/pict.c:ReadPICTImage()".

2017-06-22  Glenn Randers-Pehrson  <glennrp@simple.dallas.tx.us>

  - coders/png.c: Stop memory leak when reading invalid JNG image.
    Fixes CVE-2017-8350.

2017-06-18  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - coders/png.c: Fix lcms2.h inclusion logic.

  - wand/magick\_wand.c (MagickSetImageOrientation): Eliminate use of
    snprintf, which is not supported by older Visual Studio.

2017-06-09  Glenn Randers-Pehrson  <glennrp@simple.dallas.tx.us>

  - coders/png.c: Accept exIf chunks whose data segment
    erroneously begins with "Exif\0\0".

2017-06-01  Glenn Randers-Pehrson  <glennrp@simple.dallas.tx.us>

  - coders/png.c: Removed experimental zxIF chunk support.  That
    proposal is dead.

2017-05-27  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - config/log.mgk: Added documentation suggested by SourceForge
    issue #419 "Consider a small patch to log.mgk".

  - www/Changes.rst: Add missing link to most recent changes.

2017-05-24  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - www/Magick++/Image.rst: Improve documentation for Magick++
    Image::iccColorProfile() and Image::renderingIntent().

2017-05-21  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - tiff: Update to libtiff 4.0.8.

2017-03-19  Glenn Randers-Pehrson  <glennrp@simple.dallas.tx.us>

  - coders/png.c: Quieted a new Coverity complaint about a potential
    text buffer overrun.

2017-03-19  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - magick/image.c (SetImageInfo): Ignore empty magic prefix
    specification and do not remove colon character from start of
    filename.  Resolves SourceForge bug #415 "Inconsistent Behavior w/
    input\_file Parameter".

2017-03-18  Glenn Randers-Pehrson  <glennrp@simple.dallas.tx.us>

  - coders/png.c: Added new private orNT PNG chunk, to
    preserve image->orientation when it is defined and not
    the default TopLeft.
  - coders/jpeg.c: Mention image->orientation in the log when
    writing a JPEG.

2017-03-15  Glenn Randers-Pehrson  <glennrp@simple.dallas.tx.us>

  - coders/png.c (WriteOnePNGImage): Add version info about
    gm, libpng, zlib, and lcms to the PNG debug log.

2017-03-04  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - magick/command.c (ImportImageCommand): Fix handling of -frame
    options. Option handling was incorrect due to option checking the
    frame option after it had been freed.  Checking the frame dash
    option before freeing the argument solves the problem.  From patch
    provided by Victor Ananjevsky as SourceForge patch #49 "-frame
    doesn't work in gm import".

  - Magick++/lib/Image.cpp (attribute): Added Image attribute method
    which accepts a 'char \*' argument, and will remove the attribute
    if the value argument is NULL.  From patch provided by "Gints" as
    SourceForge patch #46 "C++ api - method to clear/remove
    attribute".

  - VisualMagick/configure/configure.cpp (InitInstance): Applied
    patch by Paul McConkey to allow the quantum command line argument
    to set the default value in the wizard drop list.  This allows
    setting the quantum depth when the /nowizard argument was
    supplied.  Resolves SourceForge patch #48 "When running from the
    command line configure.exe does not use the quantum argument".
    The provided configure.exe still needs to be rebuilt to
    incorporate this change.

  - magick/command.c (MogrifyImage): The -orient command now also
    updates the orientation in the EXIF profile, if it exists.

  - Magick++/lib/Image.cpp (orientation): Update orientation in EXIF
    profile, if it exists.

2017-03-03  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - coders/jp2.c: Support PGX JPEG 2000 format for reading and
    writing (within the bounds of what JasPer supports).

2017-02-23  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - coders/tiff.c (QuantumTransferMode): Fix out of bounds read when
    reading CMYKA TIFF which claims to have only 2 samples per pixel.
    Problem was reported via email on February 15, 2017 by Valon
    Chu. This issue was assigned CVE-2017-6335.

2017-01-29  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - doc/options.imdoc (-geometry): Geometry documentation changes
    suggested by Jon Wong.

2017-01-26  Glenn Randers-Pehrson  <glennrp@simple.dallas.tx.us>

  - coders/png.c: Added support for a proposed new PNG chunk
    (zxIf, read-only) that is currently being discussed on the
    png-mng-misc at lists.sourceforge.net mailing list.  Enable
    exIf and zxIf with CPPFLAGS="-DexIf\_SUPPORTED -DxzIf\_SUPPORTED".
    If exIf is enabled, only the uncompressed exIF chunk will be
    written and the hex-encoded zTXt chunk containing the raw Exif
    profile won't be written.

2017-01-25  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - coders/msl.c (MSLStartElement): Change test for NULL image
    pointer to before it is used rather than after it is used.
    Problem reported by Petr Gajdos on 2017-01-25.

2017-01-22  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - TclMagick/unix/m4/tcl.m4: Update tcl.m4 to TEA 3.10.  File
    supplied by Massimo Manghi.

2017-01-21  Glenn Randers-Pehrson  <glennrp@simple.dallas.tx.us>

  - coders/png.c: Added support for a proposed new PNG
    chunk (exIf read-write, eXIf read-only) that is currently
    being discussed on the png-mng-misc at lists.sourceforge.net
    mailing list.

2017-01-21  Glenn Randers-Pehrson  <glennrp@simple.dallas.tx.us>

  - coders/png.c: Added read\_user\_chunk\_callback() function
    and used it to implement a private PNG caNv (canvas) chunk
    for remembering the original dimensions and offsets when an
    image is cropped.  Previously we used the oFFs chunk for this
    purpose, but this had potential conflicts with other applications
    that also use the oFFs chunk.

2017-01-07  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - TclMagick/Makefile.am (AM\_DISTCHECK\_CONFIGURE\_FLAGS): Applied
    patch by Massimo Manghi to set AM\_DISTCHECK\_CONFIGURE\_FLAGS so
    that 'make distcheck' remembers configuration options, and also to
    uninstall pkgIndex.tcl.

  - magick/image.c (SetImageEx): Use PixelIterateMonoSet() for
    possibly improved efficiency.

  - magick/pixel\_iterator.c (PixelIterateMonoSet): New pixel
    iterator intended for use when initializing image pixels, without
    regard to existing values.

2017-01-01  Bob Friesenhahn  <bfriesen@simple.dallas.tx.us>

  - Copyright.txt: Bump copyright years and rotate ChangeLog.


