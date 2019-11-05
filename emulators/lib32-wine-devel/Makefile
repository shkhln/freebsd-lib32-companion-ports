# $FreeBSD$

USE_LIB32=	yes
MASTERDIR=	${.CURDIR}/../wine-devel

.include "${MASTERDIR}/Makefile"

LDFLAGS+=	-Wl,-rpath,${PREFIX}/lib32 # ?
LIB32_PATTERN:=	(^bin\/wine$$$|${LIB32_PATTERN})

CFLAGS+=	-march=i686 # otherwise with -O2 we get a SIGBUS crash in wait_suspend in ntdll.dll.so under FreeBSD 12.1

# TODO: NETAPI_LIBS = -L/usr/local/lib/samba4 -lnetapi
# TODO: INOTIFY_LIBS = -L/usr/local/lib -linotify
# TODO: -Wl,-rpath=/usr/local/lib/gcc9 -L/usr/local/lib/gcc9
