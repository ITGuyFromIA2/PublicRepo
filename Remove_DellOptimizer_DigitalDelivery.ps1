#Handling various AppX and AppXProvisioned items here
    $List_AppXToRemove = @("*DellDigital*","*DellOptimizer*");

    #Get list of all provisioned apps
        $AllAppX_Provisioned = Get-AppxProvisionedPackage -Online;
        $Matched_Provisioned = @();
#Loop through all provisioned, matching the 'List_AppXToRemove'
    foreach ($Provisioned in $AllAppX_Provisioned) {
        if (($List_AppXToRemove | %{$Provisioned.PackageName -like $_}) -contains $true) {
            $Matched_Provisioned += $Provisioned;
            Remove-AppxProvisionedPackage -Online -PackageName $Provisioned.PackageName -AllUsers -ErrorAction SilentlyContinue;
        }
    }

$appX_Remove = @()
$Matched_Installed = @()

$AllAppX_Installed = Get-AppxPackage -AllUsers

foreach ($Installed in $AllAppX_Installed) {
    if (($List_AppXToRemove | %{$installed.PackageFullName -like $_}) -contains $true) {
        $Matched_Installed += $Installed;
        Remove-AppxPackage -Package $Installed -AllUsers -ErrorAction SilentlyContinue;
    }
}


$Timestamp = Get-Date -Format "yyyy-MM-dd_THHmmss";
$LogFile = "$envTEMP\DellUninst_$Timestamp.log";
$ProgramList = @( "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" );
$Programs = Get-ItemProperty $ProgramList -EA 0;

#List of applications to remove, as seen in Add/Remove Programs (use wildcards)
    #$UninstallAppList = @("Dell Optimizer*","*Dell Digital Delivery*")
    $UninstallAppList = @("Dell*Optimizer*","*Dell Digital Delivery*","*Express*Connect*");

#List of possible running procecsses associated with the above
    $RunningProcessList = @("DellOptimizer.exe","Dell.D3.UWP.exe");

$App = @();        #Will have 'MSI' apps in it
 $App_Whole = @();
$ManualApp = @();  #Will have 'other' types in it (Installshield)

#$Program = ($Programs | where-Object -Property Displayname -Like "*Dell*")[0]
foreach ($Program in $Programs) {
    if ((($UninstallAppList | %{($Program.DisplayName -like $_)}) -contains $true)) {
        if (($Program.UninstallString -like "*msiexec*")) {
        $App_Whole += $Program;
            $App += $Program.PSChildName;
        } else {
            $ManualApp += $Program;
        }
    }
}

Get-Process | Where-Object { $_.ProcessName -in $RunningProcessList } | Stop-Process -Force;

cmd /c  "$(($ManualApp).uninstallString) /silent";

foreach ($a in $App) {
$Params = @("/qn","/norestart","/X","$a","/L*V ""$LogFile""") ;
Start-Process "msiexec.exe" -ArgumentList $Params -Wait -NoNewWindow;
}

