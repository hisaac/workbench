project_root := justfile_directory()
config_dir   := project_root / ".config"
scripts_dir  := project_root / "scripts"
src_dir      := project_root / "src"

default: open

open *target: up (generate target)
	xcrun xed "{{ project_root }}/Workbench.xcworkspace"

generate *target: up
	tuist generate {{ target }} --no-open --path "{{ project_root }}"

cache: up
	tuist cache

edit: up
	tuist edit --permanent --only-current-directory --path "{{ project_root }}"
	xcrun xed "{{ project_root }}/Manifests.xcworkspace"

build *args: up
	python "{{ scripts_dir }}/main.py" build {{ args }}

test: up
	"{{ scripts_dir }}/test.bash"

format: up
	python "{{ scripts_dir }}/main.py" format

lint: up
	python "{{ scripts_dir }}/main.py" lint

up:
	"{{ scripts_dir }}/up.bash"

clean:
	"{{ scripts_dir }}/clean.bash" "{{ project_root }}"

nuke:
	"{{ scripts_dir }}/clean.bash" "{{ project_root }}" nuke
