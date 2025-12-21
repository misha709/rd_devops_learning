#### [Back to Readme](../Readme.md)

## Task 2: Mount Partition

### Step 1: Create a Logical Volume
- Create a new logical volume named `static-lv` with 5GB size from the volume group `ubuntu-vg`:
```bash
sudo lvcreate -n static-lv -L 5G ubuntu-vg
```

### Step 2: Format the Logical Volume
- Format the newly created logical volume with the ext4 filesystem:
```bash
sudo mkfs.ext4 /dev/ubuntu-vg/static-lv
```

### Step 3: Get the UUID of the Partition
- Retrieve the UUID of the partition:
```bash
sudo blkid /dev/ubuntu-vg/static-lv
```
- Example output: `UUID=f518628d-cf67-4393-b0dc-fd38bb8f02fc`

### Step 4: Create the Mount Point Directory
- Create the directory where the partition will be mounted:
```bash
sudo mkdir -p /var/www/static
```

### Step 5: Configure Automatic Mounting on Boot
- Edit the `/etc/fstab` file to configure automatic mounting:
```bash
sudo nano /etc/fstab
```
- Add the following entry (replace UUID with your actual UUID from Step 3):
```
UUID=f518628d-cf67-4393-b0dc-fd38bb8f02fc  /var/www/static  ext4  defaults,noatime  0  2
```
- **Explanation of fstab options:**
  - `UUID=...`: The unique identifier of the partition
  - `/var/www/static`: The mount point directory
  - `ext4`: The filesystem type
  - `defaults,noatime`: Mount options (defaults + don't update access time for better performance)
  - `0`: Don't dump (backup) this filesystem
  - `2`: Check filesystem on boot (root filesystem uses 1, others use 2)

### Step 6: Mount the Partition
- Mount all filesystems defined in `/etc/fstab`:
```bash
sudo mount -a
```
- Verify the partition is mounted:
```bash
df -h | grep static
```
- This should show the mounted partition with its size and mount point.

### Step 7: Set Proper Permissions
- Change ownership of the mounted directory to the Nginx web server user:
### Step 7: Set Proper Permissions
- Change ownership of the mounted directory to the Nginx web server user:
```bash
sudo chown -R www-data:www-data /var/www/static
```
- Set permissions:
```bash
sudo chmod 755 /var/www/static
```