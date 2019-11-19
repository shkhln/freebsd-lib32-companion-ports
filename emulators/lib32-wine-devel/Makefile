# $FreeBSD$

USE_LIB32=	yes
MASTERDIR=	${.CURDIR}/../wine-devel

.include "${MASTERDIR}/Makefile"

CFLAGS+=	-march=i686 # otherwise with -O2 we get a SIGBUS crash in wait_suspend in ntdll.dll.so under FreeBSD 12.1
LDFLAGS+=	-Wl,-rpath,${PREFIX}/lib32 # ?

LIB32_PATTERN:=	(^bin\/wine$$$|${LIB32_PATTERN})

# TODO: INOTIFY_LIBS = -L/usr/local/lib -linotify
