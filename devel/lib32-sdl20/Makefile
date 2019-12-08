# $FreeBSD$

USE_LIB32=	yes
MASTERDIR=	${.CURDIR}/../sdl20

.include "${MASTERDIR}/Makefile"

LDFLAGS+=	-m32
LIB32_PATTERN:=	(lib32-sdl2-config|${LIB32_PATTERN})
