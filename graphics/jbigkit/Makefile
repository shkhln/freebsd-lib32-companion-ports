# Created by: mi
# $FreeBSD$

PORTNAME=	jbigkit
PORTVERSION=	2.1
PORTREVISION=	1
CATEGORIES=	graphics
MASTER_SITES=	https://www.cl.cam.ac.uk/~mgk25/download/

MAINTAINER=	mi@aldan.algebra.com
COMMENT=	Lossless compression for bi-level images such as scanned pages, faxes

LICENSE=	GPLv2+
LICENSE_FILE=	${WRKSRC}/COPYING

USES=		lib32
USE_LDCONFIG=	yes
MANS=		jbgtopbm.1 pbmtojbg.1
BINS=		jbgtopbm pbmtojbg jbgtopbm85 pbmtojbg85
LIBA=		libjbig.a libjbig85.a
LIBS=		libjbig.so.2 libjbig85.so.1
DOCSDIR?=	${PREFIX}/share/doc/jbig

TEST_ENV=	${MAKE_ENV} LD_LIBRARY_PATH=${WRKSRC}/libjbig
TEST_TARGET=	test

OPTIONS_DEFINE=	DOCS

do-install:
	${INSTALL_PROGRAM}	\
		${BINS:S|^|${WRKSRC}/pbmtools/|} ${STAGEDIR}${PREFIX}/bin

	${INSTALL_MAN}	\
		${MANS:S|^|${WRKSRC}/pbmtools/|} ${STAGEDIR}${MANPREFIX}/man/man1

	${INSTALL_DATA} ${WRKSRC}/libjbig/*.h ${STAGEDIR}${PREFIX}/include

	@${MKDIR} ${STAGEDIR}${LIBDIR}
	${INSTALL_DATA}	\
		${LIBA:S|^|${WRKSRC}/libjbig/|} ${STAGEDIR}${LIBDIR}
	${INSTALL_LIB}	\
		${LIBS:S|^|${WRKSRC}/libjbig/|} ${STAGEDIR}${LIBDIR}
	${LN} -sf libjbig.so.2 ${STAGEDIR}${LIBDIR}/libjbig.so
	${LN} -sf libjbig85.so.1 ${STAGEDIR}${LIBDIR}/libjbig85.so

	@${MKDIR} ${STAGEDIR}${DOCSDIR}
	${INSTALL_DATA} ${WRKSRC}/libjbig/jbig.txt ${STAGEDIR}${DOCSDIR}

.include <bsd.port.mk>
