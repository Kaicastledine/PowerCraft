#Set variables
$foldername = "PowerCraftMSM"
$downloadir = "$env:USERPROFILE\$foldername"
$dlurl = "https://github.com/LogoiLab/PowerCraft-Server-Manager/archive/master.zip"
$dlfile = "$downloadir\PowerCraftGitClone.zip"
$zipname = "PowerCraftGitClone.zip"
$shortcutpath = "$downloadir\PowerCraft\Launcher.bat"
#Function to download file
function Download-Item($url, $targetFile){
    $webclient = New-Object System.Net.WebClient
    $webclient.DownloadFile($url,$targetFile)
}
#Function to resize window
function Resize-Window($width, $height, $bwidth, $bheight){
    $pshost = get-host
    $pswindow = $pshost.ui.rawui
    $newsize = $pswindow.windowsize
    $newsize.height = $height
    $newsize.width = $width
    $pswindow.windowsize = $newsize
    $newbuffer = $pswindow.buffersize
    $newbuffer.height = $bheight
    $newbuffer.width = $bwidth
    $pswindow.buffersize = $newbuffer
}
#Function to rename window
function Rename-Window($windowname) {
    $host.ui.RawUI.WindowTitle = $windowname
}
#Function to decompress zips
function Decompress-Zips($zippath){
    $shell=new-object -com shell.application
    $CurrentLocation=get-location
    $CurrentPath=$CurrentLocation.path
    $Location=$shell.namespace($CurrentPath)
    $ZipFiles = get-childitem "$zippath\*.zip"
    $ZipFiles.count | out-default
    foreach ($ZipFile in $ZipFiles)
    {
            $ZipFile.fullname | out-default
            $ZipFolder = $shell.namespace($ZipFile.fullname)
            $Location.Copyhere($ZipFolder.items())
    }
}
#Resize the window
#Resize-Window -width 80 -height 9 -bwidth 80 -bheight 300
Rename-Window -windowname "Downloading And Installing..."
#Create download folder
New-Item -Path $env:USERPROFILE -name $foldername -ItemType "directory" -Force | Out-Null
cd $downloadir
#Download the file
Download-Item -url $dlurl -targetfile $dlfile
#Unzip the downloaded file
Decompress-Zips -zippath $downloadir
#Remove the downloaded zip file (copy protection and disk space)
Remove-Item "$downloadir\$zipname" -Force
Move-Item -Path "$downloadir\PowerCraft-Server-Manager-master\*" -Destination $downloadir -Force | Out-Null
Remove-Item "$downloadir\PowerCraft-Server-Manager-master" -Force -Recurse
Remove-Item "$downloadir\.gitignore" -Force
Remove-Item "$downloadir\.gitattributes" -Force
cd "$downloadir\Install"
# Create a PowerCraft Shortcut with Windows PowerShell
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\PowerCraft.lnk")
$Shortcut.TargetPath = "powershell"
$Shortcut.Arguments = " -ExecutionPolicy ByPass -File .\$env:USERPROFILE\PowerCraftMSM\PowerCraft\PowerCraft-Manager.ps1"
$Shortcut.IconLocation = "$downloadir\Install\PowerCraft.ico"
$shortcut.WorkingDirectory = "$downloadir\PowerCraft\"
$Shortcut.Save()
Exit-PSSession