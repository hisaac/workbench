project_root := justfile_directory()
config_dir   := project_root / ".config"
scripts_dir  := project_root / "scripts"
src_dir      := project_root / "src"

default: open

open *target: up (generate target)
	xcrun xed "{{ project_root }}/SysInfoKit.xcworkspace"

op *target: up (generate target)
	"/Applications/Xcode-15.4.0.app/Contents/MacOS/Xcode" "{{ project_root }}/SysInfoKit.xcworkspace"

generate *target: up
	tuist install
	tuist generate {{ target }} --no-open --path "{{ project_root }}"

cache: up
	tuist cache

edit: up
	tuist edit --permanent --only-current-directory --path "{{ project_root }}"
	xcrun xed "{{ project_root }}/Manifests.xcworkspace"

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
