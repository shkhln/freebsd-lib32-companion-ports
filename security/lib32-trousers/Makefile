# $FreeBSD$

USE_LIB32=	yes
MASTERDIR=	${.CURDIR}/../trousers

.include "${MASTERDIR}/Makefile"

BUILD_DEPENDS:=	${BUILD_DEPENDS:C|${LOCALBASE}/lib/([^:]*):([^/]*)/(.*)|${LOCALBASE}/lib32/\1:\2/lib32-\3|g}

BUILD_DEPENDS:=	${BUILD_DEPENDS:S|tpm-emulator|lib32-tpm-emulator|g}
RUN_DEPENDS:=	${RUN_DEPENDS:S|tpm-emulator|lib32-tpm-emulator|g}

CPPFLAGS:=	${CPPFLAGS:S|-I${LOCALBASE}/include||g}
LDFLAGS:=	${LDFLAGS:S|${LOCALBASE}/lib|${LOCALBASE}/lib32|g}
