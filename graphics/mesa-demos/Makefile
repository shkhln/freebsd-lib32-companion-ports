# Created by: Eric Anholt <anholt@FreeBSD.org>
# $FreeBSD$

PORTNAME=	mesa-demos
PORTVERSION=	8.4.0
PORTREVISION=	2
CATEGORIES=	graphics
MASTER_SITES=	ftp://ftp.freedesktop.org/pub/mesa/demos/ #${PORTVERSION}/

MAINTAINER=	x11@FreeBSD.org
COMMENT=	OpenGL demos distributed with Mesa

LICENSE=	MIT

LIB_DEPENDS=	libdrm.so:graphics/libdrm

USES=		gmake gl lib32 localbase pkgconfig tar:bzip2 xorg
GNU_CONFIGURE=	yes
USE_GL=		egl gbm gl glesv2 glew glu glut
USE_XORG=	xorgproto x11 xdamage xext xfixes xi xxf86vm

CONFIGURE_ARGS+=--disable-osmesa --disable-vg --disable-wayland \
		--with-system-data-files

.if defined(USE_LIB32)
post-install:
	${REINPLACE_CMD} -E \
		-e 's|^bin/(.+[0-9])$$|bin/\1-32|g' \
		-e 's|^bin/(.+[^0-9])$$|bin/\132|g' \
		${TMPPLIST}
	${FIND} -E ${STAGEDIR}${PREFIX}/bin -type f -regex ".+[0-9]"  -exec ${MV} {} {}-32 \;
	${FIND} -E ${STAGEDIR}${PREFIX}/bin -type f -regex ".+[^0-9]" -exec ${MV} {} {}32 \;
.endif

.include <bsd.port.mk>
