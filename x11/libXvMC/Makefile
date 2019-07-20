# Created by: Eric Anholt <anholt@FreeBSD.org>
# $FreeBSD$

PORTNAME=	libXvMC
PORTVERSION=	1.0.12
CATEGORIES=	x11

MAINTAINER=	x11@FreeBSD.org
COMMENT=	X Video Extension Motion Compensation library

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/COPYING

USES=		cpe lib32 xorg xorg-cat:lib
USE_LDCONFIG=	yes
USE_XORG=	x11 xext xorgproto xv

CPE_VENDOR=	x
CPE_PRODUCT=	libxvmc

INSTALL_TARGET=	install-strip

.include <bsd.port.mk>
