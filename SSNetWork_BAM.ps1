# Set the window title
$host.UI.RawUI.WindowTitle = "Administrator: PowerShell - Sconfiggiamo gli shittycheaters! - .gg/screensharenetwork"

# Load Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Function to get the file signature
function Get-Signature {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    if (-not (Test-Path -PathType Leaf -Path $FilePath)) {
        return "File Not Found"
    }

    try {
        $Authenticode = (Get-AuthenticodeSignature -FilePath $FilePath -ErrorAction Stop).Status
        switch ($Authenticode) {
            "Valid"        { return "Valid Signature" }
            "NotSigned"    { return "Invalid Signature (NotSigned)" }
            "HashMismatch" { return "Invalid Signature (HashMismatch)" }
            "NotTrusted"   { return "Invalid Signature (NotTrusted)" }
            default        { return "Invalid Signature (UnknownError)" }
        }
    } catch {
        return "Error Retrieving Signature: $_"
    }
}

# Function to check for admin privileges
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# Function to mount the registry if not present
function Mount-Registry {
    if (!(Get-PSDrive -Name HKLM -PSProvider Registry)) {
        Try {
            New-PSDrive -Name HKLM -PSProvider Registry -Root HKEY_LOCAL_MACHINE
            Write-Host "Registry HKLM mounted successfully" -ForegroundColor Green
        } Catch {
            Write-Warning "Error Mounting HKEY_Local_Machine"
            Exit
        }
    }
}

# Function to retrieve BAM information
function Get-BAMData {
    $UserSettingsPath = "HKLM:\SYSTEM\CurrentControlSet\Services\bam\State\UserSettings"

    # Check if the UserSettings path exists
    if (-not (Test-Path $UserSettingsPath)) {
        Write-Warning "UserSettings path not found."
        return @()  # Return an empty array if the path does not exist
    }

    # Dictionary to track the count of each app's executions
    $appExecutionCounts = @{}

    $BamItems = Get-ChildItem -Path $UserSettingsPath -ErrorAction Stop
    $bamData = foreach ($Item in $BamItems) {
        $Key = Get-ItemProperty -Path $Item.PSPath -ErrorAction Stop
        foreach ($App in $Key.PSObject.Properties) {
            if ($App.Value.Length -eq 24) {
                # Convert timestamp from hexadecimal
                $Hex = [System.BitConverter]::ToString($App.Value[7..0]) -replace "-", ""
                $TimeUTC = Get-Date ([DateTime]::FromFileTime([Convert]::ToInt64($Hex, 16))) -Format "yyyy-MM-dd HH:mm:ss"
                $TimeUser = (Get-Date ([DateTime]::FromFileTimeUtc([Convert]::ToInt64($Hex, 16))).AddMinutes(0) -Format "yyyy-MM-dd HH:mm:ss")

                # Extract path and file signature
                $Path = Join-Path -Path "C:" -ChildPath ($App.Name.Remove(1, 23))
                $Signature = Get-Signature -FilePath $Path

                # Extract application name
                $Application = Split-Path -Leaf $App.Name

                # Increment the run counter for this application (global run count since system start)
                $GlobalRunCount = (Get-Process -Name $Application -ErrorAction SilentlyContinue).Count

                # Create custom object with Run Counter
                [PSCustomObject]@{
                    'Execution Time (UTC)'     = $TimeUTC
                    'Last Execution User Time' = $TimeUser
                    'Application'              = $Application
                    'Path'                     = $Path
                    'Signature'                = $Signature
                    'Run Counter (This Session)' = if ($appExecutionCounts.ContainsKey($Application)) { $appExecutionCounts[$Application]++ } else { $appExecutionCounts[$Application] = 1; 1 }
                    'Run Counter (Global)'     = $GlobalRunCount
                }
            }
        }
    }
    return $bamData
}

# Function to open a new window showing file details
function Show-FileDetails {
    param (
        [PSCustomObject]$SelectedItem
    )

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "File Details"
    $form.Size = New-Object System.Drawing.Size(400, 250)

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "Application Path:"
    $label.Location = New-Object System.Drawing.Point(10, 20)
    $label.Size = New-Object System.Drawing.Size(380, 30)

    $textbox = New-Object System.Windows.Forms.TextBox
    $textbox.Text = $SelectedItem.Path
    $textbox.Location = New-Object System.Drawing.Point(10, 50)
    $textbox.Size = New-Object System.Drawing.Size(360, 30)
    $textbox.ReadOnly = $true

    $copyButton = New-Object System.Windows.Forms.Button
    $copyButton.Text = "Copy Path"
    $copyButton.Location = New-Object System.Drawing.Point(10, 100)
    $copyButton.Add_Click({
        [System.Windows.Forms.Clipboard]::SetText($textbox.Text)
        [System.Windows.Forms.MessageBox]::Show("Path Copied!")
    })

    $runButton = New-Object System.Windows.Forms.Button
    $runButton.Text = "Info"  # Changed to "Info"
    $runButton.Location = New-Object System.Drawing.Point(120, 100)
    $runButton.Add_Click({
        Start-Process -FilePath $textbox.Text
        # Keeping the BAM open and refreshing the data
        $form.Close()  # Close the form before refreshing the BAM window
        Initialize-Program  # Call this function to refresh the BAM view
    })

    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Text = "Cancel"
    $cancelButton.Location = New-Object System.Drawing.Point(230, 100)
    $cancelButton.Add_Click({
        $form.Close()
    })

    $form.Controls.Add($label)
    $form.Controls.Add($textbox)
    $form.Controls.Add($copyButton)
    $form.Controls.Add($runButton)
    $form.Controls.Add($cancelButton)

    # Show the form as a modal dialog
    $form.ShowDialog() | Out-Null
}

# Function to initialize the program
function Initialize-Program {
    Clear-Host
    if (-not (Test-Admin)) {
        Write-Warning "Please run this script with administrative privileges."
        Exit
    }

    Write-Host @"
░██████╗░█████╗░██████╗░███████╗███████╗███╗░░██╗░██████╗██╗░░██╗░█████╗░██████╗░███████╗
██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝████╗░██║██╔════╝██║░░██║██╔══██╗██╔══██╗██╔════╝
╚█████╗░██║░░╚═╝██████╔╝█████╗░░█████╗░░██╔██╗██║╚█████╗░███████║███████║██████╔╝█████╗░░
░╚═══██╗██║░░██╗██╔══██╗██╔══╝░░██╔══╝░░██║╚████║░╚═══██╗██╔══██║██╔══██║██╔══██╗██╔══╝░░
██████╔╝╚█████╔╝██║░░██║███████╗███████╗██║░╚███║██████╔╝██║░░██║██║░░██║██║░░██║███████╗
╚═════╝░░╚════╝░╚═╝░░╚═╝╚══════╝╚══════╝╚═╝░░╚══╝╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝

███╗░░██╗███████╗████████╗░██╗░░░░░░░██╗░█████╗░██████╗░██╗░░██╗
████╗░██║██╔════╝╚══██╔══╝░██║░░██╗░░██║██╔══██╗██╔══██╗██║░██╔╝
██╔██╗██║█████╗░░░░░██║░░░░╚██╗████╗██╔╝██║░░██║██████╔╝█████═╝░
██║╚████║██╔══╝░░░░░██║░░░░░████╔═████║░██║░░██║██╔══██╗██╔═██╗░
██║░╚███║███████╗░░░██║░░░░░╚██╔╝░╚██╔╝░╚█████╔╝██║░░██║██║░╚██╗
╚═╝░░╚══╝╚══════╝░░░╚═╝░░░░░░╚═╝░░░╚═╝░░░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝
██████╗░░█████╗░███╗░░░███╗
██╔══██╗██╔══██╗████╗░████║
██████╦╝███████║██╔████╔██║
██╔══██╗██╔══██║██║╚██╔╝██║
██████╦╝██║░░██║██║░╚═╝░██║
╚═════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝
"@ -ForegroundColor Red
    Write-Host " " * 2
    Write-Host "Retrieving BAM Entries from the Windows Registry..." -ForegroundColor Yellow
    Write-Host "This is the Best BAM Entries in Existence [-ShittyScreensharer wtfclicker?.-]" -ForegroundColor Cyan

    Mount-Registry

    # Call Get-BAMData and store the results
    $bamResults = Get-BAMData

    if ($bamResults.Count -eq 0) {
        Write-Host "No BAM data found."
    } else {
        # Display BAM data in a grid view
        $selectedItem = $bamResults | Out-GridView -Title "Select an Application" -PassThru

        # Show file details for the selected item
        if ($selectedItem -ne $null) {
            Show-FileDetails -SelectedItem $selectedItem
            # Refresh the BAM view after closing the detail window
            Initialize-Program  # Re-initialize the program to show BAM again
        } else {
            Write-Host "No application selected."
        }
    }
}

# Start the program
Initialize-Program

