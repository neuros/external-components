##############################################################################
# Description: Makefile for dosfstools
# 
# Author:  Terry Qiu (tqiu@neuros.com.cn)
# version: 1.0
# Extra tools for build: wget
##############################################################################

ifndef PRJROOT
    $(error You must first source the BSP environment: "source neuros-env")
endif

TVER=1.2.3
TARCHIVE=dbus-$(TVER).tar.gz
TURL=http://dbus.freedesktop.org/releases/dbus/$(TARCHIVE)
BDIR=_build
TDIR=$(BDIR)/dbus-$(TVER)
TDISTS=$(PRJROOT)/external-components/downloads
INST_DIR=${INSTALL_MOD_PATH}
INSTROOT=$(shell pwd)/$(BDIR)/products

CC=arm-linux-gcc

.PHONY: all install clean realclean

all:
	@echo "########################################"
	@echo "    INSTALL dbus ..."
	@echo "########################################"

	@mkdir -p ${TDISTS}
	@mkdir -p ${BDIR}
	@if test ! -f ${TDISTS}/${TARCHIVE}; then wget -N -P ${TDISTS} ${TURL}; fi
	@tar -C ${BDIR} -xvzf ${TDISTS}/${TARCHIVE}

	cd $(TDIR) && CFLAGS="-I$(TOOLCHAIN_USR_INSTALL)/include -fPIE" \
	 LDFLAGS="-L$(TOOLCHAIN_USR_INSTALL)/lib" ac_cv_have_abstract_sockets=yes \
	 ./configure --prefix=$(INSTROOT) --host=arm-linux --with-xml=expat --without-x --disable-static --enable-shared --disable-doxygen-docs --disable-xml-docs 

	@make -C $(TDIR) CC=$(CC)
	@make -C $(TDIR) CC=$(CC) PREFIX=$(INSTALL_MOD_PATH) install

install:

	mkdir -p $(INSTALL_MOD_PATH)/var/lib/dbus
	mkdir -p $(INSTALL_MOD_PATH)/var/run/dbus

	cp -av $(INSTROOT)/bin/* $(INSTALL_MOD_PATH)/usr/bin
	cp -av $(INSTROOT)/lib/*.so* $(INSTALL_MOD_PATH)/usr/lib
	cp -av $(INSTROOT)/share/* $(INSTALL_MOD_PATH)/usr/share
	cp -av $(INSTROOT)/etc/* $(INSTALL_MOD_PATH)/etc

	cp -av $(INSTROOT)/include/dbus-1.0/* $(TOOLCHAIN_USR_INSTALL)/include/dbus
	cp -av $(INSTROOT)/lib/* $(TOOLCHAIN_USR_INSTALL)/lib
	cp -av $(INSTROOT)/lib/dbus-1.0/include/dbus/* $(TOOLCHAIN_USR_INSTALL)/include/dbus
	cp -av $(INSTROOT)/bin/* $(TOOLCHAIN_USR_INSTALL)/bin

clean:
	@rm -rfv $(BDIR)

realclean:
	@rm -rfv $(BDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
