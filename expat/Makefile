#########################################################################################
# This makefile is for an external application/library in the Neuros source tree.
# Available options are:
#
# - install: use only this during normal builds. will just install pre-build binaries.
# - rebuild: this will download the source, patch it and rebuild it to generate from 
#            scratch the pre-built binaries. You may need some special tools to re-build.
# - clean: if you do a rebuild, this will restore the pristine env as before you did it.
#
# App/Library: expat
# Version: 2.0.1
# Extra tools for rebuild: wget
#########################################################################################

TVER=2.0.1
BDIR=_build
TDIR=$(BDIR)/expat-$(TVER)
TARCHIVE=expat-$(TVER).tar.gz
TURL=http://downloads.sourceforge.net/expat/$(TARCHIVE)
INSTROOT=$(shell pwd)/$(BDIR)/products
TDISTS=$(PRJROOT)/external-components/downloads

.PHONY: clean all install

all:
	@echo "########################################"
	@echo "    INSTALL expat  ..."
	@echo "########################################"

	@mkdir -p ${TDISTS}
	@mkdir -p $(BDIR)
	@if test ! -f ${TDISTS}/${TARCHIVE}; then wget -N -P ${TDISTS} ${TURL}; fi
	@tar -C _build --touch -xvzf ${TDISTS}/${TARCHIVE}

	mkdir -p $(INSTROOT)
	cd $(TDIR) && \
	./configure --host=arm-linux --prefix=$(INSTROOT) --disable-static

	make -C $(TDIR) 
	make -C $(TDIR) install

	# Make toolchain dirs if they do not exist yet.
	mkdir -p $(TOOLCHAIN_USR_INSTALL)/include
	mkdir -p $(TOOLCHAIN_USR_INSTALL)/lib
	mkdir -p $(TOOLCHAIN_USR_INSTALL)/bin
	cp -av $(INSTROOT)/include/* $(TOOLCHAIN_USR_INSTALL)/include
	cp -av $(INSTROOT)/lib/* $(TOOLCHAIN_USR_INSTALL)/lib
	cp -av $(INSTROOT)/bin/* $(TOOLCHAIN_USR_INSTALL)/bin


install:

	cp -av $(INSTROOT)/bin/* $(INSTALL_MOD_PATH)/usr/bin
	cp -av $(INSTROOT)/lib/* $(INSTALL_MOD_PATH)/usr/lib


	arm-linux-strip --strip-unneeded $(INSTROOT)/lib/*.so*

clean:
	-rm -v $(TARCHIVE)
	-rm -rfv _build

