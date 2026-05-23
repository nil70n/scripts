# cleanup-aspire.ps1
# PowerShell script to clean up Aspire processes and temporary files
# This resolves the "kubeconfig file is being used by another process" error

Write-Host "Cleaning up Aspire processes and temporary files..." -ForegroundColor Yellow

# Kill dotnet processes that might be holding files
$dotnetProcesses = Get-Process -Name "dotnet" -ErrorAction SilentlyContinue
if ($dotnetProcesses) {
    Write-Host "Found $($dotnetProcesses.Count) dotnet processes" -ForegroundColor Cyan
    $dotnetProcesses | ForEach-Object {
        Write-Host "Stopping process: PID $($_.Id), Started: $($_.StartTime)" -ForegroundColor Gray
        Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
    }
    Write-Host "Stopped all dotnet processes" -ForegroundColor Green
} else {
    Write-Host "No dotnet processes found" -ForegroundColor Green
}

# Clean up Aspire temp directories
$aspireDirectories = Get-ChildItem -Path "$env:LOCALAPPDATA\Temp" -Directory -Filter "aspire.*" -ErrorAction SilentlyContinue
if ($aspireDirectories) {
    Write-Host "Found $($aspireDirectories.Count) Aspire temp directories to clean" -ForegroundColor Cyan
    $removedCount = 0
    $failedCount = 0
    
    $aspireDirectories | ForEach-Object {
        try {
            Remove-Item $_.FullName -Recurse -Force
            Write-Host "✓ Removed: $($_.Name)" -ForegroundColor Green
            $removedCount++
        } catch {
            Write-Host "✗ Could not remove: $($_.Name) - $($_.Exception.Message)" -ForegroundColor Red
            $failedCount++
        }
    }
    
    Write-Host "Cleanup summary: $removedCount removed, $failedCount failed" -ForegroundColor Cyan
} else {
    Write-Host "No Aspire temp directories found" -ForegroundColor Green
}

Write-Host "Cleanup complete!" -ForegroundColor Yellow
Write-Host "You can now run your integration tests again." -ForegroundColor Green