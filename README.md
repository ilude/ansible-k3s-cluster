# Welcome

This project is designed to run inside WSL 2.
It will create a docker container with a configured ansible environment and needed kubernetes tools to create and manage a cluster. It makes the following assumptions:

* you have a registered domain (ilude.com in my case)
* you use cloudflare for your dns management of the above domain and have access to api token
* you use letsencrypt dns-01 via cloudflare

## Known Issues
  * currently letsencrypt dns-01 is no functioning

To start run the following which will launch vscode

```
make setup
```

Edit the following files
  * .env
  * ansbile/ansible.hosts 
      * set the dns name of your proxmox machine
  * ansible/env/env.yml 


```
make
```

This will drop you inside a docker container.

If you have edited the files above simply run the following inside the container
```
make
```