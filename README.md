#  Network Attached Storage (NAS) Server using Ubuntu (Linux) & Samba

A self-hosted Network Attached Storage (NAS) server built using Linux and Samba on a dedicated laptop system. This project demonstrates secure LAN file sharing, user-based access control, structured storage layout, and production-style NAS configuration.
---
Pictures are added below.
---

# 🎯 Project Goals

* Build a local NAS server using Linux
* Separate system and storage partitions
* Configure Samba shares with authentication
* Implement group-based access control
* Provide reproducible setup scripts
* Follow secure-by-default LAN-only exposure
* Create infra-grade documentation

---

# 💽 Disk Layout

```
Total Disk: ~1TB

System Partition → ~250 GB → OS
NAS Partition → ~750 GB → Mounted at /srv
```

---

# 🧩 Ubuntu Installation Partitioning Steps (Manual Setup)

During Ubuntu installation, choose **“Something else”** when asked about installation type. This allows manual partitioning for NAS-style split storage.

## Step‑by‑Step Partition Plan

Assuming a ~1TB disk:

### 1️⃣ EFI Partition (if UEFI system)

* Size: 512 MB – 1 GB
* Type: FAT32
* Mount point: `/boot/efi`
* Flag: EFI System Partition

### 2️⃣ Root Partition (System)

* Size: ~250 GB
* Filesystem: ext4
* Mount point: `/`
* Purpose: OS + applications

### 3️⃣ Swap Partition

* Size: 4–16 GB (depending on RAM and hibernation needs)
* Type: swap area

### 4️⃣ NAS Storage Partition

* Size: Remaining space (~750 GB)
* Filesystem: ext4
* Mount point: `/srv`
* Purpose: Dedicated NAS storage volume

---

## Example Layout Table

| Partition | Size    | FS    | Mount     |
| --------- | ------- | ----- | --------- |
| EFI       | 512M–1G | FAT32 | /boot/efi |
| Root      | 250G    | ext4  | /         |
| Swap      | 8G      | swap  | —         |
| NAS       | ~750G   | ext4  | /srv      |

---

## Post‑Install Verification

After installation, verify layout using:

```bash
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT
```

You should see a large partition mounted at `/srv`, which will be used for NAS storage.

---

# 📁 NAS Folder Structure

```
/srv/nas/
├── public/
├── private/
├── media/
├── backups/
└── projects/
```

---

# 🔐 Security Model

* No guest access
* Username + password required
* Samba user database authentication
* Linux group-based permissions (`nasusers`)
* LAN-only exposure (no WAN SMB exposure)
* Proper permission masks:

  * files: 0664
  * directories: 2775

---

# ⚙️ Technologies Used

* Linux (Debian/Ubuntu-based distributions)
* Samba (SMB/CIFS)
* systemd services
* Linux groups & permissions
* ext4 filesystem
* LAN networking

---

# 🚀 Setup Steps (Summary)

```bash
lsblk
sudo apt update
sudo apt install samba

sudo groupadd nasusers
sudo usermod -aG nasusers <user>

sudo mkdir -p /srv/nas/{public,private,media,backups,projects}

sudo chown -R root:nasusers /srv/nas
sudo chmod -R 2775 /srv/nas

sudo nano /etc/samba/smb.conf
#Add [NAS] and [NAS-PUBLIC] to the bottom of the script
#[NAS] and [NAS-PUBLIC] is available inside config folder of this repo

sudo smbpasswd -a <user>
sudo smbpasswd -e <user>

sudo systemctl restart smbd
```

Detailed reusable scripts are available in the `/setup` directory of this repository.

---

# 🌐 Network Access

Clients on the same LAN can connect using:

```
\\NAS_IP\NAS
```

Example:

```
\\192.168.1.50\NAS
```

Supported clients:

* Windows
* Linux
* macOS
* Android (SMB client apps)
* iOS (Files app SMB support)

---

# 🧪 Validation Commands

```bash
testparm
sudo systemctl status smbd
smbclient -L localhost -U <user>
hostname -I
```

These commands help verify configuration correctness, service status, and network reachability.

---

# ScreenShots (Inside Host)

<img width="688" height="529" alt="Screenshot from 2026-01-30 00-06-21" src="https://github.com/user-attachments/assets/f8b3625e-4eb0-46eb-a500-902f3c500c0d" />
<img width="1662" height="516" alt="Screenshot from 2026-01-30 00-06-51" src="https://github.com/user-attachments/assets/3a19ec40-e81f-4785-87c2-8b819a7c7a96" />
<img width="1913" height="1077" alt="Screenshot from 2026-01-30 00-07-13" src="https://github.com/user-attachments/assets/5ff40bce-10aa-4e55-9b90-37397e8e8327" />
<img width="990" height="589" alt="Screenshot from 2026-01-30 00-07-30" src="https://github.com/user-attachments/assets/ca01a47d-4010-47e7-9d31-0eaefff2580c" />

---

# Features

* Structured NAS storage layout
* Authenticated SMB shares
* Group-based permission model
* Multi-device LAN access
* Persistent mount configuration
* Laptop NAS hardening support
* Reproducible setup scripts

---

# 🛡️ Hardening Notes

* Guest access disabled on all shares
* Access restricted to authorized users only
* SMB not exposed to the public internet
* Recommended to use VPN/mesh network for remote access
* Optional lid-close sleep disable for laptop NAS deployments

---

# 🔮 Future Enhancements

* Encrypted NAS volume (LUKS)
* Snapshot-based backups
* Web UI dashboard
* Personal cloud layer
* Remote access via secure VPN mesh
* Containerized service stack
* Disk health monitoring & alerts

---

# 📚 Learning Outcomes

This project demonstrates practical skills in:

* Linux system administration
* Network file sharing
* Access control design
* Storage structuring
* Service configuration
* Infrastructure reproducibility
* Home-lab server design

---

# 👨‍💻 Author

Aditya Guha
AI & ML Enthusiast • Systems Builder • Self-Hosted Infrastructure Explorer

---

# 📜 License

This project is open-source and available for learning and educational use. Customize and extend based on your own infrastructure needs.
