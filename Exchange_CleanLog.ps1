Set-Executionpolicy RemoteSigned

$days=7 #You can change the number of days here
$IISLogPath="C:\inetpub\logs\LogFiles\"
$ExchangeLoggingPath="C:\Program Files\Microsoft\Exchange Server\V15\Logging\"

Write-Host "Removing IIS and Exchange logs; keeping last" $days "days"

Function CleanLogfiles($TargetFolder)
{
    if (Test-Path $TargetFolder) {
        $Now = Get-Date
        $LastWrite = $Now.AddDays(-$days)
        $Files = Get-ChildItem $TargetFolder -Include *.log,*.blg -Recurse | Where {$_.LastWriteTime -le "$LastWrite"}
        foreach ($File in $Files)
            {Write-Host "Deleting file $File" -ForegroundColor "Red"; Remove-Item $File -ErrorAction SilentlyContinue | out-null}
       }
Else {
    Write-Host "The folder $TargetFolder doesn't exist! Check the folder path!" -ForegroundColor "red"
    }
}
CleanLogfiles($IISLogPath)
CleanLogfiles($ExchangeLoggingPath)
