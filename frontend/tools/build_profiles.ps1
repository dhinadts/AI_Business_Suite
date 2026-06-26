param(
  [ValidateSet("web", "apk", "all")]
  [string]$Target = "web"
)

$ErrorActionPreference = "Stop"

$profiles = @(
  @{ Name = "small"; Label = "Small Registered Company" },
  @{ Name = "medium"; Label = "Medium Registered Company" },
  @{ Name = "large"; Label = "Large Registered Company" },
  @{ Name = "grocery"; Label = "Grocery and Department Store" }
)

foreach ($profile in $profiles) {
  Write-Host "Building $($profile.Label) [$($profile.Name)] for $Target..."

  if ($Target -eq "web" -or $Target -eq "all") {
    flutter build web --dart-define=BUSINESS_PROFILE=$($profile.Name) --output build\web-$($profile.Name)
  }

  if ($Target -eq "apk" -or $Target -eq "all") {
    flutter build apk --debug --dart-define=BUSINESS_PROFILE=$($profile.Name)
    $apkDir = "build\profiles\$($profile.Name)"
    New-Item -ItemType Directory -Force -Path $apkDir | Out-Null
    Copy-Item "build\app\outputs\flutter-apk\app-debug.apk" "$apkDir\ai-business-manager-$($profile.Name)-debug.apk" -Force
  }
}

Write-Host "Profile builds complete."
