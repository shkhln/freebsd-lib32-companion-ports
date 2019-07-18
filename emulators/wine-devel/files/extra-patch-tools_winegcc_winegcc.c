--- tools/winegcc/winegcc.c.orig	2019-05-10 18:43:42.000000000 +0300
+++ tools/winegcc/winegcc.c	2019-05-12 01:14:51.319923000 +0300
@@ -472,6 +472,7 @@
 
     /* generic Unix shared library flags */
 
+    strarray_add( flags, strmake( "-fuse-ld=%s", build_tool_name( opts, "ld", LD )));
     strarray_add( flags, "-shared" );
     strarray_add( flags, "-Wl,-Bsymbolic" );
