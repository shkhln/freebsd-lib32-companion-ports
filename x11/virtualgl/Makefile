# Created by: David Mackay <davidjx8p@gmail.com>
# $FreeBSD$

PORTNAME=	virtualgl
PORTVERSION=	2.6.3
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

USES=		cmake compiler:c++11-lang gl xorg
USE_GL=		gl glu
USE_XORG=	x11 xcb xext xtst
CMAKE_ARGS=	-DTJPEG_INCLUDE_DIR=${LOCALBASE}/include \
		-DTJPEG_LIBRARY=${LOCALBASE}/lib${LIBDIRSUFFIX}/libturbojpeg.so\
		-DVGL_FAKEXCB=on -DVGL_SYSTEMFLTK=on \
		-DVGL_LIBDIR=${CMAKE_INSTALL_PREFIX}/lib${LIBDIRSUFFIX}\
		-DVGL_FAKELIBDIR=${CMAKE_INSTALL_PREFIX}/fakelib${LIBDIRSUFFIX}\
		-DCMAKE_INSTALL_DOCDIR=${DOCSDIR}
USE_LDCONFIG=	${PREFIX}/VirtualGL/lib${LIBDIRSUFFIX}
LDFLAGS+=	-L${LOCALBASE}/lib${LIBDIRSUFFIX}

OPTIONS_DEFINE=	OPENCL OPENSSL XVIDEO
OPTIONS_DEFAULT=	OPENCL
OPTIONS_SUB=	yes

OPENCL_CMAKE_BOOL=	VGL_FAKEOPENCL
OPENCL_BUILD_DEPENDS=	opencl>=0:devel/opencl
OPENCL_LIB_DEPENDS=	libOpenCL.so:devel/ocl-icd
OPENCL_DESC=		Build OpenCL interposer library

OPENSSL_CMAKE_BOOL=	VGL_USESSL
OPENSSL_USES=		ssl

XVIDEO_CMAKE_BOOL=	VGL_USEXV
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
