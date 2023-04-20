# Utilize SentinelOne Remote Script Orchestration (RSO) & Automation to deploy Velociraptor

function velociraptor(
    [Parameter(Mandatory = $true)][string]$url
) {    
    $TempFolder = ([io.path]::GetTempPath())
    $VelociraptorMSIPath = Join-Path $TempFolder "Velociraptor.msi"

    try {
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri "$url" -OutFile $VelociraptorMSIPath
    }
    catch {
        Write-Error "Error downloading the Velociraptor package. Error $PSItem"
        exit 1
    }

    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$VelociraptorMSIPath`" /qn" -Wait -NoNewWindow
}

velociraptor @Args
