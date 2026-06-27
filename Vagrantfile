Vagrant.configure("2") do |config|

  config.vm.define "database" do |db|
    db.vm.hostname = "database"
    db.vm.box = "bento/ubuntu-24.04"
    db.vm.synced_folder "./mysql", "/vagrant_data"

    db.vm.provider "virtualbox" do |vb|
        vb.name = "database"
        vb.memory = 1024
        vb.cpus = 1
    end

    db.vm.provision "shell", path: "./scripts/database.sh"

    db.vm.network "private_network", ip: "192.168.56.105"
  end

  ["web-server-1", "web-server-2"].each_with_index do |web_server, index|
    config.vm.define web_server do |web|
      web.vm.hostname = web_server
      web.vm.box = "bento/ubuntu-24.04"
      web.vm.synced_folder "./web-servers", "/home/vagrant/web-servers/"


      web.vm.provider "virtualbox" do |vb|
        vb.name = web_server
        vb.memory = 1024
        vb.cpus = 1
      end 


      web.vm.network "private_network", ip: "192.168.56.#{101 + index}"


      web.vm.provision "shell" do |s|
        ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_ed25519.pub").first.strip
        s.inline = <<-SHELL
          echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
          echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
        SHELL
      end
      
    end
  end

  config.vm.define "load-balancer" do |lb|
    lb.vm.hostname = "load-balancer"
    lb.vm.box = "bento/ubuntu-24.04"
    lb.vm.synced_folder "./load-balancer", "/vagrant_data"

    lb.vm.provider "virtualbox" do |vb|
        vb.name = "load-balancer"
        vb.memory = 1024
        vb.cpus = 1
    end

    lb.vm.provision "shell" do |s|
      s.path = "scripts/load-balancer.sh"
      s.env = {
        "WEB_SERVER_1_IP" => "192.168.56.101",
        "WEB_SERVER_2_IP" => "192.168.56.102"
      }
    end
    lb.vm.network "private_network", ip: "192.168.56.106"
  end
end