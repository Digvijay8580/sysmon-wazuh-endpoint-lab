# Detection Rules Explained

## Rule 100001 — Credential Dumping
- Monitors: Sysmon Event ID 10 (ProcessAccess)
- Detects: Any process accessing lsass.exe memory
- Why: Mimikatz and similar tools read lsass to steal credentials
- MITRE: T1003 - OS Credential Dumping
- Severity: Critical (Level 12)

## Rule 100002 — Registry Persistence
- Monitors: Sysmon Event ID 13 (RegistryEvent)
- Detects: Writes to CurrentVersion\Run keys
- Why: Malware adds itself to Run keys to survive reboot
- MITRE: T1547.001 - Boot/Logon Autostart
- Severity: High (Level 10)

## Rule 100003 — Office Process Spawning Shell
- Monitors: Sysmon Event ID 1 (ProcessCreate)
- Detects: cmd/PowerShell spawned from Word/Excel
- Why: Classic macro malware behavior
- MITRE: T1059 - Command and Scripting Interpreter
- Severity: Medium (Level 8)

## Rule 100004 — Whoami Reconnaissance
- Monitors: Sysmon Event ID 1 (ProcessCreate)
- Detects: whoami.exe execution
- Why: Attackers run whoami after initial access
- MITRE: T1033 - System Owner/User Discovery
- Severity: Medium (Level 6)

## Rule 100005 — New Service Creation
- Monitors: Sysmon Event ID 1 (ProcessCreate)
- Detects: sc.exe create commands
- Why: Malware creates services for persistence/privilege
- MITRE: T1543 - Create or Modify System Process
- Severity: High (Level 10)

## Rule 100006 — Malware File Drop
- Monitors: Sysmon Event ID 11 (FileCreate)
- Detects: Files with suspicious names created
- Why: Malware drops payloads to disk
- MITRE: T1105 - Ingress Tool Transfer
- Severity: Critical (Level 12)

## Rule 100007 — C2 Port Connection
- Monitors: Sysmon Event ID 3 (NetworkConnect)
- Detects: Connections to ports 4444, 1337, 9999, 8888
- Why: Common Metasploit/C2 framework ports
- MITRE: T1071 - Application Layer Protocol
- Severity: High (Level 8)

## Rule 100008 — Encoded PowerShell
- Monitors: Sysmon Event ID 1 (ProcessCreate)
- Detects: PowerShell -EncodedCommand flag
- Why: Attackers encode commands to evade detection
- MITRE: T1027 - Obfuscated Files or Information
- Severity: High (Level 10)
