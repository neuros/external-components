all:
%::
	@mkdir -p downloads
	@$(MAKE) -C rt73-firmware $@
	@$(MAKE) -C wifi-firmware $@
	@$(MAKE) -C wifi-tools $@
	@$(MAKE) -C e2fsprogs $@
	@$(MAKE) -C dosfstools $@
