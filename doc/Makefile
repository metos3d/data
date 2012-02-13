#
#	Makefile
#
#   metos3d/data/www/
#   metos3d-data.pdf/html
#
#   Author:
#       Jaroslaw Piwonski, CAU Kiel, jpi@informatik.uni-kiel.de
#

# define variables
DOCBASENAME = metos3d-data
DOCBASEDIR  = /home/algopt/public_html/metos3d/data/

# workaround
export TEX4HTENV=/home/algopt/work/metos3d/branch/jpi/metos3d/tex4ht.env

all: copy pdf html

copy:
	@echo "#"
	@echo "# Copy"
	@echo "#"
	cp ${DOCBASENAME}* ${DOCBASEDIR}.

pdf:
	@echo "#"
	@echo "# PDF"
	@echo "#"
	cd ${DOCBASEDIR}; \
	pdflatex ${DOCBASENAME}.tex > /dev/null 2>&1; \
	pdflatex ${DOCBASENAME}.tex > /dev/null 2>&1

html:
	@echo "#"
	@echo "# HTML"
	@echo "#"
	cd ${DOCBASEDIR}; \
	htlatex ${DOCBASENAME} "${DOCBASENAME}" > /dev/null 2>&1; \
	ln -s ${DOCBASENAME}.html index.html
