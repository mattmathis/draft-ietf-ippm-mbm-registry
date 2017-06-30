NAME=draft-ietf-ippm-mbm-registry
TARGETS=$(NAME).txt $(NAME).html
TARGETS=$(NAME).html $(NAME).txt
WEBNAME=draft-ietf-ippm-mbm-registry
PRIOR=prior
LIB="none"

WEBDIR=${HOME}/www/drafts
FORMATTED=`date`

top: all

all: $(TARGETS)

clean:
	rm -f $(NAME).trig $(NAME).tmp $(NAME).txt $(NAME).html $(NAME).txt.bar

$(NAME).txt: $(NAME).xml
	-echo Making $(NAME).txt ======
	export $(LIB); xml2rfc --text $(NAME).xml

$(NAME).html: $(NAME).xml
	-echo Making $(NAME).html ======
	export $(LIB); xml2rfc --html $(NAME).xml

stage: $(NAME).txt $(NAME).html
	cp $(NAME).txt ${WEBDIR}/${WEBNAME}${SUFFIX}.txt
	cp $(NAME).html ${WEBDIR}/${WEBNAME}${SUFFIX}.html
	cp $(NAME).xml ${WEBDIR}/${WEBNAME}${SUFFIX}.xml
	chmod 644 ${WEBDIR}/${WEBNAME}*

# link prior.txt to Pub/whatever 
rfcdiff: $(NAME).txt
	tools/rfcdiff $(PRIOR).txt $(NAME).txt
	@echo See $(NAME)-from-$(PRIOR).diff.html

spell: $(NAME).txt
	cat $(NAME).txt | aspell list | sort -u > spell.txt

