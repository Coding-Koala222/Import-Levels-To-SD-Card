# What is this?
ImportLevelsToSDCard.ps1 is a small powershell application meant to make transferring downloaded levels from SMM1-Level-Downloader to an SD card easier.

It lets you pick a source directory (default location is `<Location of folder>\smm1-level-downloader-win32-x64\resources\app\SMMDownloader\Data\DownloadCache`) and uses the this path `<DriveLetter>:\wiiu\backups\Super Mario Maker [<title id based on region>]\<memorySlotNumber>\8000000c` on the sd card to find the course folders which will be overwritten.

# How do I use this?
## Prerequisites
### SaveMii
ImportLevelsToSDCard is designed to be used with SaveMii (https://github.com/w3irDv/savemii). SaveMii is an app that allows you to "backup" savedata from a game on your Wii U to an SD card and "restore" savedata from an SD card to your Wii U. You can download SaveMii from your computer or directly to your Wii U through the Homebrew App Store (https://github.com/fortheusers/hb-appstore).

### Powershell
You will also need to have powershell installed in order for the script to run. Powershell is available on Windows, Mac, and Linux.
#### Windows Installation
All windows devices have some version of powershell pre-installed. To update to the latest version (Powershell 7), open powershell and type the following commands. (Commands provided from https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4#install-powershell-using-winget-recommended)

`winget search Microsoft.PowerShell`
Then
`winget install --id Microsoft.PowerShell --source winget`

To open powershell, just run `pwsh` in Command Prompt or search for PowerShell 7 in the search bar.

Congratulations! You now have the latest stable version of powershell.

#### macOS Installation
To begin, you must have Homebrew (https://brew.sh/) installed. Here is the command to install it (All commands taken from https://learn.microsoft.com/en-gb/powershell/scripting/install/installing-powershell-on-macos?view=powershell-7.4#install-using-homebrew).

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

Once you have done that, run this command to install Powershell: `brew install --cask powershell`

To open powershell, just run `pwsh` in your terminal.

Congratulations! You now have the latest stable version of powershell.

#### Linux Installation
To install powershell on Linux using a Snap Package, you must have "snapd" installed. Don't know if you do? Just check here https://snapcraft.io/docs/installing-snapd.

Once you have snapd installed, you can use this command to install powershell: `sudo snap install powershell --classic`

To open powershell, just run `pwsh` in Linux Shell.

Congratulations! You now have the latest stable version of powershell.

## Step 1 - Choose which in-game level slots you will overwrite
The first thing to do when getting new SMM1 levels is to choose which in-game slots you will overwrite. Keep in mind that the numbers of the slots corrolate to the order in which they were created. For Import-Levels-To-SD-Card to run smoothly, you should choose a range of accending numbers of slots. There are two methods to make this easier:

#### Method 1 - Backup your current levels to a seperate SaveMii save slot
This method requires the least amount of work. When you are backing up your savedata in step 2, simply make an extra backup in another SaveMii save slot. Whatever course numbers you choose to overwrite will be overwritten in the first backup and the course numbers will correlate to the order in which the levels were made. If you re-organized your levels, they will stay that way.

The downside to this method is that the levels may be out of order if you reorganized your levels or simply just saved levels in slots that were not in chronological order.

#### Method 2 - Create as many new levels in game as you have levels to import
This method may take some time depending on how many levels you want to import, but results in a customized layout that can include all new levels being next to each other. It also has the benefit that you can switch between new and old levels without having to restore a backup from your SD card.

To use this method, first open the level editor. Next, save whatever is there as a new level on the coursebot and place the level on the coursebot where you want your first imported level to be. It doesn't matter what this level is since it will be overwritten. Save the current level on the level editor as a new level again and place it where you want your second imported level to be. Continue doing this for the amount of levels you will import. Make sure to remember how many of these placeholder levels you have made once you finish.

## Step 2 - Backup savedata using SaveMii
The next step is to "backup" your savedata from the Super Mario Maker game on your Wii U to your SD card. Open SaveMii and navigate to "Wii U Title Management / vWii Title Management" then select "Super Mario Maker". Next select "backup" and choose which profile's savedata on the Wii U you are backing up, as well as the backup slot number. Write down or remember the slot number since you will need that later.


After you have backed up your savedata, remove your SD card and connect it to your computer. If you havn't already, download your desired levels using SMM1-Level-Downloader. By default, they should download to "<Location of folder\>\smm1-level-downloader-win32-x64\resources\app\SMMDownloader\Data\DownloadCache".
