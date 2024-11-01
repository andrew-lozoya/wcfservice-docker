# Start the service monitor to keep w3svc running
Start-Process "C:\ServiceMonitor.exe" -ArgumentList "w3svc"

# Allow some time before restarting IIS
Start-Sleep -Seconds 5

# Log the restarting message
Write-Output "Restarting IIS service..."

# Restart IIS
Stop-Service -Name 'w3svc'
Start-Service -Name 'w3svc'

# Log that IIS has been restarted
Write-Output "IIS service has been restarted."

# Infinite loop to keep the container alive and check IIS status
while ($true) {
    $iisStatus = Get-Service -Name 'w3svc'
    if ($iisStatus.Status -eq 'Running') {
        Write-Output "IIS is healthy."
    }
    else {
        Write-Output "IIS is restarting..."
    }
    Start-Sleep -Seconds 10
}
