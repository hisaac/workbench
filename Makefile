# config
.PHONY: *    # all targets phony
$(V).SILENT: # all targets silent

# variables
mkfile_path  := $(abspath $(lastword $(MAKEFILE_LIST)))
project_root := $(realpath $(dir $(mkfile_path)))
scripts_dir  := $(project_root)/scripts

up:
	"$(scripts_dir)/up.bash"
