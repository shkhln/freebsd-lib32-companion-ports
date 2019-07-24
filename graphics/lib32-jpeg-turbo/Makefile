# $FreeBSD$

USE_LIB32=	yes
MASTERDIR=	${.CURDIR}/../jpeg-turbo

.include "${MASTERDIR}/Makefile"

CONFLICTS_INSTALL=	lib32-jpeg-[0-9]*

PLIST_SUB:=	${PLIST_SUB:S/JPEG="@comment "/JPEG=""/:S/LIBTURBOJPEG=""/LIBTURBOJPEG="@comment "/}
