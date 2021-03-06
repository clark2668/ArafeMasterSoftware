#Makefile for the ARAFE Master Firmware

include ${ARA_DAQ_DIR}/standard_definitions.mk
Targets = arafed arafebsl
arafed : OBJECTS = arafed.o arafe.o arafei2c.o
arafebsl : OBJECTS = arafebsl.o arafe.o arafei2c.o
all: $(Targets)

arafed_debug :
	gcc -DDEBUG arafed.c arafe_debug.c -o arafed_debug

arafed : arafed.o arafe.o arafei2c.o arafebsl.o
	@echo "<**Linking**> $@ (from $(OBJECTS)) ..."
	$(LD) $(OBJECTS) $(LDFLAGS) $(ARA_LIBS) -lARAutil -lAraRunControl -lAtriControl -lAraFx2Com  -o $@
	@chmod 555 $@
	ln -sf $(shell pwd)/$@ ${ARA_DAQ_DIR}/bin

arafebsl : arafebsl.o
	@echo "<**Linking**> $@ (from $(OBJECTS)) ..."
	$(LD) $(OBJECTS) $(LDFLAGS) $(ARA_LIBS) -lARAutil -lAraRunControl -lAtriControl -lAraFx2Com  -o $@
	@chmod 555 $@
	ln -sf $(shell pwd)/$@ ${ARA_DAQ_DIR}/bin



clean: objclean
	@-rm -f $(Targets) 
