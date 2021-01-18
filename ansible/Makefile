ENV := $(or $(word 2,$(MAKECMDGOALS)),staging)
export ENV

run: requirements
	ansible-playbook create-cluster.yml

test:
	ansible-playbook test.yml

requirements: 
	ansible-playbook docker-requirements.yml

traefik:
	ansible-playbook create-loadbalancer.yml

destroy:
	ansible-playbook destroy-cluster.yml