Start-Sleep -Seconds 10
$filePath = "$env:APPDATA\test.txt"
New-Item -Path $filePath -ItemType File -Force
