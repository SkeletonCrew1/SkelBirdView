The playbook installs MySQL on the vm, configures it and checks if it is active.
Inject .env file to the web-servers dir and change database_example.yml(use your creds and rename file on database.yml).
To use it you can just provision it with vagrant for now, but in the future you will be able to provoke the it via pipeline .