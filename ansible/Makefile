ENV := $(or $(word 2,$(MAKECMDGOALS)),staging)
export ENV

run: requirements
	ansible-playbook create-cluster.yml

test:
	ansible-playbook test.yml

requirements: 
	ansible-playbook docker-requirements.yml

traefik: untraefik
	ansible-playbook create-loadbalancer.yml

untraefik:
	-kubectl delete -f kubeconfigs/traefik-ingress.yml
	-helm uninstall traefik --namespace=traefik 
	-kubectl delete -f kubeconfigs/traefik-config.yml

destroy:
	ansible-playbook destroy-cluster.yml