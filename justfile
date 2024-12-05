project_root := justfile_directory()
config_dir   := project_root / ".config"
scripts_dir  := project_root / "scripts"
src_dir      := project_root / "src"

default: open

open: up
	xcrun xed "{{ project_root }}"

build: up
	"{{ scripts_dir }}/build.bash"

test: up
	"{{ scripts_dir }}/test.bash"

format: up
	"{{ scripts_dir }}/format.bash"

lint: up
	"{{ scripts_dir }}/lint.bash"

up:
	"{{ scripts_dir }}/up.bash"

clean:
	"{{ scripts_dir }}/clean.bash"

nuke:
	"{{ scripts_dir }}/clean.bash" nuke
