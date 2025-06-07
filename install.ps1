$packId = "REPLACE_ME"
$packVersion = "REPLACE_ME"

$downloadUrl = "https://github.com/FTBTeam/FTB-Server-Installer/releases/latest/download/ftb-server-"

# Attempt to get the users operating system
$os = ""
if ($IsWindows) {
    $os = "windows"
} elseif ($IsLinux) {
    $os = "linux"
} elseif ($IsFreeBSD) {
    $os = "freebsd"
} elseif ($IsMacOS) {
    $os = "darwin"
} else {
    Write-Host "Unsupported operating system."
    exit 1
}

# Attempt to get the users architecture
$arch = "amd64"
if ($IsArm) {
    $arch = "arm64"
}

Write-Host "Detected operating system: $os"
Write-Host "Detected architecture: $arch"

$completeUrl = "${downloadUrl}${os}-${arch}"

Write-Host "Downloading FTB Server Installer from: $completeUrl"

$fileName = "ftb-server-installer"
if ($packId -ne "REPLACE_ME") {
    $fileName += "-$packId"
}
if ($packVersion -ne "REPLACE_ME") {
    $fileName += "-$packVersion"
}

# Download the file
$destinationPath = Join-Path -Path (Get-Location) -ChildPath $fileName

try {
    Invoke-WebRequest -Uri $completeUrl -OutFile $destinationPath -ErrorAction Stop
} catch {
    Write-Host "Failed to download the file. Please check the URL or your internet connection." -ForegroundColor Red
    exit 1
}

Write-Host "Downloaded FTB Server Installer to: $destinationPath" -ForegroundColor Green
Write-Host "You can now run the installer using the command: ./$fileName" -ForegroundColor Cyan