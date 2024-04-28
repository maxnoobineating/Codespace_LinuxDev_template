$prevWindowTitle = ""

while ($true) {
  # Get the foreground process and window title
  $foregroundProcess = Get-Process | Where-Object {$_.MainWindowTitle }
  $windowTitle = $foregroundProcess.MainWindowTitle

  # Check if window title changed (assuming focus change)
  if ($windowTitle -ne $prevWindowTitle) {
    Write-Host "Terminal window $windowTitle lost focus!"
    # You can add your desired actions here (e.g., clipboard sync)
  }

  # Update previous window title for comparison
  $prevWindowTitle = $windowTitle

  # Wait a short interval before checking again (adjust as needed)
  Start-Sleep -Seconds 1
}