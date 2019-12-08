# $FreeBSD$
#
# Create a 'lib32-' companion port.
#
# For ports need to ship 32-bit components, or who have dependant's who need
# 32-bit libraries.
#
# A port that needs a 'lib32-' companion port must:
#   - Add USES=lib32
#   - Create a slave port, in the same category, with a prefix 'lib32-'
#   - The slave port needs to:
#     - Define 'USE_LIB32'
#     - Set 'MASTERDIR' to the port without the 'lib32-' prefix
#     - Include '${MASTERDIR}/Makefile'
#
# For the 'lib32-' companion port the following are done:
#   - Add 'lib32-' to PKGNAMEPREFIX
#   - Patch various variables to use the 'lib32' directory instead of 'lib'
#   - Patch the pkg-plist to only include files installed under 'lib32'
#
# Usage:
#   USES=lib32
#
# Variables set by lib32:
#
#   LIBDIR	The path to the library directory
#   			${PREFIX}/lib; or
#   			${PREFIX}/lib32

.if !defined(_LIB32_MK_INCLUDED)
_LIB32_MK_INCLUDED=	lib32.mk
_USES_POST+=		lib32

. if defined(USE_LIB32)
ONLY_FOR_ARCHS=		amd64
ONLY_FOR_ARCHS_REASON=	32-bit libraries only applicable on amd64
LIBDIR=		${PREFIX}/lib32
. else
LIBDIR=		${PREFIX}/lib
. endif

.endif // _LIB32_MK_INCLUDED

.if defined(_POSTMKINCLUDED) && !defined(_LIB32_MK_POST_INCLUDED)
_LIB32_MK_POST_INCLUDED=	yes

. if defined(USE_LIB32)
PKGNAMEPREFIX:=	lib32-${PKGNAMEPREFIX}

.  if ${USES:Mlocalbase*}
.   include "${USESDIR}/localbase.mk"
.  endif

.  if defined(LIBS)
LIBS:=${LIBS:S|${LOCALBASE}/lib|${LOCALBASE}/lib32|g}
.  endif

.  if defined(BUILD_DEPENDS)
BUILD_DEPENDS:=	${BUILD_DEPENDS:C|${LOCALBASE}/libdata/pkgconfig/([^:]+):([^/]*)/(.*)|${LOCALBASE}/libdata/pkgconfig32/\1:\2/lib32-\3|g}
.  endif

.  if defined(RUN_DEPENDS)
# For whatever reason x11/libxcb has a runtime dependency on devel/libpthread-stubs
RUN_DEPENDS:=	${RUN_DEPENDS:C|${LOCALBASE}/libdata/pkgconfig/([^:]+):([^/]*)/(.*)|${LOCALBASE}/libdata/pkgconfig32/\1:\2/lib32-\3|g}
.  endif

.  if defined(LIB_DEPENDS)
LIB32_DEPENDS:=	${LIB_DEPENDS:C|([^:]*):([^/]*)/(.*)|${LOCALBASE}/lib32/\1:\2/lib32-\3|g}
BUILD_DEPENDS+=	${LIB32_DEPENDS}
RUN_DEPENDS+=	${LIB32_DEPENDS}
.  undef LIB_DEPENDS
.  endif

.  if defined(USE_GL)
BUILD_DEPENDS:=	${BUILD_DEPENDS:C!${LOCALBASE}/lib/lib(GL|EGL|GLESv2).so:graphics/mesa-libs!${LOCALBASE}/lib32/lib\1.so:graphics/lib32-mesa-libs!g}
RUN_DEPENDS:=	${RUN_DEPENDS:C!${LOCALBASE}/lib/lib(GL|EGL|GLESv2).so:graphics/mesa-libs!${LOCALBASE}/lib32/lib\1.so:graphics/lib32-mesa-libs!g}
.  endif

# We need to make sure that companion ports depend on exactly the same versions of master ports,
# since master ports provide headers, config files, documentation and so on.
.  if !defined(ALLOW_LIB32_DESYNC)
_LIB32_MDEP_TUPLE=${PKGNAMEPREFIX:C/^lib32-//}${PORTNAME}${PKGNAMESUFFIX}=${PKGVERSION}:${PKGCATEGORY}/${MASTERDIR:C|/([^/]+)$$$|:\1|:C|([^:]+:)||}
BUILD_DEPENDS:=	${_LIB32_MDEP_TUPLE} ${BUILD_DEPENDS}
RUN_DEPENDS:=	${_LIB32_MDEP_TUPLE} ${RUN_DEPENDS}
.  endif

CFLAGS+=	-m32
CPPFLAGS+=	-m32 # CXXFLAGS?

.  for flags in CFLAGS CPPFLAGS LDFLAGS
${flags}:=	${${flags}:C|${LOCALBASE}/lib/|${LOCALBASE}/lib32/|g:C|${LOCALBASE}/lib$$|${LOCALBASE}/lib32|g}
.  endfor

.  if !defined(USE_LDCONFIG32)
.   if !defined(USE_LDCONFIG) || ${USE_LDCONFIG} == yes
USE_LDCONFIG32:=${LIBDIR}
.   else
USE_LDCONFIG32:=${USE_LDCONFIG:S|${PREFIX}/lib$$|${LIBDIR}|g}
.   endif
.  endif
.  undef USE_LDCONFIG

# TODO: the second entry should rather be something like /usr/libdata/pkgconfig32, but there is no such directory
CONFIGURE_ENV+=	PKG_CONFIG_LIBDIR=${LOCALBASE}/libdata/pkgconfig32:/usr/libdata/pkgconfig

# TODO: presumably we only need this to counteract settings from /usr/libdata/pkgconfig/zlib.pc
LDFLAGS+=	-L/usr/lib32 -Wl,-rpath,/usr/lib32

.  if defined(HAS_CONFIGURE) || defined(GNU_CONFIGURE)
CONFIGURE_ARGS:=${CONFIGURE_ARGS:C|${LOCALBASE}/lib/|${LOCALBASE}/lib32/|g:C|${LOCALBASE}/lib$$|${LOCALBASE}/lib32|g} --libdir=${LIBDIR}
.  elif ${USES:Mcmake*}
CMAKE_ARGS+=-DCMAKE_INSTALL_LIBDIR:STRING="lib32"
.  endif

_USES_stage+=	805:post-stage-lib32 935:post-plist-lib32

post-stage-lib32:
	for p in libdata/pkgconfig ${PREFIX}/libdata/pkgconfig ${PREFIX}/lib32/pkgconfig; do \
		if test -d ${STAGEDIR}/$$p; then \
			${FIND} ${STAGEDIR}/$$p -name "*.pc" \
				-exec ${MKDIR} ${STAGEDIR}${PREFIX}/libdata/pkgconfig32 \;  \
				-exec ${MV} {} ${STAGEDIR}${PREFIX}/libdata/pkgconfig32 \;; \
			${RMDIR} ${STAGEDIR}/$$p ; \
		fi \
	done

LIB32_PATTERN=	(^lib\/|^@post(un)?exec .* ldconfig|${PREFIX:S|/|\/|g}\/share\/licenses|${PREFIX:S|/|\/|g}\/libdata\/ldconfig32|^libdata\/pkgconfig32)

post-plist-lib32:
	${SED} -E -e '/${LIB32_PATTERN}/d' -e '/^@/d' -e 's|^|${STAGEDIR}${PREFIX}/|g' ${TMPPLIST} | ${XARGS} ${RM}
	${SED} -E -e '/${LIB32_PATTERN}/d' -e '/^@/d' -e 's|^|${STAGEDIR}${PREFIX}/|g' ${TMPPLIST} | ${XARGS} ${DIRNAME} |\
		${SORT} -r -u | ${XARGS} -I{dir} -R 2 -S 10000 sh -c 'if test -d {dir}; then ${RMDIR} {dir} | true; fi'
	${REINPLACE_CMD} -E -e 's|^libdata/pkgconfig/|libdata/pkgconfig32/|g' -e '/${LIB32_PATTERN}/!d' -e 's|^lib/|lib32/|g' ${TMPPLIST}

. endif
.endif // _LIB32_MK_POST_INCLUDED
