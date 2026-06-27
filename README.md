Create a playbook for web-server .
On line 39 and and 62 left comments where we should find another solution since some stuff is being copied from local machin .
Right now you have to start the vagrant up and then use ansible locally.
ansible-playbook  -i  <Inventory_path> <playbook_path> 