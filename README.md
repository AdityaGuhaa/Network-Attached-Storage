# 🗄️ Network Attached Storage (NAS) Server — Linux + Samba

A self-hosted Network Attached Storage (NAS) server built using Linux and Samba on a dedicated laptop system. This project demonstrates secure LAN file sharing, user-based access control, structured storage layout, and production-style NAS configuration.

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

# 📦 Features

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
