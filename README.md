## 1. Setup Windows Environment.

Run with:

```powershell
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/phil-holden/pc-setup/main/scripts/setup.ps1'))
```

## 2. Setup PowerShell Core.

Run with:

```powershell
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/phil-holden/pc-setup/main/scripts/pwsh-config.ps1'))
```

## 3. Install WSL Ubuntu.

Run with:

```powershell
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/phil-holden/pc-setup/main/scripts/wsl-install.ps1'))
```

## 3. Configure WSL Ubuntu (shell / tools).

Run with:

```powershell
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/phil-holden/pc-setup/main/scripts/wsl-config.ps1'))
```
