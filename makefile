# -------------------------
# VARIABLES
# -------------------------
VM=vagrant

# -------------------------
# BASIC VM LIFECYCLE
# -------------------------
up:
	vagrant up

down:
	vagrant halt

destroy:
	vagrant destroy -f

reload:
	vagrant reload --provision

status:
	vagrant status

ssh:
	vagrant ssh

# -------------------------
# PROVISIONING
# -------------------------
provision:
	vagrant provision

rebuild:
	vagrant destroy -f
	vagrant up --provision

# -------------------------
# ANSIBLE ONLY (inside VM)
# -------------------------
ansible-check:
	vagrant ssh -c "ansible --version"

ansible-run:
	vagrant ssh -c "ansible-playbook /vagrant/playbook.yml"

# -------------------------
# DEBUGGING
# -------------------------
logs:
	vagrant ssh -c "sudo journalctl -xe"

nginx-logs:
	vagrant ssh -c "sudo tail -f /usr/local/nginx/logs/error.log"

docker-check:
	vagrant ssh -c "docker ps && docker --version"

# -------------------------
# FULL HEALTH CHECK
# -------------------------
check:
	vagrant ssh -c "\
		echo '--- NGINX ---' && /usr/local/nginx/sbin/nginx -v && \
		echo '--- DOCKER ---' && docker --version && \
		echo '--- FIREWALL ---' && sudo firewall-cmd --list-ports \
	"



# .PHONY: Deploy 

# -name : initiate vagrant machine 
# 	runs: vagrant init 
# -name : starts vagrant machine 
# 	runs : vagrant up
# -name : ssh into the host specified 
# 	runs : ssh -i .vagrant/machines/default/virtualbox/private_key vagrant@127.0.0.1 -p 2222
# -name : validating installed packages (inside ssh )
# 	runs : 
# 		sudo docker -v
# 		sudo firewall-cmd --version
# 		sudo nginx -v 
# 		sudo auditd -v
# 		sudo modsecurity-nginx -V
# 		sudo logrotate --version

# -name: generic output 
# 	runs : echo "Packages installed successfully "