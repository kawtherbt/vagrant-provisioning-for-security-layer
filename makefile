ROLE=web_secure

.PHONY: all vagrant_init vagrant_up vagrant_provision vagrant_reload vagrant_ssh init deps lint up test destroy reset ci

# -----------------------------
# Vagrant setup
# -----------------------------

vagrant_init:
	vagrant init

vagrant_up:
	vagrant up

vagrant_provision:
	vagrant up --provision

vagrant_reload:
	vagrant reload

vagrant_ssh:
	ssh -i .vagrant/machines/default/virtualbox/private_key vagrant@127.0.0.1 -p 2222

# -----------------------------
# Install dependencies
# -----------------------------

init:
	pip install molecule molecule-docker ansible ansible-lint

# install role requirements
deps:
	ansible-galaxy install -r roles/requirements.txt || true

# lint ansible
# lint:
#	ansible-lint

# initialise env
up:
	cd /mnt/c/Users/front/OneDrive/Desktop/vagrant/roles/web_secure && \
	molecule create

# full test scenario
test:
	molecule test

# destroy env
destroy:
	molecule destroy

# full reset scenario (without cleaning .molecule)
reset: destroy up test

# Ci pipeline
# ci: lint deps test

# Full scenario
all:  vagrant_up vagrant_provision vagrant_reload init up test reset
# all: init deps lint reset