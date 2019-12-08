# $FreeBSD$

USE_LIB32=	yes

# mesa-libs itself is a slave port of mesa-dri
MESADIR= 	${.CURDIR}/../mesa-libs

.include "${.CURDIR}/../mesa-libs/Makefile"

DESCR=		${MESADIR}/pkg-descr
PLIST=		${MESADIR}/pkg-plist
PKGHELP=	${MESADIR}/pkg-help
PKGINSTALL=	${MESADIR}/pkg-install
PKGDEINSTALL=	${MESADIR}/pkg-deinstall

.include <bsd.port.post.mk>
