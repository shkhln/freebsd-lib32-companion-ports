--- dlls/ntdll/virtual.c.orig
+++ dlls/ntdll/virtual.c
@@ -124,8 +124,8 @@
 static const UINT_PTR page_mask = 0xfff;
 /* Note: these are Windows limits, you cannot change them. */
 static void *address_space_limit = (void *)0xc0000000;  /* top of the total available address space */
-static void *user_space_limit    = (void *)0x7fff0000;  /* top of the user address space */
-static void *working_set_limit   = (void *)0x7fff0000;  /* top of the current working set */
+static void *user_space_limit    = (void *)0xc0000000;  /* top of the user address space */
+static void *working_set_limit   = (void *)0xc0000000;  /* top of the current working set */
 static void *address_space_start = (void *)0x110000;    /* keep DOS area clear */
 #elif defined(__x86_64__)
 static const UINT page_shift = 12;
