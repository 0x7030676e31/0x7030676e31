Start-Job -ScriptBlock {
  Start-Sleep -Seconds 1
  $filePath = "$env:APPDATA\test.txt"
  New-Item -Path $filePath -ItemType File -Force
}
