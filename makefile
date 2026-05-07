ROLE=web_secure

.PHONY: all init deps lint up test destroy clean reset ci

# -----------------------------
# 1. Install dependencies
# -----------------------------
init:
	pip install molecule molecule-docker ansible ansible-lint 

# -----------------------------
# 2. Install Ansible roles/collections
# -----------------------------
# deps:
# 	ansible-galaxy install -r requirements.yml || true

# -----------------------------
# 3. Lint Ansible code
# -----------------------------
lint:
	ansible-lint

# -----------------------------
# 4. Start environment (Molecule create + build image)
# -----------------------------
up:
	molecule create

# -----------------------------
# 5. Run full test (create → converge → verify → destroy)
# -----------------------------
test:
	molecule test

# -----------------------------
# 6. Destroy environment
# -----------------------------
destroy:
	molecule destroy

# -----------------------------
# 7. Clean all local artifacts
# -----------------------------
clean:
	rm -rf .molecule

# -----------------------------
# 8. Full reset cycle (start from scratch)
# -----------------------------
reset: destroy clean up test

# -----------------------------
# 9. CI pipeline (what GitHub Actions will run)
# -----------------------------
ci: lint deps test

# -----------------------------
# 10. EVERYTHING FROM ZERO
# -----------------------------
all: init deps lint reset