--- dlls/ntdll/unix/virtual.c.orig
+++ dlls/ntdll/unix/virtual.c
@@ -0,7 +0,7 @@
 #ifdef _WIN64
 static void *user_space_limit    = (void *)0x7fffffff0000;  /* top of the user address space */
 static void *working_set_limit   = (void *)0x7fffffff0000;  /* top of the current working set */
 #else
-static void *user_space_limit    = (void *)0x7fff0000;
-static void *working_set_limit   = (void *)0x7fff0000;
+static void *user_space_limit    = (void *)0xc0000000;  /* top of the user address space */
+static void *working_set_limit   = (void *)0xc0000000;  /* top of the current working set */
 #endif
