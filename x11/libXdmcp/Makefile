# Created by: Eric Anholt <anholt@FreeBSD.org>
# $FreeBSD$

PORTNAME=	libXdmcp
PORTVERSION=	1.1.3
CATEGORIES=	x11

MAINTAINER=	x11@FreeBSD.org
COMMENT=	X Display Manager Control Protocol library

LICENSE=	MIT

USES=		lib32 xorg xorg-cat:lib
USE_LDCONFIG=	yes
USE_XORG=	xorgproto:both

CONFIGURE_ARGS+=--disable-docs --without-xmlto

post-patch:
	@${REINPLACE_CMD} '/^SUBDIRS/,/^$$/ \
		s/doc//' ${WRKSRC}/Makefile.in

.include <bsd.port.mk>
