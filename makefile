LATEXMK=latexmk -g
LATEXMKOPT=-shell-escape
LATEXMKOUTPUT=-output-directory=$(BUILD_DIR)/
XELATEX=-lualatex

BUILD_DIR=build
OUTPUTDIR=output

MK=$(LATEXMK) $(XELATEX) $(LATEXMKOPT) $(LATEXMKOUTPUT)

DEFAULT="\documentclass[aspectratio=1610, twocolumn]{beamer}\input{metadatas}\input{header}"
_HANDOUT=", handout"
_NOTES="\\n\\\\setbeameroption{show notes on second screen=right}"

TEMP=TEMP
TEMP_TEX=$(TEMP).tex
TEMP_PDF=$(TEMP).pdf


ifeq ($(class),handout)
	HANDOUT=$(_HANDOUT)
endif
ifeq ($(class),notes)
	NOTES=$(_NOTES)
endif
ifeq ($(class),handout,notes)
	NOTES=$(_NOTES)
	HANDOUT=$(_HANDOUT)
endif

ifeq ($(class),notes,handout)
	NOTES=$(_NOTES)
	HANDOUT=$(_HANDOUT)
endif
all: $(wildcard *.tex)

%.pdf : %.tex
	$(eval work_dir := $(dir $@))
	$(eval pdf := $(notdir $@))
	$(eval name := $(basename $(pdf)))
	$(eval tex := $(basename $(pdf)).tex)
	$(eval relative_path := $(shell realpath --relative-to $(work_dir) $(CURDIR)))

	$(eval CLASS := "\\documentclass[aspectratio=1610, dvipsnames, noamsthm,french, twocolumn$(HANDOUT)]{beamer}\\n\\\\newcommand{\\\\rootdir}{$(relative_path)}\\n\\input{metadatas}\\n\\input{header}$(NOTES)\\n\\\\begin{document}\\n\\input{$(tex)}\\n\\\\end{document}")
	cd $(work_dir) && echo $(CLASS) > $(TEMP_TEX) && $(MK) $(LATEXMKOUTPUT) $(TEMP_TEX)
	#; rm $(TEMP_TEX)
	mv $(work_dir)$(BUILD_DIR)/$(TEMP_PDF) $(work_dir)$(OUTPUTDIR)/$(pdf)
	ln -sf $(OUTPUTDIR)/$(pdf) $(work_dir)$(pdf)

clean:
	rm -rf $(BUILD_DIR)/*
	rm -rf *.pdf
	rm -rf $(OUTPUTDIR)/*
	rm -rf */$(BUILD_DIR)/*
	rm -rf */$(OUTPUTDIR)/*
	find .  -type l -iname '*.pdf' -exec rm {} \;

.PHONY: clean all
