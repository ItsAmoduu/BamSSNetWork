# 🏴󠁧󠁢󠁥󠁮󠁧󠁿

This repository contains the **SSNetWork_BAM.ps1** script, which leverages Windows' **Background Activity Moderation (BAM)** to identify and monitor any potentially suspicious `.exe` files running on your system. The script is designed to enhance your system's security by making it easier to spot unwanted background activity.

## 🚀 What is BAM?

**Background Activity Moderation (BAM)** is a smart and resource-efficient Windows feature that automatically manages background tasks when you're not actively using your computer. Think of BAM as your personal assistant, helping to maintain optimal performance by temporarily slowing down or suspending non-critical activities running in the background. 

The goal is simple: **BAM ensures your computer stays fast and responsive when you need it** while managing less important tasks in the background. In this specific use case, BAM is applied to identify any potentially malicious `.exe` files that may be operating in the background without your knowledge.

## 🛠️ How to Use the Script

### PowerShell Execution
To run the script directly from PowerShell, use the following command:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/ItsAmoduu/BamSSNetWork/main/SSNetWork_BAM.ps1')
```

### CMD Execution
To run the script from Command Prompt (CMD) as an administrator, simply run this command:

```cmd
powershell -Command "Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/ItsAmoduu/BamSSNetWork/main/SSNetWork_BAM.ps1')"
```

### How to Open CMD as Administrator
1. Search for **cmd** in the Start menu.
2. Right-click on **Command Prompt** and choose **Run as administrator**.
3. Paste the above CMD command and press **Enter**.

## 📋 Requirements
- **Windows PowerShell** version 5.0 or higher.
- An active internet connection to download the script from GitHub.
- Administrator privileges (to run CMD or PowerShell as admin).

## 🔗 Join Us on Discord!
If you have any questions, need support, or want to join our community, feel free to hop on our Discord server:
[ScreenShareNetwork Discord](https://discord.gg/screensharenetwork)

## 📝 Credits
- **BAM technique** developed by **s0sa**.
- **README.md** written by **ItsAmoduu_YT**.

```
**Note**: This script is designed for the specific use case of detecting potentially suspicious `.exe` files. Please ensure you use it responsibly to safeguard your system's integrity.
```

# 🇮🇹

Questo repository contiene lo script **SSNetWork_BAM.ps1**, che sfrutta la funzione di **Background Activity Moderation (BAM)** di Windows per individuare e monitorare eventuali file `.exe` sospetti in esecuzione sul tuo sistema. Lo script è progettato per migliorare la sicurezza del tuo computer, aiutandoti a identificare attività indesiderate in background.

## 🚀 Cos'è BAM?

**Background Activity Moderation (BAM)** è una funzione intelligente di Windows che gestisce automaticamente le attività in background quando non stai utilizzando attivamente il tuo computer. Puoi considerare BAM come un assistente personale che aiuta a mantenere prestazioni ottimali rallentando o sospendendo temporaneamente le attività meno critiche in esecuzione in background. 

L'obiettivo è semplice: **BAM assicura che il tuo computer rimanga veloce e reattivo quando ne hai bisogno**, gestendo contemporaneamente le attività meno importanti. In questo caso specifico, BAM viene utilizzato per identificare eventuali file `.exe` potenzialmente dannosi che potrebbero essere attivi in background senza il tuo consenso.

## 🛠️ Come utilizzare lo script

### Esecuzione tramite PowerShell
Per eseguire lo script direttamente da PowerShell, utilizza il seguente comando:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/ItsAmoduu/BamSSNetWork/main/SSNetWork_BAM.ps1')
```

### Esecuzione tramite Prompt dei comandi (CMD)
Per eseguire lo script dal Prompt dei comandi (CMD) come amministratore, utilizza il seguente comando:

```cmd
powershell -Command "Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/ItsAmoduu/BamSSNetWork/main/SSNetWork_BAM.ps1')"
```

### Come aprire CMD come amministratore
1. Cerca **cmd** nel menu Start.
2. Fai clic con il tasto destro su **Prompt dei comandi** e seleziona **Esegui come amministratore**.
3. Incolla il comando CMD sopra riportato e premi **Invio**.

## 📋 Requisiti
- **Windows PowerShell** versione 5.0 o successiva.
- Connessione a Internet attiva per scaricare lo script da GitHub.
- Privilegi di amministratore (per eseguire CMD o PowerShell come admin).

## 🔗 Unisciti a noi su Discord!
Per qualsiasi domanda, supporto o per unirti alla nostra community, sentiti libero di visitare il nostro server Discord:
[ScreenShareNetwork Discord](https://discord.gg/screensharenetwork)

## 📝 Crediti
- **BAM** developed by **s0sa**.
- **README.md** scritto da **ItsAmoduu_YT**.

---

**Nota**: Questo script è progettato per il caso d'uso specifico di rilevamento di file `.exe` potenzialmente sospetti. Si prega di utilizzarlo in modo responsabile per salvaguardare l'integrità del sistema.
```
