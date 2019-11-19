# $FreeBSD$

USE_LIB32=	yes
MASTERDIR=	${.CURDIR}/../wayland

.include "${MASTERDIR}/Makefile"

#TODO: Synth is supposed to pick that up from /usr/local/libdata/ldconfig32/lib32-expat
MAKE_ENV+=	LD_32_LIBRARY_PATH=${LOCALBASE}/lib32
