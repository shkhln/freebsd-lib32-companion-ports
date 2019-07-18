--- tools/winegcc/winegcc.c.orig       2018-12-28 18:58:40 UTC
+++ tools/winegcc/winegcc.c
@@ -396,6 +396,7 @@ static const strarray* get_lddllflags( const struct op
     case PLATFORM_ANDROID:
     case PLATFORM_SOLARIS:
     case PLATFORM_UNSPECIFIED:
+        strarray_add( flags, strmake( "-fuse-ld=%s", build_tool_name( opts, "ld", LD )));
         strarray_add( flags, "-shared" );
         strarray_add( flags, "-Wl,-Bsymbolic" );
