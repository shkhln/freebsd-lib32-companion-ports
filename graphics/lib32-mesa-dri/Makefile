# $FreeBSD$

USE_LIB32=	yes
MASTERDIR=	${.CURDIR}/../mesa-dri

.include "${MASTERDIR}/Makefile"

CONFIGURE_ARGS+=--build=i386-portbld-freebsd --host=i386-portbld-freebsd

# /usr/bin/ld: error: can't create dynamic relocation R_386_PC32 against symbol
LDFLAGS+=	-Wl,-znotext

DESCR=		${MASTERDIR}/pkg-descr
PLIST=		${MASTERDIR}/pkg-plist
PKGHELP=	${MASTERDIR}/pkg-help
PKGINSTALL=	${MASTERDIR}/pkg-install
PKGDEINSTALL=	${MASTERDIR}/pkg-deinstall
