# Created by: Ashish Shukla <wahjava@gmail.com>
# $FreeBSD$

PORTNAME=	libxcb
PORTVERSION=	1.13.1
CATEGORIES=	x11 python
MASTER_SITES=	https://xcb.freedesktop.org/dist/

MAINTAINER=	x11@FreeBSD.org
COMMENT=	The X protocol C-language Binding (XCB) library

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/COPYING

BUILD_DEPENDS=	${LOCALBASE}/lib/libcheck.a:devel/check \
		xcb-proto>=1.9:x11/xcb-proto \
		${LOCALBASE}/libdata/pkgconfig/xcb-proto.pc:x11/xcb-proto \
		${LOCALBASE}/libdata/pkgconfig/pthread-stubs.pc:devel/libpthread-stubs
RUN_DEPENDS=	${LOCALBASE}/libdata/pkgconfig/pthread-stubs.pc:devel/libpthread-stubs

CONFIGURE_ARGS+=	--disable-build-docs --without-doxygen --enable-xinput

USES=		cpe gmake gnome lib32 python:build xorg xorg-cat:lib
USE_GNOME=	libxslt:build
USE_LDCONFIG= yes
USE_XORG=	xau xdmcp
INSTALL_TARGET=	install-strip
CPE_VENDOR=	x

OPTIONS_DEFINE=	DOCS

.for f in XPROTO_CFLAGS XPROTO_LIBS XDMCP_CFLAGS XDMCP_LIBS NEEDED_CFLAGS NEEDED_LIBS
CONFIGURE_ARGS+=${f}="${${f}}"
.endfor
CONFIGURE_ARGS+=--enable-xkb

.if defined(USE_LIB32)
LIBDIRSUFFIX=	32
.else
LIBDIRSUFFIX=
.endif

NEEDED_CFLAGS=	-I${LOCALBASE}/include
NEEDED_LIBS=	-L${LOCALBASE}/lib${LIBDIRSUFFIX} -lXau `pkg-config --libs pthread-stubs`

XDMCP_CFLAGS=	-I${LOCALBASE}/include
XDMCP_LIBS=	-L${LOCALBASE}/lib${LIBDIRSUFFIX} -lXdmcp

XPROTO_CFLAGS=	-I${LOCALBASE}/include
XPROTO_LIBS=	-L${LOCALBASE}/lib${LIBDIRSUFFIX}

.include <bsd.port.mk>
