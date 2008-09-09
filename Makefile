all:
%::
	@mkdir -p downloads
	@$(MAKE) -C qt-embedded $@
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
