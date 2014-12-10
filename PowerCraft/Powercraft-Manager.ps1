function Get-PowerCraftXML($XMLPath){
    [xml]$xml = Get-Content "$XMLPath"
    $properties = $xml.document.ChildNodes.LocalName
    $children = $xml.document.ChildNodes
    $inc = "0"
    foreach($property in $properties){
        $temp = $children[$inc]
        New-Variable -Name "default_$property" -Force -Option Constant -Value $temp.Default
        $inc = $inc + "1"
    }
    foreach($property in $properties){
        $temp = $children[$inc]
        New-Variable -Name "current_$property" -Force -Option Constant -Value $temp.Current
        $inc = $inc + "1"
    }
}
function Menu-EditorMain{
    if(Test-Path "$ServerFolder\Minecraft.Properties.xml"){
    }
    else{
        Copy-Item -Path "$env:USERPROFILE\PowerCraftMSM\PowerCraft\Minecraft.Properties.xml" -Destination $manageFindMenuIn
    }
    Get-PowerCraftXML -XMLPath "$ServerFolder\Minecraft.Properties.xml"
    Write-Host 'PowerCraft MSM (Minecraft Server Manager) V1.0'
    Write-Host ''
    Write-Host '-----------------------------------------------------------------------------'
    $inc = 1
    foreach($property in $properties){
        $temp = "| $inc Modify value for: $property"
        $temp2 = " " * (69 - $temp.Length)
        $temp3 = "$temp" + "$temp2" + "|"
        Write-Host "$temp3"
        $inc++
    }
    Write-Host "| $inc Exit                                                                    |"
    Write-Host '-----------------------------------------------------------------------------'
    $mainEditorMenuIn = Read-Host "[1-$inc]->"
}
function Menu-ManageFind{
    Write-Host 'PowerCraft MSM (Minecraft Server Manager) V1.0'
    Write-Host ''
    Write-Host '---------------------------------------------------------------------'
    Write-Host '|Please input the full path to your Minecraft server folder         |'
    Write-Host '---------------------------------------------------------------------'
    [path]$manageFindMenuIn = Read-Host "->"
    $ServerFolder = $manageFindMenuIn
    if(Test-Path -Path "$manageFindMenuIn\server.properties"){
        Write-Host "Path:"
        Write-Host "$manageFindMenuIn"
        Write-Host "Is this correct?"
        $manageFindMenuConfirmIn = Read-Host "[y/n]->"
        $temp = $manageFindMenuConfirmIn.ToLower()
        switch($temp){
            y {
                Clear-Host
                Menu-EditorMain
            }
            n {
                Clear-Host
                Menu-ManageFind
            }
            default {
                Clear-Host
                Menu-EditorMain
            }
        }
    }
    else{
        Clear-Host
        Write-Warning 'Please enter a valid path that contains a "server.properties" file!'
        Menu-ManageFind
    }
}
function Download-File($sourceFile, $targetDirectory) {
    $wc = New-Object System.Net.WebClient
    $sourceFileName = $sourceFile.SubString($sourceFile.LastIndexOf('/')+1)
    $targetFileName = $targetDirectory + $sourceFileName
    $wc.DownloadFile($sourceFile, $targetFileName)
    Write-Host "Downloaded $sourceFile to file location $targetFileName"
}
function Create-Server($ServerPath){
    Download-File -sourceFile $dlurl -targetDirectory $ServerPath

}
function Menu-CreateMain{
    Write-Host "Confirm server creation:"
    $mainCreateMenuIn = Read-Host "[y/n]->"
    $temp = $mainCreateMenuIn.ToLower()
    switch($temp){
            y {
                Clear-Host
                Create-Server
            }
            n {
                Clear-Host
                Menu-Main
            }
            default {
                Clear-Host
                Create-Server
            }
    }
}
function Menu-Main{
    Write-Host 'PowerCraft MSM (Minecraft Server Manager) V1.0'
    Write-Host ''
    Write-Host '-------------------------------------------------'
    Write-Host '| 1 Manage a prexisting Minecraft server        |'
    Write-Host '| 2 Create a new managed server                 |'
    Write-Host '| 3 Exit                                        |'
    Write-Host '-------------------------------------------------'
    $mainMenuIn = Read-Host "[1-2]->"
    switch($mainMenuIn){
        1 {
            Clear-Host
            Menu-ManageFind
        }
        2 {
            Clear-Host
            Menu-CreateMain
        }
        3{
            Exit-PSSession
        }
        default{
            Clear-Host
            Menu-ManageFind
        }
        else{
            Clear-Host
            Write-Warning "Please enter a valid menu item choice!"
            Menu-Main
        }
    }
}
$ver = 1.8.1
$dlurl = "https://s3.amazonaws.com/Minecraft.Download/versions/$ver/minecraft_server.$ver.jar"
$console = $host.UI.RawUI
$console.ForegroundColor = "Green"
$console.BackgroundColor = "DarkRed"
Menu-Main