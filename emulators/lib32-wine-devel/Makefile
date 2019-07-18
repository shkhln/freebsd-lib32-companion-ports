# $FreeBSD$

USE_LIB32=	yes
MASTERDIR=	${.CURDIR}/../wine-devel

.include "${MASTERDIR}/Makefile"

LDFLAGS+=	-Wl,-rpath,/usr/local/lib32
LIB32_PATTERN:=	(^bin\/wine$$$|${LIB32_PATTERN})
