project_root := justfile_directory()
config_dir   := project_root / ".config"
scripts_dir  := project_root / "scripts"
src_dir      := project_root / "src"

default: open

open target="": (generate target)
	xcrun xed "{{ project_root }}/Workbench.xcworkspace"

build target="":
	python "{{ scripts_dir }}/main.py" build {{ target }}

test target="":
	python "{{ scripts_dir }}/main.py" test {{ target }}

run target="":
	python "{{ scripts_dir }}/main.py" run {{ target }}

format: up
	python "{{ scripts_dir }}/main.py" format

lint: up
	python "{{ scripts_dir }}/main.py" lint

up:
	"{{ scripts_dir }}/up.bash"

cache:
	tuist cache --path "{{ project_root }}"

generate target="":
	tuist generate --path "{{ project_root }}" --no-open {{ target }}

edit: up
	tuist edit --permanent --only-current-directory --path "{{ project_root }}"
	xcrun xed "{{ project_root }}/Manifests.xcworkspace"

clean:
	"{{ scripts_dir }}/clean.bash" "{{ project_root }}"

nuke:
	"{{ scripts_dir }}/clean.bash" "{{ project_root }}" nuke
