all:
%::
	@mkdir -p downloads
	@$(MAKE) -C wifi-firmware $@
