#### [Back to Readme](../Readme.md)

## Task 3: Subnetting

- Your company uses the network 10.0.0.0/8 for its internal infrastructure. 
- Your colleagues have now taken the subnets 10.0.1.0/24 and 10.0.0.32/26. 
- Your task is to obtain 10 subnets, each of which will accommodate from 5 to 11 hosts. 
- What subnets will these be and why?


### Step 1:
Notify colleagues that they have ip address overlap/configuration issue with `10.0.0.32/26`. Why?

**The problem:** `10.0.0.32/26` is NOT a valid network address.

With a `/26` mask: `32 - 26` = `6 bits` for hosts. 2^6 = 64 addresses per subnet.

This means network addresses must be divisible by 64. Valid /26 subnets in the 10.0.0.0/24 range are:
- **10.0.0.0/26**
  - Network: 10.0.0.0
  - Hosts: 10.0.0.1 - 10.0.0.62
  - Broadcast: 10.0.0.63
- **10.0.0.64/26**
  - Network: 10.0.0.64
  - Hosts: 10.0.0.65 - 10.0.0.126
  - Broadcast: 10.0.0.127
- **10.0.0.128/26**
  - Network: 10.0.0.128
  - Hosts: 10.0.0.129 - 10.0.0.190
  - Broadcast: 10.0.0.191
- **10.0.0.192/26**
  - Network: 10.0.0.192
  - Hosts: 10.0.0.193 - 10.0.0.254
  - Broadcast: 10.0.0.255

**Conclusion:** The address `10.0.0.32` is a host address within the `10.0.0.0/26` subnet, not a valid network address. The colleague should use `10.0.0.0/26` instead.


### Step 2: Obtain 10 subnets with 5 to 11 hosts
- Assuming that subnet `10.0.0.32/26` is incorrect, we have only `10.0.1.0/24` and `10.0.0.0/26` in use.

**Calculation:**
- Required: 5 to 11 hosts per subnet
- Minus 2 addresses for network and broadcast
- 2^4 - 2 = 14 hosts (meets requirement)
- Subnet mask: `/28` gives us 4 bits for hosts = 16 addresses (14 usable)

Using `/28`:
- Binary mask: 11111111.11111111.11111111.11110000
- Subnets increment by 16

**10 Subnets starting at 10.0.2.0:**
1. **10.0.2.0/28** - Hosts: 10.0.2.1 to 10.0.2.14 (Broadcast: 10.0.2.15)
2. **10.0.2.16/28** - Hosts: 10.0.2.17 to 10.0.2.30 (Broadcast: 10.0.2.31)
3. **10.0.2.32/28** - Hosts: 10.0.2.33 to 10.0.2.46 (Broadcast: 10.0.2.47)
4. **10.0.2.48/28** - Hosts: 10.0.2.49 to 10.0.2.62 (Broadcast: 10.0.2.63)
5. **10.0.2.64/28** - Hosts: 10.0.2.65 to 10.0.2.78 (Broadcast: 10.0.2.79)
6. **10.0.2.80/28** - Hosts: 10.0.2.81 to 10.0.2.94 (Broadcast: 10.0.2.95)
7. **10.0.2.96/28** - Hosts: 10.0.2.97 to 10.0.2.110 (Broadcast: 10.0.2.111)
8. **10.0.2.112/28** - Hosts: 10.0.2.113 to 10.0.2.126 (Broadcast: 10.0.2.127)
9. **10.0.2.128/28** - Hosts: 10.0.2.129 to 10.0.2.142 (Broadcast: 10.0.2.143)
10. **10.0.2.144/28** - Hosts: 10.0.2.145 to 10.0.2.158 (Broadcast: 10.0.2.159)

**Why these subnets?**
- `/28` provides exactly 14 usable hosts (meets 5-11 requirement with room to grow)
- Starting at 10.0.2.0 avoids conflict with 10.0.1.0/24 and 10.0.0.0/26
- All 10 subnets fit within 10.0.2.0/24, keeping them organized and easy to manage
- We have 6 more /28 subnets available in 10.0.2.0/24 for future growth (10.0.2.160/28 through 10.0.2.240/28)