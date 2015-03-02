$mcver = "1.8.1"
function Expand-ZIPFile($file, $destination){
    $shell = new-object -com shell.application
    $zip = $shell.NameSpace($file)
    foreach($item in $zip.items()){
        $shell.Namespace($destination).copyhere($item,24)
    }
}
function Menu-Backup{
    $webclient = New-Object System.Net.WebClient
    $url = "http://www.7-zip.org/a/7za920.zip"
    $dir = "$env:APPDATA\7z.zip"
    $webclient.DownloadFile($url, $dir)
    Expand-ZipFile -file $dir -destination $env:APPDATA | Out-Null
    Write-Host "Please wait while your server is backed up."
    Write-Host "This may take a minute."
    Start-Sleep -S 5
    $fs = get-childitem ".\" -recurse -ErrorAction SilentlyContinue
    $origin = Get-Date -Date "01/01/1970"
    $date = Get-Date
    $backupname = [int](New-TimeSpan -Start $origin -End $date).TotalSeconds
    $dest = "Backup-$backupname"
    $7z = "$env:APPDATA\7za.exe"
    $i = 0
    foreach($file in $fs.FullName){
        $i++
        [Array]$arguments = $null
        $arguments = "a","-tzip","$dest","$file","-mmt","-x!Backups\*"
        & $7z $arguments | Out-Null
        Write-Progress -activity "Backing Up" -status "Adding File: $file" -percentComplete (($i / $fs.length)  * 100)
    }
    if(!(Test-Path ".\Backups")){
        New-Item -Path ".\Backups" -Type Directory
    }
    $mov = $dest.ToString() + ".zip"
    Start-Sleep -S 1
    Move-Item -Path "$mov" -Destination ".\Backups" -Force | Out-Null
    Remove-Item -Path ".\0" -Force | Out-Null
    Remove-Item -Path ".\*.tmp" -Force | Out-Null
    Clear-Host
    $i = 10
    while($i > "0"){
        Clear-Host
        Write-Host "Complete!"
        Write-Host "Returning to main menu in: $i"
        $i--
    }
}
function Menu-Main{
    Write-Host "     ╔══════════════════════════════════════════════╗"
    Write-Host "     ║PowerCraft MSM (Minecraft Server Manager) v1.0║"
    Write-Host "     ╠══════════════════════════════════════════════╣"
    Write-Host "     ║         What would you like to do?           ║"
    Write-Host "     ╚══════════════════════════════════════════════╝"
    Write-Host
    Write-Host "     ╔═╦════════════════════════════════════════════╗"
    Write-Host "     ║1║Create a server backup                      ║"
    Write-Host "     ╠═╬════════════════════════════════════════════╣"
    Write-Host "     ║2║Edit server properties (server.properties)  ║"
    Write-Host "     ╠═╬════════════════════════════════════════════╣"
    Write-Host "     ║3║Add players to the whitelist                ║"
    Write-Host "     ╠═╬════════════════════════════════════════════╣"
    Write-Host "     ║4║Setup custom server launcher                ║"
    Write-Host "     ╠═╬════════════════════════════════════════════╣"
    Write-Host "     ║5║Rebuild server                              ║"
    Write-Host "     ╠═╬════════════════════════════════════════════╣"
    Write-Host "     ║e║EXIT                                        ║"
    Write-Host "     ╠═╩════════════════════════════════════════════╝"
    $choice = Read-Host "[1-5]╚═➤"
    switch($choice){
        1{
            Menu-Backup
        }
        2{
            Menu-Edit
        }
        3{
            Menu-Whitelist
        }
        4{
            Menu-Launcher
        }
        5{
            Menu-Rebuild
        }
        e{
        Exit-PSSession
        }
        default{
            Clear-Host
            Write-Warning "Please enter a valid choice!"
            Menu-Main
        }
    }
}
#Write-Host "╣ ╚ ╔ ╬ ╗ ╝ ╠ ║ ═ ╦ ╩"
