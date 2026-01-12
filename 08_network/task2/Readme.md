#### [Back to Readme](../Readme.md)

## Task 2: DNS Configuration

Set up a DNS server using dnsmasq on vm82 and test it from vm81.

### Prerequisites
- VMs from task1 must be running (vm81: 192.168.0.108, vm82: 192.168.0.109)

---

## Setup DNS Server (VM82)

**SSH into VM82:**
```bash
cd ./08_network/task1
vagrant ssh vm82
```

**Install dnsmasq:**
```bash
sudo apt-get update
sudo apt-get install -y dnsmasq
```

**Configure dnsmasq:**
```bash
sudo nano /etc/dnsmasq.conf
```

Add the following content:
```
listen-address=127.0.0.1,192.168.0.109
no-hosts
addn-hosts=/etc/dnsmasq.hosts
server=8.8.8.8
server=8.8.4.4
domain=rd-service.loc
log-queries
log-facility=/var/log/dnsmasq.log
cache-size=1000
```

Save and exit

**Create DNS entries:**
```bash
sudo nano /etc/dnsmasq.hosts
```

Add the following entries:
```
192.168.0.109 dns-server.rd-service.loc dns-server
192.168.0.108 client.rd-service.loc client
192.168.0.109 web.rd-service.loc
192.168.0.109 api.rd-service.loc
192.168.0.108 app.rd-service.loc
```

Save and exit

**Start dnsmasq:**
```bash
sudo systemctl enable dnsmasq
sudo systemctl status dnsmasq
```
*if not running because port is using try to disable service that use it, if systemd-resolved then: `sudo systemctl stop systemd-resolved`

**Verify DNS server is listening:**
```bash
sudo ss -tulnp | grep :53
```

---

## Setup DNS Client (VM81)

**SSH into VM81 (new terminal):**
```bash
cd ./08_network/task1
vagrant ssh vm81
```

**Install DNS tools:**
```bash
sudo apt-get update
sudo apt-get install -y dnsutils
```

---

## Test DNS Resolution

**From VM81, test DNS queries:**

```bash
dig @192.168.0.109 web.rd-service.loc
```

**Set DNS server as default on client:**
```bash
sudo bash -c 'echo "nameserver 192.168.0.109" > /etc/resolv.conf'
```

**Test without specifying server:**
```bash
dig web.rd-service.loc
ping api.rd-service.loc -c 2
```

---

## DNS Resolution Process

**How DNS works:**

1. **Client Query**: vm81 sends DNS query for `web.rd-service.loc` to 192.168.0.109
2. **Cache Check**: dnsmasq checks its cache
3. **Local Lookup**: Checks `/etc/dnsmasq.hosts` → finds `web.rd-service.loc = 192.168.0.109`
4. **Response**: Returns IP to client
5. **Forward (if not found)**: Unknown domains forwarded to 8.8.8.8 (Google DNS)

