# If this makefile is not generic enough to support a translation,
# please contact debian-www.

WMLBASE=../..
CUR_DIR=releases/lenny
SUBS=debian-installer

include $(WMLBASE)/Make.lang

index.$(LANGUAGE).html: index.wml $(TEMPLDIR)/release.wml \
  $(ENGLISHDIR)/releases/lenny/release.data $(TEMPLDIR)/release_info.wml

releasenotes.$(LANGUAGE).html: releasenotes.wml $(TEMPLDIR)/release.wml \
  $(ENGLISHDIR)/releases/lenny/release.data $(TEMPLDIR)/release_info.wml \
  $(wildcard $(HTMLDIR)/*/release-notes*)

installmanual.$(LANGUAGE).html: installmanual.wml $(TEMPLDIR)/release.wml \
  $(ENGLISHDIR)/releases/lenny/release.data $(TEMPLDIR)/release_info.wml \
  $(wildcard $(HTMLDIR)/*/install*)

$(ENGLISHSRCDIR)/$(CUR_DIR)/release.data: $(TEMPLDIR)/release_images.wml
	touch $@
