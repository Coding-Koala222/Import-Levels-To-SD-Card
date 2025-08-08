
function Find-Folders {
    [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $browse = New-Object System.Windows.Forms.FolderBrowserDialog
    $browse.SelectedPath = "C:\"
    $browse.ShowNewFolderButton = $false
    $browse.Description = "Select the directory where your levels are being downloaded."

    $loop = $true
    while($loop)
    {
        if ($browse.ShowDialog() -eq "OK")
        {
        $loop = $false
		
		return $browse.SelectedPath
		
        } else
        {
            $res = [System.Windows.Forms.MessageBox]::Show("You clicked Cancel. Would you like to try again or exit?", "Select a location", [System.Windows.Forms.MessageBoxButtons]::RetryCancel)
            if($res -eq "Cancel")
            {
                #Ends script
                Exit
                return
            }
        }
    }
    $browse.SelectedPath
    $browse.Dispose()
}

$memoryExists = Get-Variable -Name sourceDirectory -ErrorAction Ignore

if ($null -eq $memoryExists) {
    Write-Output "Please select the directory where your levels are being downloaded."
    $sourceDirectory = Find-Folders{}
    Write-Output "You have selected: $sourceDirectory"
    $DestinationDriveLetter = Read-Host "Please type the drive letter on this computer of your sd card. Please use an uppercase letter. [example response: D]"
    $region = Read-Host "Please type the code of the region of the game you are using. [USA, JPN, EUR]"
    if ($region -eq "USA") {
        $titleKey = "00050000-1018dc00"
    }
    if ($region -eq "JPN") {
        $titleKey = "00050000-1018db00"
    }
    if ($region -eq "EUR") {
        $titleKey = "00050000-1018dd00"
    }
    

    $remember = Read-Host "Would you like to remember your level source folder, SD card drive letter, and game region so you don't have to select them again? [y/n]"
    
    if ($remember -eq "Y" -or $remember -eq "y") {
        $file = Get-Content -Path $MyInvocation.MyCommand.Path
        
        $newFile = '$sourceDirectory = "' + $sourceDirectory + '"' + "`n" + 'Write-Output "Current source directory is ' + $sourceDirectory + '"' + "`n" + '$DestinationDriveLetter = "' + $DestinationDriveLetter + '"' + "`n" + '$titleKey = "' + $titleKey + '"'
        foreach($line in $file) {
            $newFile = $newFile + "`n$line"
        }
        Set-Content -Path $MyInvocation.MyCommand.Path -Value $newFile
    }

} else {
    
}


$memorySlotNumber = Read-Host "Please type the SaveMii memory slot number you would like to use"

$sourceLevelFolders = Get-ChildItem -Path $sourceDirectory -Exclude "PreviouslyMovedToSDCard"
$placementNumberCounter = Read-Host "Enter the first slot to be replaced.`nIn total,"$sourceLevelFolders.Length"slots will be replaced starting with your entry then accending in slot numbers"
$placementNumberCounter = [int]$placementNumberCounter

foreach ($folder in $sourceLevelFolders) {
    Write-Output "Folder opened: $Folder.Name"

    $placementNumber = '{0:D3}' -f $placementNumberCounter

    $Destination = $DestinationDriveLetter + ":\wiiu\backups\Super Mario Maker [$titleKey]\$memorySlotNumber\8000000c\course$placementNumber"


    $PreviousContentInDestination = Get-ChildItem -LiteralPath $Destination

    Write-Output $PreviousContentInDestination.Length

    foreach ($item in $PreviousContentInDestination) {
        Write-Output "Previous content:"$item.Name
        Remove-Item -LiteralPath $item
    }

    $sourceLevelFiles = Get-ChildItem -Path $folder
    
    foreach ($item in $sourceLevelFiles) {
        Copy-Item -Path $item -Destination $Destination
    }   

    Copy-Item -Path $folder -Destination "$sourceDirectory\PreviouslyMovedToSDCard" -Recurse
    Remove-Item -LiteralPath $folder -Recurse


    $placementNumberCounter++

}