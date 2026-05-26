# Lab Setup Guide

## Prerequisites
- VMware Workstation Pro
- Windows 10 ISO
- Kali Linux 2026.1 VM
- 8GB+ RAM on host machine
- 100GB+ free disk space

## Phase 1: Environment Setup
1. Install VMware Workstation Pro
2. Create Windows 10 VM (4GB RAM, 60GB disk, 2 CPUs)
3. Configure both VMs on VMnet1 (Host-only)
4. Verify connectivity with ping test

## Phase 2: Sysmon Installation
1. Download Sysmon from Microsoft Sysinternals
2. Download SwiftOnSecurity sysmon-config
3. Install: `Sysmon64.exe -accepteula -i sysmonconfig.xml`
4. Verify in Event Viewer

## Phase 3: Wazuh Installation
1. On Kali: `curl -sO https://packages.wazuh.com/4.7/wazuh-install.sh`
2. Run: `sudo bash wazuh-install.sh -a -i`
3. Access dashboard: `https://192.168.80.128`

## Phase 4: Agent Connection
1. Install Wazuh agent on Windows 10
2. Configure ossec.conf with manager IP
3. Add Sysmon log collection block
4. Start WazuhSvc service

## Phase 5: Custom Rules
1. Edit `/var/ossec/etc/rules/local_rules.xml` on Kali
2. Add custom detection rules
3. Restart wazuh-manager

## Phase 6: Attack Simulation
1. Run simulate_attacks.ps1 on Windows 10
2. Monitor alerts in Wazuh dashboard
3. Document findings
