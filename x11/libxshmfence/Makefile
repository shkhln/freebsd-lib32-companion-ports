# $FreeBSD$

PORTNAME=	libxshmfence
PORTVERSION=	1.3
CATEGORIES=	x11

MAINTAINER=	x11@FreeBSD.org
COMMENT=	Shared memory 'SyncFence' synchronization primitive

LICENSE=	MIT

USES=		lib32 xorg xorg-cat:lib
USE_LDCONFIG=	yes
USE_XORG=	xorgproto

CONFIGURE_ARGS=	--with-shared-memory-dir=/tmp
INSTALL_TARGET=	install-strip
TEST_TARGET=	check

.include <bsd.port.mk>
