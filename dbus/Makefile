##############################################################################
# Description: Makefile for dbus
# 
# Author:  Tom Bruno (tbruno@neurostechnology.com)
# version: 1.2.3
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

	cd $(TDIR) && CFLAGS="-I$(TOOLCHAIN_USR_INSTALL)/include -fPIE -msoft-float" \
	 LDFLAGS="-L$(TOOLCHAIN_USR_INSTALL)/lib" ac_cv_have_abstract_sockets=yes \
	 ./configure --prefix=/ --host=arm-linux --datadir=/usr/share --with-xml=expat --without-x --disable-static --enable-shared --disable-tests --disable-doxygen-docs --disable-xml-docs --with-system-socket=/var/run/dbus/system_bus.socket --with-system-pid-file=/var/run/dbus/dbus.pid --with-session-socket-dir=/var/run/dbus --with-dbus-user=dbus --with-dbus-daemondir=/usr/bin

	@make -C $(TDIR) CC=$(CC)
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(INSTROOT) install
	@make -C $(TDIR) CC=$(CC) DESTDIR=$(INSTALL_MOD_PATH) install

	#Auto install into toolchain for deps
	cp -av $(INSTROOT)/include/dbus-1.0/* $(TOOLCHAIN_USR_INSTALL)/include/dbus
	cp -av $(INSTROOT)/lib/* $(TOOLCHAIN_USR_INSTALL)/lib
	cp -av $(INSTROOT)/lib/dbus-1.0/include/dbus/* $(TOOLCHAIN_USR_INSTALL)/include/dbus
	cp -av $(INSTROOT)/usr/bin/* $(TOOLCHAIN_USR_INSTALL)/bin

	#Fix up paths in configuration files
	sed -e 's/<servicehelper>.*/<servicehelper>\/usr\/libexec\/dbus-daemon-launch-helper<\/servicehelper>/' \
	    -e 's/<pidfile>.*/<pidfile>\/var\/run\/dbus\/dbus.pid<\/pidfile>/' \
	    -e 's/<listen>.*/<listen>unix:path=\/var\/run\/dbus\/system_bus.socket<\/listen>/' \
	    -i.orig $(INSTALL_MOD_PATH)/etc/dbus-1/system.conf

install:
	#install to rootfs
	mkdir -p $(INSTALL_MOD_PATH)/var/lib/dbus
	mkdir -p $(INSTALL_MOD_PATH)/var/run/dbus
	mkdir -p $(INSTALL_MOD_PATH)/usr/lib
	mkdir -p $(INSTALL_MOD_PATH)/usr/libexec/dbus-1
	mkdir -p $(INSTALL_MOD_PATH)/usr/share
	mkdir -p $(INSTALL_MOD_PATH)/usr/bin
	mkdir -p $(INSTALL_MOD_PATH)/share
	mkdir -p $(INSTALL_MOD_PATH)/lib
	mkdir -p $(INSTALL_MOD_PATH)/etc
	
	cp -av $(INSTROOT)/usr/bin/* $(INSTALL_MOD_PATH)/usr/bin
	cp -av $(INSTROOT)/usr/share/* $(INSTALL_MOD_PATH)/usr/share
	cp -av $(INSTROOT)/lib/*.so* $(INSTALL_MOD_PATH)/usr/lib
	cp -av $(INSTROOT)/libexec/* $(INSTALL_MOD_PATH)/usr/libexec
	cp -av $(INSTROOT)/share/* $(INSTALL_MOD_PATH)/usr/share
	cp -av $(INSTROOT)/etc/* $(INSTALL_MOD_PATH)/etc
	cp -av rc.dbus $(INSTALL_MOD_PATH)/etc/init.d/dbus

clean:
	@rm -rfv $(BDIR)

realclean:
	@rm -rfv $(BDIR)
	@rm -rfv $(TDISTS)/$(TARCHIVE)
