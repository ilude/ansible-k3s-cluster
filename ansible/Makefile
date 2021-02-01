ENV := $(or $(word 2,$(MAKECMDGOALS)),staging)
export ENV

run: requirements
	ansible-playbook create-cluster.yml

test:
	ansible-playbook test.yml

requirements: 
	ansible-playbook docker-requirements.yml

ingress: delete-ingress
	ansible-playbook config-ingress.yml

delete-ingress:
	INGRESS_ACTION=delete ansible-playbook config-ingress.yml
	# -kubectl delete -f kubeconfigs/traefik-ingress.yml
	# -helm uninstall traefik --namespace=traefik 
	# -kubectl delete -f kubeconfigs/traefik-config.yml

destroy:
	ansible-playbook destroy-cluster.yml