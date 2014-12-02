#Set variables
$dlurl = 
#Function to download file
function Download-File($url, $File){
   $uri = New-Object "System.Uri" "$url"
   $request = [System.Net.HttpWebRequest]::Create($uri)
   $request.set_Timeout(15000) #15 second timeout
   $response = $request.GetResponse()
   $totalLength = [System.Math]::Floor($response.get_ContentLength()/1024)
   $responseStream = $response.GetResponseStream()
   $targetStream = New-Object -TypeName System.IO.FileStream -ArgumentList $targetFile, Create
   $buffer = new-object byte[] 10KB
   $count = $responseStream.Read($buffer,0,$buffer.length)
   $downloadedBytes = $count
   while ($count -gt 0)
   {
       $targetStream.Write($buffer, 0, $count)
       $count = $responseStream.Read($buffer,0,$buffer.length)
       $downloadedBytes = $downloadedBytes + $count
       Write-Progress -activity "Downloading activated file '$($url.split('/') | Select -Last 1)'" -status "Downloaded Completion: ($([System.Math]::Floor($downloadedBytes/1024))K of $($totalLength)K): " -PercentComplete ((([System.Math]::Floor($downloadedBytes/1024)) / $totalLength)  * 100)
   }
   Write-Progress -activity "Finished downloading file '$($url.split('/') | Select -Last 1)'"
   $targetStream.Flush()
   $targetStream.Close()
   $targetStream.Dispose()
   $responseStream.Dispose()
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
function Decompress-Zip{
    $shell=new-object -com shell.application
    $CurrentLocation=get-location
    $CurrentPath=$CurrentLocation.path
    $Location=$shell.namespace($CurrentPath)
    $ZipFiles = get-childitem *.zip
    $ZipFiles.count | out-default
    foreach ($ZipFile in $ZipFiles)
    {
            $ZipFile.fullname | out-default
            $ZipFolder = $shell.namespace($ZipFile.fullname)
            $Location.Copyhere($ZipFolder.items())
    }
}
#Resize the window
Resize-Window -width 80 -height 9 -bwidth 80 -bheight 300
Rename-Window -windowname "Downloading Install..."
#Create download folder
New-Item -Path . -name "$downloadir" -ItemType "directory" -Force | Out-Null
#Download the file
Download-File -url $dlurl -File $dlfile
cd $downloadir
#Unzip the downloaded file
#Remove the downloaded zip file (copy protection and disk space)
Remove-Item $file -Force
Clear-Host
#Start the setup of the program
Write-Warning "IF THIS WINDOW IS CLOSED, INSTALLATION WILL FAIL, LEAVE THIS WINDOW OPEN UNTIL ALL OTHER INSTALL WINDOWS ARE CLOSED"
Start-Process .\Setup.exe -Wait
Clear-Host
cd ..\
Clear-Host
#Remove the setup files after install (copy protection)
Remove-Item "$downloadir" -Recurse -Force
Remove-Item "Downer.ps1" -Force
Exit-PSSession