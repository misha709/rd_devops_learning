#### [Back to Readme](../Readme.md)

## Task 1: Install Linux with Nginx

### Step 1: Setup Linux with Nginx
- To set up a Linux VM with Nginx, we use Vagrant.
- Create a [Vagrantfile](./Vagrantfile) with the following configuration:
```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"

  config.vm.define "linux-server" do |vm5|
    vm5.vm.network "public_network", ip: "192.168.0.105"
    
    vm5.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
      vb.name = "vm5"
    end

    vm5.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y nginx
    SHELL
  end
end
```
- In the terminal, run `vagrant up`
- Once complete, open a browser and navigate to the IP address specified in the Vagrantfile: `http://192.168.0.105`
![nginx welcome page](./images/nginx-setup.png)

