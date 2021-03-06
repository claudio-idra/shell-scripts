REM Following .cmd Windows command script has been tested and works in Windows 8.1 Pro 64-bit:

REM Please run following commands in Windows command line (using cmd, NOT Powershell) as administrator:

mkdir C:\temp

cd c:\temp

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install binroot"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install PowerShell"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install pscx"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install chocolatey"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install ChocolateyGUI"

REM Get web browsers

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install Firefox"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install google-chrome-x64"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install Opera"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install qupzilla"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install flashplayerplugin"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install grepwin"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install geforce-game-ready-driver"

REM Get Internet download utilities:
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install Wget"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install git"
 
REM ############################################################################################### 
REM Close .cmd command line window and open a new .cmd window to run the next commands.
REM Run following commands in Windows command line (using cmd, NOT Powershell) as administrator:
REM ############################################################################################### 

REM If you are using the 32-bit version of Windows, use 

REM curl-7.38.0-win32-local.msi instead of
 
REM curl-7.38.0-win64-local.msi

set CURLFILENAME=curl-7.38.0-win64-local.msi

mkdir C:\temp

cd c:\temp

wget http://www.confusedbycode.com/curl/%CURLFILENAME%

msiexec /I  %CURLFILENAME% /quiet /passive

REM Get R and RStudio
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install R.Project"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install R.Studio"

REM show list of locally installed packages - installed using choco package manager for Windows:

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco list -lo"
 
REM jre8 installer hangs; so line below has been disabled
REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install jre8"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install 7zip.install"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install flashplayeractivex"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install FoxitReader"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install 7zip"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install vlc"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install 7zip.commandline"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install filezilla"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install dropbox"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install skype"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install DotNet4.5"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install paint.net"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install virtualbox"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install VBoxGuestAdditions.install"

REM install Android emulator, which depends on Virtualbox:

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install andy"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install libreoffice"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install pdf24"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install windirstat"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install qbittorrent"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install daemontoolslite"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install steam"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install teamviewer"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install HitmanProPortable_x64"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install ccleaner"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install yumi"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install unetbootin"

REM Get device driver management utilities:

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install DellCommandUpdate"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install drivergenius"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install googleearth"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install bleachbit"


echo off

echo "Update all currently installed choco packages:"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install ChocolateyPackageUpdater"

cup -y all

echo "Show list of locally installed packages - installed using choco package manager for Windows:"

choco list -lo

echo "After running this script, please start RStudio. In the RStudio interface, please click on"

echo "'Help', then click on 'Check for Updates' and then click on 'Quit and Download' to get the newest version of RStudio"

echo on

pause
