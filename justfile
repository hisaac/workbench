project_root := justfile_directory()
config_dir   := project_root / ".config"
scripts_dir  := project_root / "scripts"
src_dir      := project_root / "src"

default: open

open target="":
	code "{{ project_root }}/workbench.code-workspace"

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

clean:
	"{{ scripts_dir }}/clean.bash" "{{ project_root }}"

nuke:
	"{{ scripts_dir }}/clean.bash" "{{ project_root }}" nuke
