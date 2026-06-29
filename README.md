The playbook installs MySQL on the vm, configures it and checks if it is active.
Inject .env file to the web-servers dir and export these vars in the shell where you run vagrant up:
DB_USER=
DB_PASSWORD=
DB_NAME=
ANSIBLE_SSH_PASS=
ANSIBLE_USER=
To use it you can just provision it with vagrant for now, but in the future you will be able to provoke the it via pipeline .