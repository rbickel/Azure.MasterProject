# Input bindings are passed in via param block.
param($Timer)

# Get the current universal time in the default string format.
$currentUTCtime = (Get-Date).ToUniversalTime()

# The 'IsPastDue' property is 'true' when the current function invocation is later than scheduled.
if ($Timer.IsPastDue) {
    Write-Host "PowerShell timer is running late!"
}

# Write an information log with the current time.
Write-Host "PowerShell timer trigger function ran! TIME: $currentUTCtime"

$enc = [System.Text.Encoding]::UTF8
$versions = @()
Get-AzLocation | ForEach-Object { 
    $location = $_.Location
    $locationDisplayName = $_.DisplayName
    Write-Host "Location: $($location)"
    Write-Host "Retrieving versions for $($_.Location)"

    Get-AzAksVersion -Location $location -ErrorAction SilentlyContinue | ForEach-Object {
        $versions += @{
            location            = $location
            locationDisplayName = $locationDisplayName
            version             = $_.OrchestratorVersion
            isPreview           = $_.IsPreview
            isDefault           = $_.DefaultProperty
            upgrades            = $_.Upgrades
        }
    }
}

Write-Host "Write cache to file"
$cache = $enc.GetBytes($($versions | ConvertTo-Json -Depth 5))
Push-OutputBinding -Name CacheOutput -Value $cache
