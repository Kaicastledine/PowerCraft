$mcver = "1.8.1"
function Menu-Backup{
    Write-Host "Please wait while your server is backed up."
    Write-Host "This may take a minute."
    $date = Get-Date
    $backupname = $date.Month+$date.Day+$date.Year
    Get-ChildItem -Recurse | Write-Zip -IncludeEmptyDirectories -OutputPath ".\Backup$dbackupname.zip"
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
Write-Host "╣ ╚ ╔ ╬ ╗ ╝ ╠ ║ ═ ╦ ╩"
