# Spotify admin installer script
Powershell scripts for manually installing Spotify

# What is this
This is a set of powershell scripts and a little clean up reg file
that will let you install Spotify while logged in as admin,<br>
Silent install from command line without prompts,<br>
Install directly to the system or the local users profile,<br>
Or a combination of any of those.<br>
Should go without saying even know I am, this is for windows only. No idea how to do this on mac, linux or if this is even an issue on other os'es.

# Why?
That I'm not sure about. I can't see very many good reasons for this restriction but, the installer will give you an error blocking you from installing it while logged in as admin or right clicking on the installer and running it as admin.<br>
As I have just proven you can still install to local user while logged in as admin<br>
and you can install directly to system if you want, no user folder needed.<br>
Outside of poorly implemented security reasons (having the Spotify app running as admin) I can't see and or can find any reason for not spotify running as admin, I have no idea why the installer wont let you install as admin, but as I have just proven you can both install it as admin and to the system directly.
as for why even bother and just run as a user?<br>
well 2 reasons. There are people who are logged into their computer and use their computer as admin, and that's fine IMO.<br>
2 and the reason why I built this, deployment scripts, eg. you have to install Spotify on 100 computers today in the office along with a bunch of other stuff like adobe reader, office, etc.<br>
Doing all of that by hand on every computer is insane. Now you can just add this install script to your current deployment script and install Spotify along with all the other programs you have to install.<br>

# How to use
First off, you need to download the full offline installer for Spotify here<br>
[https://download.spotify.com/SpotifyFullSetup.exe](https://download.spotify.com/SpotifyFullSetup.exe)<br>
Then download whichever powershell script you want to use from this github and place it in the same folder as SpotifyFullSetup.exe<br>
(If you don't know which script you should run, just use the SpotifyInstallUSER.ps1 script to install it to the current user, this is the same way running the installer normally would install.<br>
**Installing from command line**
Open cmd or powershell with or without admin, it doesn't matter.<br>
then `cd` over to where you have both the powershell script and SpotifyFullSetup.exe saved to.<br>
Then simply run<br>
`powershell -ExecutionPolicy ByPass -File "SpotifyInstallUSER.ps1"`<br>
To install to, and as current user.<br>
To install as, and to system run<br>
`powershell -ExecutionPolicy ByPass -File "SpotifyInstallSYSTEM.ps1"`<br><br>
**Installing with python**
Add the following to your current py script or make a new script.<br>
If you already have `import subprocess` please do not import it a 2nd time...<br>
```python
import subprocess
subprocess.call('powershell -ExecutionPolicy ByPass -File "SpotifyInstallUSER.ps1"', shell=True)
```
This will run the script, wait for it to finish, them move onto the next thing in your script.<br>
if the py script, the powershell script and SpotifyFullSetup.exe are all not in the same folder you will have to edit the python and powershell script accordingly<br>
python<br>
```python
subprocess.call('powershell -ExecutionPolicy ByPass -File "Spotify\\SpotifyInstallUSER.ps1"', shell=True)
```
powershell USER script<br>
```powershell
Start-Process -Wait -FilePath '.\Spotify\SpotifyFullSetup.exe' -ArgumentList "/extract C:\Users\$([Environment]::UserName)\AppData\Roaming\Spotify\"
```
<br>

# Bugs?
Well these are mostly to do with installing Spotify as system and not being able to test it much as I don't really use Spotify, I'm just the sysadmin here.<br>
So the installing part works fine. Running it seems to work fine, unsure about logging in and uninstalling is sorta bugged.<br>
**Logging in**
I am unsure where spotify keeps its login data. As we are installing the hole program system wide with system wide settings it might be possible to login with one user profile on windows, log into spotify, then log out of that windows user profile, log into another user profile on the same computer, then open spotify and it will be still logged in from the other user profile.<br>
If this is true it may also be possible to add a company spotify user account to your install script so you don't have to login to 100 computers spotify as well.<br>
However and I'm kinda hoping the following true, Spotify will just make it's own user profiles in `%appdata%` for each user, and installing it as system just means you will have only one install of spotify for the hole system and not for each user.<br>
**Uninstall from system**
If you use the install to system using the powershell script, an uninstall option will be added to windows add or remove programs menu, however<br>
That option will not function 100%, it will remove itself from the system, remove the shortcuts but will not remove the entrey from add or remove programs.<br>
This is because the default installer is looking for an entry in HKEY_CURRENT_USER *not* HKEY_LOCAL_MACHINE where we have our entry added.<br>
Simple "fix" though, run the uninstaller like normal, once it's done, run the `RemoveSystemEntry.reg` file in this github to remove the entry from add or remove programs.<br>
DO NOT run that reg script first otherwise there will be no way of removing it from the system without running the `C:\Program Files\Spotify\Spotify.exe /uninstall` yourself.<br>
Also unsure if Spotify has a `spotify://` "open with app" link, the same as `steam://` has, if so we are not installing those, and I don't know if running the app for the first time and loggin in will fix that on it's own.
