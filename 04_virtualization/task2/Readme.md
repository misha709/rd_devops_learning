#### [Back to Readme](../Readme.md)

## Task 2: Multi-VM Vagrant Setup

### Requirements
Three VMs with different network configurations:
- **VM1**: Public network (DHCP), nginx web server
- **VM2**: Private network (192.168.56.10), isolated from LAN
- **VM3**: Public network (static IP), accessible from LAN

### Setup

**1. Install Vagrant**
Download from https://developer.hashicorp.com/vagrant/downloads

**2. Create Vagrantfile**
Create [`Vagrantfile`](./Vagrantfile) with VM configurations

**3. Create shared folders**
```bash
mkdir shared
mkdir shared_vm3
```

**4. Start VMs**
```bash
vagrant up
```

### Results

#### VM1 - Public Network (Dynamic IP)
Find the assigned IP:
```bash
vagrant ssh vm1
ip address
```
Accessible from browser at `192.168.0.139` (DHCP-assigned)

![VM1 nginx](./images/vm1_nginx.png)

#### VM2 - Private Network (192.168.56.10)
Accessible only from host machine, **not** from mobile devices on LAN

![VM2 nginx](./images/vm2_nginx.png)

Mobile access (blocked):
![VM2 mobile access](./images/vm2_mobile_access.png)

VM1 can access VM2:
![VM1 to VM2](./images/vm1_connect_to_vm2.png)

#### VM3 - Public Network (Static IP)
Accessible from LAN at `192.168.0.100`

#### Shared Folders
All VMs have configured shared folders between host and guest

![Shared folders](./images/vms_shared_folders.png)

### Cleanup
```bash
vagrant destroy
```
