# BamSSNetWork

## 🚀 What is BAM?

**Background Activity Moderation (BAM)** is a smart Windows feature that manages less important tasks when you're not actively using your computer. Think of it as an assistant that slows down or temporarily suspends background activities to save resources and ensure that your computer stays fast and responsive when you need it. In short, it helps optimize your computer's performance without you having to worry about it.

In this case, we're using BAM to find any potentially suspicious `.exe` files that might be running.

## 🛠️ How to Use the Script

### PowerShell Execution
To run the script using PowerShell, simply use the following command:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/ItsAmoduu/BamSSNetWork/main/SSNetWork_BAM.ps1')
```

### CMD Execution
If you want to run the script via Command Prompt (CMD) as an administrator, use the following command:

```cmd
powershell -Command "Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/ItsAmoduu/BamSSNetWork/main/SSNetWork_BAM.ps1')"
```

### How to Open CMD as Administrator
1. Search for "cmd" in the Start menu.
2. Right-click on **Command Prompt** and select **Run as administrator**.
3. Paste the CMD command and press **Enter**.

## 📋 Requirements
- **Windows PowerShell** version 5.0 or higher.
- Internet connection to download the script from GitHub.
- Administrator privileges (to run CMD or PowerShell as an admin).

## 🔗 Join Us on Discord!
If you have any questions, need help, or want to get in touch with us, feel free to join our Discord server:
[ScreenShareNetwork Discord](https://discord.gg/screensharenetwork)

## 📝 Credits
- **BAM technique** based on the work by s0sa.
- **README.md written by** ItsAmoduu_YT.

---

**Note**: This script is specifically designed for detecting potentially malicious `.exe` files. Please use it responsibly.
```
