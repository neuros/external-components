all:
%::
	@mkdir -p downloads
	@$(MAKE) -C expat $@
	@$(MAKE) -C dbus $@
	@$(MAKE) -C ncurses $@
	@$(MAKE) -C alsa-lib $@
	@$(MAKE) -C alsa-utils $@
	@$(MAKE) -C strace $@
	@$(MAKE) -C iperf $@
#	@$(MAKE) -C qt-embedded $@
	@$(MAKE) -C libgpg-error $@
	@$(MAKE) -C libgcrypt $@
	@$(MAKE) -C rt73-firmware $@
	@$(MAKE) -C zydas-firmware $@
	@$(MAKE) -C wifi-tools $@
	@$(MAKE) -C e2fsprogs $@
	@$(MAKE) -C dosfstools $@
	@$(MAKE) -C ntfs-3g $@

oprofile:
	 @mkdir -p downloads
	 @$(MAKE) -C popt install
	 @$(MAKE) -C binutils install
	 @$(MAKE) -C oprofile install

.PHONY: oprofile
