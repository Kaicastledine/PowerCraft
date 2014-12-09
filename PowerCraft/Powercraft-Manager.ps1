function Get-PowerCraftXML($Path){
    [xml]$xml = Get-Content "$Path"
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
function Set-Version($ver){
    if($ver = "1.8.0"){
        $dlurl = "https://s3.amazonaws.com/Minecraft.Download/versions/$ver/minecraft_server.$ver.jar"
    }
    if($ver = "1.7.10"){
        $dlurl = "https://s3.amazonaws.com/Minecraft.Download/versions/$ver/minecraft_server.$ver.jar"
    }
     if($ver = "1.7.9"){
        $dlurl = "https://s3.amazonaws.com/Minecraft.Download/versions/$ver/minecraft_server.$ver.jar"
    }
     if($ver = "1.7.8"){
        $dlurl = "https://s3.amazonaws.com/Minecraft.Download/versions/$ver/minecraft_server.$ver.jar"
    }
     if($ver = "1.7.7"){
        $dlurl = "https://s3.amazonaws.com/Minecraft.Download/versions/$ver/minecraft_server.$ver.jar"
    }
    if($ver = "1.7.6"){
        $dlurl = "https://s3.amazonaws.com/Minecraft.Download/versions/$ver/minecraft_server.$ver.jar"
    }
    if($ver = "1.7.5"){
        $dlurl = "https://s3.amazonaws.com/Minecraft.Download/versions/$ver/minecraft_server.$ver.jar"
    }
      if($ver = "1.7.4"){
        $dlurl = "https://s3.amazonaws.com/Minecraft.Download/versions/$ver/minecraft_server.$ver.jar"
    }
      if($ver = "1.7.3"){
        $dlurl = "https://s3.amazonaws.com/Minecraft.Download/versions/$ver/minecraft_server.$ver.jar"
    }
     if($ver = "1.7.2"){
        $dlurl = "https://s3.amazonaws.com/Minecraft.Download/versions/$ver/minecraft_server.$ver.jar"
    }
    if($ver = "1.7.1"){
        $dlurl = "https://s3.amazonaws.com/Minecraft.Download/versions/$ver/minecraft_server.$ver.jar"
    }
}
function Menu-EditorMain{
    if(Test-Path "$manageFindMenuIn\Minecraft.Properties.xml"){
    }
    else{
        Copy-Item -Path "$env:USERPROFILE\PowerCraftMSM\PowerCraft\Minecraft.Properties.xml" -Destination $manageFindMenuIn
    }
    Get-PowerCraftXML -Path "$manageFindMenuIn\Minecraft.Properties.xml"
    Write-Host 'PowerCraft MSM (Minecraft Server Manager) V1.0'
    Write-Host ''
    Write-Host '₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪'
    $inc = 1
    foreach($property in $properties){
        $temp = "| $inc Modify value for: $property"
        $temp2 = " " * (69 - $temp.Length)
        $temp3 = "$temp" + "$temp2" + "|"
        Write-Host "$temp3"
        $inc++
    }
    Write-Host '₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪'
    $inc--
    $mainEditorMenuIn = Read-Host "[1-$inc]₪>"
    switch($mainEditorMenuIn){
     1 {
        Clear-Host
        Write-Host
     }
     2 {
        Clear-Host
     }
     3 {
        Clear-Host
     }
     4 {
        Clear-Host
     }
     5 {
        Clear-Host
     }
     6 {
        Clear-Host
     }
     7 {
        Clear-Host
     }
     8 {
        Clear-Host
     }
     9 {
        Clear-Host
     }
     10 {
        Clear-Host
     }
     11 {
        Clear-Host
     }
     12 {
        Clear-Host
     }
     13 {
        Clear-Host
     }
     14 {
        Clear-Host
     }
     15 {
        Clear-Host
     }
     16 {
        Clear-Host
     }
     17 {
        Clear-Host
     }
     18 {
        Clear-Host
     }
     19 {
        Clear-Host
     }
     20 {
        Clear-Host
     }
     21 {
        Clear-Host
     }
     22 {
        Clear-Host
     }
     23 {
        Clear-Host
     }
     24 {
        Clear-Host
     }
     25 {
        Clear-Host
     }
     26 {
        Clear-Host
     }
     27 {
        Clear-Host
     }
     28 {
        Clear-Host
     }
     29 {
        Clear-Host
     }
    }
}
function Menu-ManageFind{
    Write-Host 'PowerCraft MSM (Minecraft Server Manager) V1.0'
    Write-Host ''
    Write-Host '₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪'
    Write-Host '|Please input the full path to your Minecraft server folder|'
    Write-Host '₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪'
    $manageFindMenuIn = Read-Host "₪>"
    if(Test-Path -Path "$manageFindMenuIn\server.properties"){
        Write-Host "Path:"
        Write-Host "$manageFindMenuIn"
        Write-Host "Is this correct?"
        $manageFindMenuConfirmIn = Read-Host "[y/n]₪>"
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
function Menu-CreateMain{
    Write-Host "Confirm server creation:"
    $mainCreateMenuIn = Read-Host "[y/n]₪>"
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
    Write-Host '₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪'
    Write-Host '| 1 Manage a prexisting Minecraft server  |'
    Write-Host '| 2 Create a new managed server           |'
    Write-Host '₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪₪'
    $mainMenuIn = Read-Host "[1-2]₪>"
    switch($mainMenuIn){
        1 {
            Clear-Host
            Menu-ManageFind
        }
        2 {
            Clear-Host
            Menu-CreateMain
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
$console = $host.UI.RawUI
$console.ForegroundColor = "green"
$console.BackgroundColor = "brown"
Menu-Main