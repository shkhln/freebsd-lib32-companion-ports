# Created by: David Mackay <davidjx8p@gmail.com>
# $FreeBSD$

PORTNAME=	virtualgl
PORTVERSION=	2.4.1
PORTREVISION=	7
CATEGORIES=	x11 graphics
MASTER_SITES=	SF/${PORTNAME}/${PORTVERSION}
DISTNAME=	VirtualGL-${PORTVERSION}

MAINTAINER=	davidjx8p@gmail.com
COMMENT=	Redirects commands from an OpenGL app to another X server

LIB_DEPENDS=	libturbojpeg.so:graphics/libjpeg-turbo \
		libxcb-keysyms.so:x11/xcb-util-keysyms
.if !defined(USE_LIB32)
LIB_DEPENDS+=	libfltk.so:x11-toolkits/fltk
.endif

ONLY_FOR_ARCHS=	amd64 i386

.if defined(USE_LIB32)
LIBDIRSUFFIX=32
.else
LIBDIRSUFFIX=
.endif

CMAKE_INSTALL_PREFIX=	${LOCALBASE}/VirtualGL
DOCSDIR=	${LOCALBASE}/VirtualGL/doc

USES=		cmake:noninja compiler:c++11-lang gl lib32 xorg
USE_GL=		gl glu
USE_XORG=	x11 xcb xext

CMAKE_ARGS=	-DTJPEG_INCLUDE_DIR=${LOCALBASE}/include\
		-DTJPEG_LIBRARY=${LOCALBASE}/lib${LIBDIRSUFFIX}/libturbojpeg.so\
		-DVGL_FAKEXCB=on -DVGL_SYSTEMFLTK=on -DVGL_SYSTEMGLX=on\
		-DVGL_LIBDIR=${CMAKE_INSTALL_PREFIX}/lib${LIBDIRSUFFIX}\
		-DVGL_FAKELIBDIR=${CMAKE_INSTALL_PREFIX}/fakelib${LIBDIRSUFFIX}
USE_LDCONFIG=	${PREFIX}/VirtualGL/fakelib ${PREFIX}/VirtualGL/lib
LDFLAGS+=	-L${LOCALBASE}/lib${LIBDIRSUFFIX}

OPTIONS_DEFINE=	OPENSSL XVIDEO

OPENSSL_CMAKE_ON=	-DVGL_USESSL:BOOL=ON
OPENSSL_CMAKE_OFF=	-DVGL_USESSL:BOOL=OFF
OPENSSL_USES=		ssl

XVIDEO_CMAKE_ON=	-DVGL_USEXV:BOOL=ON
XVIDEO_CMAKE_OFF=	-DVGL_USEXV:BOOL=OFF
XVIDEO_USE=	XORG=xv

.include <bsd.port.pre.mk>

.if ${ARCH} == "i386" || defined(USE_LIB32)
PLIST_SUB+=	I386=""
PLIST_SUB+=	AMD64="@comment "
.else
PLIST_SUB+=	I386="@comment "
PLIST_SUB+=	AMD64=""
.endif

post-patch:
	@${REINPLACE_CMD} -e '/^#define CHECKGL/s,m);, &,' \
		${WRKSRC}/server/VirtualDrawable.cpp
.if defined(USE_LIB32)
	${REINPLACE_CMD} -e '/install(TARGETS vglconfig DESTINATION $${VGL_BINDIR})/d' ${WRKSRC}/server/CMakeLists.txt
	${ECHO_CMD} 'set_target_properties(vglconfig PROPERTIES EXCLUDE_FROM_ALL 1)' >> ${WRKSRC}/server/CMakeLists.txt
	${REINPLACE_CMD} -e 's|VGL_LIB|VGL_32_LIB|g' -e 's|@VGL_32_LIB|@VGL_LIB|g' ${WRKSRC}/server/vglrun.vars.in
.endif

.if defined(USE_LIB32)
post-install:
	${REINPLACE_CMD} -E -e 's|^VirtualGL/lib/|VirtualGL/lib32/|g' -e 's|^VirtualGL/fakelib/|VirtualGL/fakelib32/|g' ${TMPPLIST}
.endif

.include <bsd.port.post.mk>
