##########################################
#          The MIT License (MIT)         #
#           Copyright (c) 2016           #
#              Jeremy Cope               #
##########################################
# The complete terms can be found in the #
# license file located in directory root.#
##########################################
# Purpose: Define generic make rules/terms
#   especially those that define compile
#   and link rules. Care should be taken
#   when modifying this file.
##########################################
ifeq ($(FOOTER),)
FOOTER = true
##########################################

library: $(LIBRARY)

unittest: $(UT)

program: all $(BINARY)


all: $(LIBDIR)
	@echo 'Making all'
	@$(foreach subdir,$(PROGRAM_MODULES),cd $(subdir);$(MAKE) library;)

clean_all: clean_objects clean_library clean_unittest clean_program
	@echo 'Clean All'
	@$(foreach subdir,$(PROGRAM_MODULES),cd $(subdir);$(MAKE) clean;)

clean_objects:
	@echo 'Clean Objects'
	rm -f $(OBJDIR)/*.$(OBJEXT)

clean_library: clean_objects
	@echo 'Clean Library'
	rm -f $(LIBDIR)/*
	rm -f $(LIBRARY)

clean_unittest: clean_objects clean_library
	@echo 'Clean UT'
	rm -f $(UT)

clean_program: clean_objects
	@echo 'Clean Program'
	rm -f $(BINDIR)/*
	rm -f $(BINARY)


$(OBJDIR)/%.o : %.cpp $(OBJDIR)
	${CXXCOMPILE} -c -o $@ $<

%.o : %.cpp
	${CXXCOMPILE} -c -o $@ $<

$(OBJDIR)/%.o : %.c $(OBJDIR)
	${CCCOMPILE} -c -o $@ $<

%.o : %.c
	${CCCOMPILE} -c -o $@ $<

${OBJDIR}:
	@mkdir -p ${OBJDIR}

$(LIBDIR):
	@mkdir -p ${LIBDIR}

${BINDIR}:
	@mkdir -p ${BINDIR}


###LIBRARY RULES###
$(LIBRARY): $(LIBDIR) $(OBJDIR) $(OBJECTS)
	$(LIB_BUILD)
	@cp $(LIBDIR)/$(LIBRARY) ${__ROOTDIR}/$(LIBDIR)

###UNITTEST RULES###
$(UT): $(LIBRARY) $(UT_DEPENDENCIES)
	rm -f $(UT)
	$(CXXLINK) $(LIBS) $(LIBS_PATH) ${__ROOTDIR}/test/main.o -o $@

###PROGRAM RULES###
$(BINARY): $(BINDIR) $(SOURCE) $(PROGRAM_DEPENDENCIES)
	$(BIN_BUILD)
 
##########################################
endif
