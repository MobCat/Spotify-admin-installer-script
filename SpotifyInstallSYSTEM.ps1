Write-Output "Manually installing Spotify..."

## Extrat program files into well program files..
Write-Output "Unpacking Spotify files."
## You Need to download the full offline installer first!
##http://download.spotify.com/SpotifyFullSetup.exe
Start-Process -Wait -FilePath '.\SpotifyFullSetup.exe' -ArgumentList ‘/extract "C:\Program Files\Spotify"’

## Add desktop shortcut
Write-Output "Creating Spotify Desktop Shortcut."
$SourceFilePath = "C:\Program Files\Spotify\Spotify.exe"
$ShortcutPath = "C:\Users\Public\Desktop\Spotify.lnk"
$WScriptObj = New-Object -ComObject ("WScript.Shell")
$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$shortcut.TargetPath = $SourceFilePath
$shortcut.Save()

## Add start menu shortcut
Write-Output "Creating Spotify Start Menu Shortcut."
$SourceFilePath = "C:\Program Files\Spotify\Spotify.exe"
$ShortcutPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Spotify.lnk"
$WScriptObj = New-Object -ComObject ("WScript.Shell")
$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$shortcut.TargetPath = $SourceFilePath
$shortcut.Save()

## Add Spotify to Programs and Features
Write-Output "Adding Spotify to Programs and Features list."
[void](New-Item -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall' -Name 'Spotify')
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Spotify' -Name 'DisplayIcon' -Value 'C:\Program Files\Spotify\Spotify.exe,0' -Type String
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Spotify' -Name 'DisplayName' -Value 'Spotify' -Type String
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Spotify' -Name 'DisplayVersion' -Value '1.1.73.517' -Type String
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Spotify' -Name 'EstimatedSize' -Value '195000' -Type Dword
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Spotify' -Name 'InstallLocation' -Value 'C:\Program Files\Spotify' -Type ExpandString
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Spotify' -Name 'NoModify' -Value '1' -Type Dword
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Spotify' -Name 'NoRepair' -Value '1' -Type Dword
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Spotify' -Name 'Publisher' -Value 'Spotify AB' -Type String
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Spotify' -Name 'UninstallString' -Value '"C:\Program Files\Spotify\Spotify.exe" /uninstall' -Type ExpandString
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Spotify' -Name 'URLInfoAbout' -Value 'https://www.spotify.com' -Type String

Write-Output "Done."