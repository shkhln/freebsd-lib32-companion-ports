# $FreeBSD$

USE_LIB32=	yes
MASTERDIR=	${.CURDIR}/../wine-devel

.include "${MASTERDIR}/Makefile"

LIB32_PATTERN:=	(^bin\/wine$$$|${LIB32_PATTERN})
LDFLAGS+=	-Wl,-rpath,/usr/local/lib32
