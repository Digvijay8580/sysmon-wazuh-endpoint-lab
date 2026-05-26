# ============================================
# Sysmon + Wazuh Attack Simulation Script
# Lab: Endpoint Detection Home Lab
# WARNING: Run ONLY in isolated lab environment
# ============================================

Write-Host "========================================" -ForegroundColor Red
Write-Host "  ATTACK SIMULATION SCRIPT" -ForegroundColor Red
Write-Host "  Run only in isolated lab VM!" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Red
Start-Sleep -Seconds 2

# ---- Simulation 1: Reconnaissance ----
Write-Host "`n[*] Simulation 1: Reconnaissance (T1033)" -ForegroundColor Cyan
whoami
whoami /priv
net user
net localgroup administrators
ipconfig /all
systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
Write-Host "[+] Reconnaissance simulation complete" -ForegroundColor Green
Start-Sleep -Seconds 2

# ---- Simulation 2: Registry Persistence ----
Write-Host "`n[*] Simulation 2: Registry Persistence (T1547.001)" -ForegroundColor Cyan
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" `
  -Name "WindowsUpdateHelper" `
  -Value "C:\Windows\Temp\update.exe" `
  -PropertyType String -Force
Write-Host "[+] Registry persistence key created" -ForegroundColor Green
Start-Sleep -Seconds 2

# ---- Simulation 3: Suspicious Process ----
Write-Host "`n[*] Simulation 3: Suspicious Process Creation (T1059)" -ForegroundColor Cyan
Start-Process cmd.exe -ArgumentList "/c whoami && ipconfig && net user"
Start-Process powershell.exe -ArgumentList "-Command Get-Process"
Write-Host "[+] Suspicious processes spawned" -ForegroundColor Green
Start-Sleep -Seconds 2

# ---- Simulation 4: Credential Access ----
Write-Host "`n[*] Simulation 4: Credential Access (T1003)" -ForegroundColor Cyan
Get-Process lsass
$lsassPID = (Get-Process lsass).Id
Write-Host "[+] LSASS PID accessed: $lsassPID" -ForegroundColor Green
Start-Sleep -Seconds 2

# ---- Simulation 5: EICAR Test File ----
Write-Host "`n[*] Simulation 5: Malware File Drop (T1105)" -ForegroundColor Cyan
$eicar = 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*'
Set-Content -Path "C:\Temp\malware_test.txt" -Value $eicar
Write-Host "[+] EICAR test file created at C:\Temp\malware_test.txt" -ForegroundColor Green
Start-Sleep -Seconds 2

# ---- Simulation 6: Defense Evasion ----
Write-Host "`n[*] Simulation 6: Encoded PowerShell (T1027)" -ForegroundColor Cyan
$command = "Get-Process"
$encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($command))
Start-Process powershell.exe -ArgumentList "-EncodedCommand $encoded"
Write-Host "[+] Encoded PowerShell command executed" -ForegroundColor Green
Start-Sleep -Seconds 2

# ---- Cleanup ----
Write-Host "`n[*] Cleaning up simulation artifacts..." -ForegroundColor Yellow
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" `
  -Name "WindowsUpdateHelper" -ErrorAction SilentlyContinue
Remove-Item "C:\Temp\malware_test.txt" -ErrorAction SilentlyContinue
Write-Host "[+] Cleanup complete" -ForegroundColor Green

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  ALL SIMULATIONS COMPLETE!" -ForegroundColor Green
Write-Host "  Check Wazuh dashboard for alerts" -ForegroundColor Green
Write-Host "  https://192.168.80.128" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
