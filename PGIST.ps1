#Created by Terra Envy
 #region Dependancies
set-executionpolicy unrestricted -Force
$ErrorActionPreference= 'silentlycontinue'
#endregion Dependancies
#region Variables

[int]$count = 1
$global:ToolDeath = 0
$global:PIDN = 0
$global:PIDP = 0
$xcStatus = Get-Content "C:\ProgramData\CAM Commerce Solutions\X-Charge\XCharge.ini" | Where-Object { $_.Contains("USELOCALMODEM=") }
If ($xcStatus -eq "USELOCALMODEM=0") {$xcStatusText = "Client"} Else {$xcStatusText = "Server"} 

$ppStatus = Select-String -Path "C:\ProgramData\XpressLink2\SharedUserSettings.xml" -Pattern "<deviceSerialNumber>"
$ppStatusText = $ppStatus -replace ".*<deviceSerialNumber>" -replace "</deviceSerialNumber>"



$SCRIPTPATH = Split-Path $SCRIPT:MyInvocation.MyCommand.Path -parent
$IPAddress = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.Ipaddress.length -gt 1} 
$xcVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\ProgramData\CAM Commerce Solutions\X-Charge\Application\XCharge.exe").FileVersion
$rcmVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\ProgramData\xpresslink2\RCM.exe").FileVersion
$EvosusVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\Program Files (x86)\Evosus\Evosus Retail\EvosusRetail.exe").FileVersion
$serviceceoVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\Program Files (x86)\Insight Direct\ServiceCEO\ServiceCEO.exe").FileVersion
$ESVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\EagleSoft\Shared Files\Eaglesoft.exe").FileVersion
$ERVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\rey\Bin\ERAccess.exe").FileVersion
$CHIROVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\Program Files (x86)\PSChiro\ChiroTouch\ChiroTouch.exe").FileVersion
$UASVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\VUAS\vuas.exe").FileVersion
$CPMVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\Program Files (x86)\CrystalPM\Crystal.exe").FileVersion
$ROWVERSION = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\Program Files (x86)\R.O. Writer\rowriter.exe").FileVersion
$RGPVERSION = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\Program Files (x86)\Rock Gym Pro\POS.exe").FileVersion
$OPDVERSION = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\Program Files (x86)\Open Dental\OpenDental.exe").FileVersion
#$csVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\CStone\cstone.exe").FileVersion

#endregion Variables
#region Design
$Host.UI.RawUI.BackgroundColor = "Black"
$HOST.UI.RawUI.ForegroundColor = "green"
$pshost = Get-Host
$psWindow = $pshost.UI.RawUI
[System.Console]::Clear();
#endregion Design
#region Functions 
function Show-Menu {
     param (
           [string]$Title = 'OpenEdge Support Tool V2.0.6'
     )
     cls
     Write-Host "============ $Title ============"
          Write-Host "================ System Information ================"

        Write-Host "Computername:"$env:computername
Write-Host "Network IP:" $IPAddress.ipaddress[0]  
if (Test-Path "C:\ProgramData\CAM Commerce Solutions\X-Charge\Application\XCharge.exe") {Write-Host "XC Version" $xcVersion $xcStatusText} 
if (Test-Path "C:\ProgramData\XpressLink2\SharedUserSettings.xml") {Write-Host "PinPad S/N" $ppStatusText "Beta Function"}
if (Test-Path "C:\ProgramData\xpresslink2\RCM.exe") {Write-Host "RCM Version" $rcmVersion}
if (Test-Path "C:\Program Files (x86)\Evosus\Evosus Retail\EvosusRetail.exe") {Write-Host "POS-Evosus Version" $EvosusVersion}
if (Test-Path "C:\Program Files (x86)\Insight Direct\ServiceCEO\ServiceCEO.exe") {Write-Host "POS-ServiceCEO Version" $serviceceoVersion}
if (Test-Path "C:\EagleSoft\Shared Files\Eaglesoft.exe") {Write-Host "POS-EagleSoft Version" $ESVersion}
if (Test-Path "C:\rey\Bin\ERAccess.exe") {Write-Host "POS-ERACCESS Version" $ERVersion}
if (Test-Path "C:\Program Files (x86)\PSChiro\ChiroTouch\ChiroTouch.exe") {Write-Host "POS-ChiroTouch Version" $CHIROVersion}
if (Test-Path "C:\VUAS\vuas.exe") {Write-Host "POS-Universal Accounting Software Version" $UASVersion}
if (Test-Path "C:\Program Files (x86)\CrystalPM\Crystal.exe") {Write-Host "CrystalPM Version" $CPMVersion}
if (Test-Path "C:\CStone\cstone.exe") {Write-Host "CornerStone: No Version Information"}
if (Test-Path "C:\Program Files (x86)\R.O. Writer\rowriter.exe") {Write-Host "R.O Writer Version" $ROWVERSION}
if (Test-Path "C:\Program Files (x86)\Rock Gym Pro\POS.exe") {Write-Host "Rock Gym Pro Version" $RGPVERSION}
if (Test-Path "C:\Program Files (x86)\Open Dental\OpenDental.exe") {Write-Host "Open Dental Version" $OPDVERSION}
       Write-Host "================= Trouble Shooting ================="
}

function password-menu  {
cls
$input = read-host  <# -AsSecureString #> "Please Enter The Password"
if ($input -eq '1121'){
Main-Menu
}else{
password-menu
}
}





function Main-Menu {
do
{



If ($global:ToolDeath -eq "1") {return} Else {}
cls
Show-Menu 
     Write-Host "1: X-Charge"
     Write-Host "2: RCM"
     Write-Host "3: Pinpad"
     Write-Host "4: Other"
<#   Write-Host "5: Callpop (Currently Unimplemented)"#>
     Write-Host "Q: Press 'Q' to quit."
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
                cls
                XC-Menu
           } '2' {
                cls
                RCM-Menu
           } '3' {
                cls
                Pinpad-Menu
           } '4' {
                cls
                Other-Menu
           } 'z' {
             $global:ToolDeath = 1
           } 'q' {
                return
           }
     }
}
until ($input -eq 'q')
}
function XC-Menu {
do
{
If ($global:ToolDeath -eq "1") {return} Else {}
     Show-Menu
     Write-Host "1: Download X-Charge"
     Write-Host "2: Restart XC Server"
     Write-Host "3: Add Firewall and File Permissions"
     Write-Host "4: Open Xcharge.ini" 
     Write-Host "5: 826 Invalid Private Key Error"
     Write-Host "6: HRCHECK ERROR (Slated for Removal)"
     Write-Host "7: Post Uninstall Cleanup (Experimental)"
     Write-Host "8: Check Security Service Port"
     Write-Host "9: Generate Backup to C:"
     Write-Host "Q: Press 'Q' to return to main menu."
     Write-Host "Z: Press 'Z' to exit."
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
                cls
                XC-Menu-Downloads
           } '2' {
                cls
                XC-Menu-Restart
           } '3' {
                cls
                XC-Menu-Firewall
                    } '4' {
                cls
                Start-Process -FilePath "C:\ProgramData\CAM Commerce Solutions\X-Charge\XCharge.ini"
                <#debugpause#>
                    } '5' {
                cls
                Remove-Item -Path "HKEY_CURRENT_USER\Software\X-Charge\XWebE2EPublicKeys" -Recurse
                <#debugpause#>
                    } '6' {
                cls
                'You chose option 6'
                <#debugpause#>
                    } '7' {
                cls
              
                                     $app = Get-WmiObject -Class Win32_Product `
                     -Filter "Name = 'Xcharge'"
                     write-host "$app"
                     $app.Uninstall()
#{9EA88A95-FF2C-41A6-833C-4C29146B37C5}

                                     $app = Get-WmiObject -Class Win32_Product `
                     -Filter "Name = 'Xpresslink2'"
                     write-host "$app"
                     $app.Uninstall()





                                     $app = Get-WmiObject -Class Win32_Product `
                     -Filter "Name = 'XCharge Components'"
                     write-host "$app"
                     $app.Uninstall()





              pause 
                   Show-Menu
     Write-Host "DO NOT USE UNLESS YOU HAVE USED THE UNINSTALLER FIRST"
     Write-Host "Do you wish to continue"
     Write-Host "Y: Yes"
     Write-Host "N: No"
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
                cls
                Write-Host "Stopping XChrgSrv"
                Stop-Process -Name "XChrgSrv" -Force
Write-Host "Stopping X-Charge"
                Stop-Process -Name "XCharge" -Force
Write-Host "Stopping XCService"
                stop-service XCService
Write-Host "Stopping XCSecurity"
                stop-service XCSecurity
Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" -Name "CAMMonitor"
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32" -Name "CAMMonitor"


Write-Host "Removing HKEY_CURRENT_USER\SOFTWARE\AcceleratedPayments"
Remove-Item -Path "HKEY_CURRENT_USER\SOFTWARE\AcceleratedPayments" -Recurse
Write-Host "Removing HKEY_CURRENT_USER\SOFTWARE\PIN Pad Device"
Remove-Item -Path "HKEY_CURRENT_USER\SOFTWARE\PIN Pad Device" -Recurse
Write-Host "Removing HKEY_CURRENT_USER\SOFTWARE\XCharge"
Remove-Item -Path "HKEY_CURRENT_USER\SOFTWARE\XCharge" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Accelerated Payments"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Accelerated Payments" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\INGENICO"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\INGENICO" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\OpenEdge"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\OpenEdge" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\XCharge"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\XCharge" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\OpenEdgeUpdater"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\OpenEdgeUpdater" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XCSecurity"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XCSecurity" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XCService"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XCService" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Services\XCSecurity"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Services\XCSecurity" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Services\XCService"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Services\XCService" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\services\OpenEdgeUpdater"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\services\OpenEdgeUpdater" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\XCSecurity "
Remove-Item -Path "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\XCSecurity" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\XCService"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\XCService" -Recurse
Write-Host "Removing HKEY_CURRENT_USER\SOFTWARE\OpenEdge"
Remove-Item -Path "HKEY_CURRENT_USER\SOFTWARE\OpenEdge" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\OpenEdge"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\OpenEdge" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\services\OpenEdgeUpdater"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\services\OpenEdgeUpdater" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.EncryptionUtilities"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.EncryptionUtilities" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.CardData"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.CardData" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.UsedImplicitlyAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.UsedImplicitlyAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.RazorSectionAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.RazorSectionAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.PureAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.PureAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.PublicAPIAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.PublicAPIAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.PathReferenceAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.PathReferenceAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.NotNullAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.NotNullAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.NotifyPropertyChangedInvocatorAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.NotifyPropertyChangedInvocatorAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.MeansImplicitUseAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.MeansImplicitUseAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.LocalizationRequiredAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.LocalizationRequiredAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.InvokerParameterNameAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.InvokerParameterNameAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.InstantHandleAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.InstantHandleAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.HtmlElementAttributesAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.HtmlElementAttributesAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.CannotApplyEqualityOperatorAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.CannotApplyEqualityOperatorAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.CanBeNullAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.CanBeNullAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcViewAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcViewAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcTemplateAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcTemplateAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcSupressViewErrorAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcSupressViewErrorAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcPartialViewAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcPartialViewAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcModelTypeAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcModelTypeAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcMasterAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcMasterAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcEditorTemplateAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcEditorTemplateAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcDisplayTemplateAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcDisplayTemplateAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcControllerAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcControllerAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcAreaAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcAreaAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcActionSelectorAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcActionSelectorAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcActionAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcActionAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XCService"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XCService" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcActionAttribute"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\XCharge.Common.Annotations.AspMvcActionAttribute" -Recurse
Write-Host "Removing HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\X-Charge"
Remove-Item -Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\X-Charge" -Recurse
Write-Host "Removing C:\Program Files\X-Charge"
Remove-Item -Path "C:\Program Files\X-Charge" -Force -Recurse
Write-Host "Removing C:\ProgramData\CAM Commerce Solutions\X-Charge"
Remove-Item -Path "C:\ProgramData\CAM Commerce Solutions\X-Charge" -Force -Recurse
Write-Host "Removing C:\ProgramData\Xpresslink2"
Remove-Item -Path "C:\ProgramData\Xpresslink2" -Force -Recurse
Write-Host "Removing C:\Program Files (x86)\X-Charge"
Remove-Item -Path "C:\Program Files (x86)\X-Charge" -Force -Recurse
Write-Host "Removing C:\ProgramData\CAM Commerce Solutions\X-Charge"
Remove-Item -Path "C:\ProgramData\CAM Commerce Solutions\X-Charge" -Force -Recurse
Write-Host "Removing C:\ProgramData\Xpresslink2"
Remove-Item -Path "C:\ProgramData\Xpresslink2" -Force -Recurse
Write-Host "Removing C:\Documents and Settings\All Users\Application Data\CAM Commerce Solutions\X-Charge"
Remove-Item -Path "C:\Documents and Settings\All Users\Application Data\CAM Commerce Solutions\X-Charge" -Force -Recurse
Write-Host "Removing C:\Users\terra.kempster\AppData\Roaming\CAM Commerce Solutions\X-Charge"
Remove-Item -Path "C:\Users\$env:USERNAME\AppData\Roaming\CAM Commerce Solutions\X-Charge" -Force -Recurse
Write-Host "Removing C:\ProgramData\Microsoft\Windows\Start Menu\Programs\XCharge"
Remove-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\XCharge" -Force -Recurse
Write-Host "Removing C:\Users\Public\Desktop\XCharge.lnk"
Remove-Item -Path "C:\Users\Public\Desktop\XCharge.lnk" -Force
Write-Host "Removing C:\Windows\System32\msvcr110.dll"
Remove-Item -Path "C:\Windows\System32\msvcr110.dll" -Force
Write-Host "Removing C:\Windows\System32\msvcr120.dll"
Remove-Item -Path "C:\Windows\System32\msvcr120.dll" -Force
Write-Host "Removing C:\Windows\System32\CheckReader.dll"
Remove-Item -Path "C:\Windows\System32\CheckReader.dll" -Force
Write-Host "Removing C:\Windows\System32\PINPadDevice.dll"
Remove-Item -Path "C:\Windows\System32\PINPadDevice.dll" -Force
Write-Host "Removing C:\Windows\System32\PinPadDevice2.dll"
Remove-Item -Path "C:\Windows\System32\PinPadDevice2.dll" -Force
Write-Host "Removing C:\Windows\System32\PinPadDevice2.tlb"
Remove-Item -Path "C:\Windows\System32\PinPadDevice2.tlb" -Force
Write-Host "Removing C:\Windows\System32\XCClient.dll"
Remove-Item -Path "C:\Windows\System32\XCClient.dll" -Force
Write-Host "Removing C:\Windows\System32\XCharge.Common.dll"
Remove-Item -Path "C:\Windows\System32\XCharge.Common.dll" -Force
Write-Host "Removing C:\Windows\System32\XCharge.Common.tlb"
Remove-Item -Path "C:\Windows\System32\XCharge.Common.tlb" -Force
Write-Host "Removing C:\Windows\System32\XpressLink2.dll"
Remove-Item -Path "C:\Windows\System32\XpressLink2.dll" -Force

Write-Host "Removing XCService"
SC delete XCService 
Write-Host "Removing XCSecurity"
SC delete XCSecurity
<#debugpause#>
           } '2' {
           <#debugpause#>





}
}







                    } '8' {
                cls
               $xcsprt =  Get-Process -Id (Get-NetTCPConnection -LocalPort 49201).OwningProcess
               $xcsprtout = $xcsprt -replace  "System.Diagnostics.Process \(" -replace "" -replace "\)" -replace ""
               Write-Host "Port 49201 is being used by $xcsprtout" 

               Write-Host "Do you want to terminate this process?"
               Write-Host "Closing a system process could cause instability."
               Write-Host "================================================"
               Write-Host "Y: Yes"
               Write-Host "N: No"



                    $input = Read-Host "Please make a selection"
     switch ($input)
     {
            'Y' {
                cls
                Stop-Process -Name "$xcsprtout" -Force
                <#debugpause#>
           } 'N' {
                cls
                Write-Host "Process has not been stopped"
                <#debugpause#>

           } 'q' {
                return
           }
     }
     
     }'9'{
     New-Item -ItemType directory -Path C:\XCBackup
      $SourceDir ="C:\ProgramData\CAM Commerce Solutions\X-Charge"
 $DestinationDir = "C:\XCBackup\"
 $BINRange = "BINRange.xdb"
 $CAMCommerce = "CAMCommerce.ini"
 $Clerk = "Clerk.dat"
 $Concord = "Concord.ini"
 $DMCom = "DMCom.ini"
 $FleetProductAlias = "FleetProductAlias.xdb"
 $gpnhda = "gpnhda.ini"
 $Offline = "Offline.xdb"
 $security = "security.xc"
 $security2 = "security.xc2"
 $sigimages = "sigimages.xdb"
 $tran = "tran.xdb"
 $TranCentral = "TranCentral.ini"
 $xcharge = "xcharge.ini"
 $xchrgsrv = "xchrgsrv.ini"
 $XWeb = "XWeb.ini"
 $ZIPCode = "ZIPCode.dat"
 Get-Childitem –Path "$SourceDir"  -Include "$BINRange" , "$CAMCommerce" , "$Clerk" , "$Concord" , "$DMCom" , "$FleetProductAlias" , "$gpnhda" , "$Offline" , "$security" , "$security2" , "$sigimages" , "$tran" , "$TranCentral" , "$xcharge" , "$xchrgsrv" , "$XWeb" , "$ZIPCode" -File -Recurse | Copy-Item  -Destination "$DestinationDir"
 $source = "C:\XCBackup"

$destination = "C:\XCBackup.zip"

 If(Test-path $destination) {Remove-item $destination}

Add-Type -assembly "system.io.compression.filesystem"

[io.compression.zipfile]::CreateFromDirectory($Source, $destination) 

  Remove-Item "C:\XCBackup" -recurse
  <#debugpause#>
             } 'z' {
             $global:ToolDeath = 1
           } 'q' {
                return
           }
     }

}
until ($input -eq 'q')
}        
        function XC-Menu-Downloads{
do
{
If ($global:ToolDeath -eq "1") {return} Else {}
     Show-Menu

     Write-Host "1: Download X-Charge GA"
     Write-Host "2: Download X-Charge GA OI"
     Write-Host "3: Download X-Charge 8.2.4"
     Write-Host "4: Download X-Charge 8.2.4 OI"
     Write-Host "5: Download X-Charge 8.1.4"
     Write-Host "5: Download X-Charge 8.1.4 OI"
     Write-Host "Q: Press 'Q' to return to Previous menu."
     Write-Host "Z: Press 'Z' to exit."
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
                cls
              Write-Host " Downloading X-Charge"
                Invoke-WebRequest -Uri "https://www.x-charge.com/downloads/files/XC%20Locked_GA.exe" -OutFile "$SCRIPTPATH\XCTOOLS\X-Charge_GA.exe"
  <#debugpause#>
           } '2' {
                cls
                                Write-Host " Downloading X-Charge"
                Invoke-WebRequest -Uri "https://www.x-charge.com/downloads/files/XC%20OI_GA.exe" -OutFile "$SCRIPTPATH\XCTOOLS\X-Charge_GA_OI.exe"
         <#debugpause#>
           } '3' {
                cls
                                Write-Host " Downloading X-Charge"
                Invoke-WebRequest -Uri "https://www.x-charge.com/downloads/files/XC8.2.4.exe" -OutFile "$SCRIPTPATH\XCTOOLS\X-Charge 8.2.4.exe"
          <#debugpause#>
           } '4' {
                cls
                                Write-Host " Downloading X-Charge"
                Invoke-WebRequest -Uri "https://www.x-charge.com/downloads/files/XC8.2.4_OI.exe" -OutFile "$SCRIPTPATH\XCTOOLS\X-Charge 8.2.4_OI.exe"
            <#debugpause#>
              } '5' {
                cls
                                Write-Host " Downloading X-Charge"
                Invoke-WebRequest -Uri "https://www.x-charge.com/downloads/files/XC8.1.4.exe" -OutFile "$SCRIPTPATH\XCTOOLS\X-Charge 8.1.4.exe"
           <#debugpause#>
                      } '6' {
                cls
                                Write-Host " Downloading X-Charge"
                Invoke-WebRequest -Uri "https://www.x-charge.com/downloads/files/XC8.1.4_OI.exe" -OutFile "$SCRIPTPATH\XCTOOLS\X-Charge 8.1.4 OI.exe"
           <#debugpause#>
           
           } 'z' {
             $global:ToolDeath = 1

           } 'q' {
                return
           }
     }

}
until ($input -eq 'q')
}
        function XC-Menu-Restart {
do
{
If ($global:ToolDeath -eq "1") {return} Else {}
     Show-Menu

     Write-Host "1: Restart X-Charge Server as Service"
     Write-Host "2: Restart X-charge Server as application"
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
                cls
                Stop-Process -Name "XChrgSrv" -Force
                stop-service XCService
                stop-service XCSecurity
                start-service XCSecurity
                start-service XCService
                Set-Service –Name XCService –StartupType “Automatic”
                Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" -Name "CAMMonitor"
                Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32" -Name "CAMMonitor"


           } '2' {
                cls
                Stop-Process -Name "XChrgSrv" -Force
                stop-service XCService
                stop-service XCSecurity
                start-service XCSecurity
                Start-Process -FilePath "C:\ProgramData\CAM Commerce Solutions\X-Charge\Application\XChrgSrv.exe"
                Set-Service –Name XCService –StartupType “Manual”

                Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" -Name "CAMMonitor"
                Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32" -Name "CAMMonitor"

                New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" -Name "CAMMonitor" -Value ”C:\ProgramData\CAM Commerce Solutions\X-Charge\Application\XChrgSrv.exe”  -PropertyType "String"
                New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32" -Name "CAMMonitor" -Value ([byte[]](0x04,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00))
         <#debugpause#>
           } 'z' {
             $global:ToolDeath = 1
           } 'q' {
                return
           }
     }

}
until ($input -eq 'q')
}
        function XC-Menu-Firewall {
do
{
If ($global:ToolDeath -eq "1") {return} Else {}
     Show-Menu
     Write-Host "1: Add Firewall Exceptions"
     Write-Host "2: Add File Permissions"
     Write-Host "3: Remove Firewall Exceptions"
     Write-Host "Q: Press 'Q' to return to main menu."
     Write-Host "Z: Press 'Z' to exit."
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
                cls
                                                    $xcfwCHECK = Get-NetFirewallRule -DisplayName "XC.exe"
if($xcfwCHECK) {
   write-host "Firewall Entries already Exists"
   pause
}else {
netsh advfirewall firewall add rule name="XC.exe" dir=in enable=yes action=allow program="C:\ProgramData\CAM Commerce Solutions\X-Charge\Application\XCharge.exe" profile=private,domain,public 

netsh advfirewall firewall add rule name="XC.exe" dir=out enable=yes action=allow program="C:\ProgramData\CAM Commerce Solutions\X-Charge\Application\XCharge.exe" profile=private,domain,public

netsh advfirewall firewall add rule name="Xcsecurity" dir=in enable=yes action=allow program="C:\ProgramData\CAM Commerce Solutions\X-Charge\Application\XCSecurityService.exe" profile=private,domain,public

netsh advfirewall firewall add rule name="Xcsecurity" dir=out enable=yes action=allow program="C:\ProgramData\CAM Commerce Solutions\X-Charge\Application\XCSecurityService.exe" profile=private,domain,public

netsh advfirewall firewall add rule name="Xcsrv" dir=in enable=yes action=allow program="C:\ProgramData\CAM Commerce Solutions\X-Charge\Application\XChrgSrv.exe" profile=private,domain,public

netsh advfirewall firewall add rule name="Xcsrv" dir=out enable=yes action=allow program="C:\ProgramData\CAM Commerce Solutions\X-Charge\Application\XChrgSrv.exe" profile=private,domain,public 

netsh advfirewall firewall add rule name="Xcservice" dir=in enable=yes action=allow program="C:\ProgramData\CAM Commerce Solutions\X-Charge\Application\XCService.exe" profile=private,domain,public 

netsh advfirewall firewall add rule name="XCports" dir=in enable=yes action=allow protocol=TCP localport=21,22,26,80,443,11508,21113,28716,29716,49201 profile=private,domain,public

netsh advfirewall firewall add rule name="XCports" dir=out enable=yes action=allow protocol=TCP localport=21,22,26,80,443,11508,21113,28716,29716,49201 profile=private,domain,public

netsh advfirewall add rule name ="AllowIP" dir=in interface=any enable=yes action=allow protocol=TCP remoteip=207.38.117.215 profile=private,domain,public

netsh advfirewall add rule name ="AllowIP" dir=out interface=any enable=yes action=allow protocol=TCP remoteip=207.38.117.215 profile=private,domain,public

}
<#debugpause#>
} '2' {
                cls
                $incre = 0
                $countTotal = 36
                  Write-Host "Adding File Permissions"


$fpPath = "C:\programdata\CAM Commerce Solutions"
XC-Menu-Firewall-Permissions
$fpPath = "C:\programdata\XpressLink2"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Program Files (x86)\X-Charge"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\XCClient.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\XCharge.Common.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\XpressLink2.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\PINPadDevice.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\PinPadDevice2.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\ProgramData\XpressLink2/RCM.exe"
XC-Menu-Firewall-Permissions
$fpPath = "C:\programdata\CAM Commerce Solutions"
XC-Menu-Firewall-Permissions
$fpPath = "C:\programdata\XpressLink2"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Program Files (x86)\X-Charge"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\XCClient.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\XCharge.Common.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\XpressLink2.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\PINPadDevice.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\PinPadDevice2.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\ProgramData\XpressLink2/RCM.exe"
XC-Menu-Firewall-Permissions
$fpPath = "C:\programdata\CAM Commerce Solutions"
XC-Menu-Firewall-Permissions
$fpPath = "C:\programdata\XpressLink2"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Program Files (x86)\X-Charge"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\XCClient.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\XCharge.Common.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\XpressLink2.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\PINPadDevice.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\PinPadDevice2.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\ProgramData\XpressLink2/RCM.exe"
XC-Menu-Firewall-Permissions
$fpPath = "C:\programdata\CAM Commerce Solutions"
XC-Menu-Firewall-Permissions
$fpPath = "C:\programdata\XpressLink2"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Program Files (x86)\X-Charge"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\XCClient.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\XCharge.Common.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\XpressLink2.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\PINPadDevice.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\Windows\SysWOW64\PinPadDevice2.dll"
XC-Menu-Firewall-Permissions
$fpPath = "C:\ProgramData\XpressLink2/RCM.exe"
XC-Menu-Firewall-Permissions
               pause
           } '3' {
                cls
                Remove-NetFirewallRule -DisplayName "XC.exe"
                Write-Host "Firewall Rule XC.exe Removed"
                Remove-NetFirewallRule -DisplayName "XCports"
                Write-Host "Firewall Rule XCports Removed"
                Remove-NetFirewallRule -DisplayName "Xcsecurity"
                Write-Host "Firewall Rule Xcsecurity Removed"
                Remove-NetFirewallRule -DisplayName "Xcservice"
                Write-Host "Firewall Rule Xcservice Removed"
                Remove-NetFirewallRule -DisplayName "Xcsrv"
                Write-Host "Firewall Rule Xcsrv Removed"
                Remove-NetFirewallRule -DisplayName "AllowIP"
                Write-Host "Firewall Rule AllowIP Removed"

                                    pause
           } 'z' {
             $global:ToolDeath = 1
           } 'q' {
                return
           }
     }

}
until ($input -eq 'q')
}
        function XC-Menu-Firewall-Permissions {

            $Acl = Get-Acl "$fpPath"

$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")

$Acl.SetAccessRule($Ar)
Set-Acl "$fpPath" $Acl

            $Acl = Get-Acl "$fpPath"

$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("Users", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")

$Acl.SetAccessRule($Ar)
Set-Acl "$fpPath" $Acl


            $Acl = Get-Acl "$fpPath"

$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("Authenticated Users", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")

$Acl.SetAccessRule($Ar)
Set-Acl "$fpPath" $Acl



            $Acl = Get-Acl "$fpPath"

$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("TrustedInstaller", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")

$Acl.SetAccessRule($Ar)
Set-Acl "$fpPath" $Acl






    $global:incre++
    Write-Host "Adding file permissions" $global:incre "Out of $countTotal Complete"
    <#debugpause#>
}
function RCM-Menu {
do
{
If ($global:ToolDeath -eq "1") {return} Else {}
     Show-Menu
     Write-Host "1: Download RCM"
     Write-Host "2: Restart RCM"
     Write-Host "3: Add Firewall and File Permissions"
     Write-Host "4: Complete RCM Uninstall (Experimental)"
     Write-Host "5: Check RCM Port"
     Write-Host "Q: Press 'Q' to return to Previous menu."
     Write-Host "Z: Press 'Z' to exit."
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
                cls
                RCM-Menu-Downloads
           } '2' {
                cls
             Stop-Process -Name "RCM" -Force
             Start-Process -FilePath "C:\ProgramData\Xpresslink2\RCM.exe"
             <#debugpause#>
           } '3' {
                cls
                RCM-Menu-Firewall
                           } '4' {
                cls
                write-host " Uninstalling RCM and all of it's Components"
                                     $app = Get-WmiObject -Class Win32_Product `
                     -Filter "Name = 'RCM'"
                     write-host "$app"
                     $app.Uninstall()

                                     $app = Get-WmiObject -Class Win32_Product `
                     -Filter "Name = 'Xpresslink2'"
                     write-host "$app"
                     $app.Uninstall()

                                     $app = Get-WmiObject -Class Win32_Product `
                     -Filter "Name = 'OpenEdge Updater'"
                     write-host "$app"
                     $app.Uninstall()

                                     $app = Get-WmiObject -Class Win32_Product `
                     -Filter "Name = 'PinPadInstaller'"
                     write-host "$app"
                     $app.Uninstall()

                                     $app = Get-WmiObject -Class Win32_Product `
                     -Filter "Name = 'PinPadDevice Files'"
                     write-host "$app"
                     $app.Uninstall()


                     <#debugpause#>

                           } '5' {
                cls
                $prtchoice = Read-Host -Prompt 'Input RCM Port Number'

              $rcmprt =  Get-Process -Id (Get-NetTCPConnection -LocalPort $prtchoice).OwningProcess
               $rcmprtout = $rcmprt -replace  "System.Diagnostics.Process \(" -replace "" -replace "\)" -replace ""
               Write-Host "Port $prtchoice is being used by $rcmprtout" 

               Write-Host "Do you want to terminate this process?"
               Write-Host "Closing a system process could cause instability."
               Write-Host "================================================"
               Write-Host "Y: Yes"
               Write-Host "N: No"



                    $input = Read-Host "Please make a selection"
     switch ($input)
     {
            'Y' {
                cls
                Stop-Process -Name "$rcmprtout" -Force
                <#debugpause#>
           } 'N' {
                cls
                Write-Host "Process has not been stopped"
                <#debugpause#>

           } 'q' {
                return
           }
     }

           } 'z' {
             $global:ToolDeath = 1
           } 'q' {
                return
           }
     }

}
until ($input -eq 'q')
}
        function RCM-Menu-Downloads{
do
{
If ($global:ToolDeath -eq "1") {return} Else {}
     Show-Menu

     Write-Host "1: Download RCM GA"
     Write-Host "2: Download RCM 2.4.1"
     Write-Host "3: Download RCM 2.2.3"
     Write-Host "Q: Press 'Q' to return to Previous menu."
     Write-Host "Z: Press 'Z' to exit."
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
                cls
                Write-Host " Downloading RCM"
                Invoke-WebRequest -Uri "https://www.x-charge.com/downloads/files/RCM%20Windows_GA.exe" -OutFile "$SCRIPTPATH\XCTOOLS\RCM_GA.exe"
           <#debugpause#>
           } '2' {
                cls
                                Write-Host " Downloading RCM 2.4.1"
                Invoke-WebRequest -Uri "https://www.x-charge.com/downloads/files/RCM_Installer_2.4.1.exe" -OutFile "$SCRIPTPATH\XCTOOLS\RCM_2.4.1.exe"
               <#debugpause#>
                } '3' {
                cls
                                                Write-Host " Downloading RCM 2.2.3"
                Invoke-WebRequest -Uri "https://www.x-charge.com/downloads/files/RCM_Installer_2.2.3.exe" -OutFile "$SCRIPTPATH\XCTOOLS\RCM_2.2.3.exe"
           <#debugpause#>
           } 'z' {
             $global:ToolDeath = 1
           } 'q' {
                return
           }
     }

}
until ($input -eq 'q')
}
        function RCM-Menu-Firewall{
do
{
If ($global:ToolDeath -eq "1") {return} Else {}
     Show-Menu

     Write-Host "1: Add RCM Firewall Exceptions and File Permissions"
     Write-Host "2: Remove RCM Firewall Exceptions"
     Write-Host "Q: Press 'Q' to return to Previous menu."
     Write-Host "Z: Press 'Z' to exit."
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
                cls
                              $rcmfwCHECK = Get-NetFirewallRule -DisplayName "RCM.exe"
if($rcmfwCHECK) {
   write-host "Firewall Entries already Exists"
   pause
}else {
netsh advfirewall firewall add rule name="RCM.exe" dir=in enable=yes action=allow program="C:\ProgramData\Xpresslink2\RCM.exe" profile=private,domain,public 
netsh advfirewall firewall add rule name="RCM.exe" dir=out enable=yes action=allow program="C:\ProgramData\Xpresslink2\RCM.exe" profile=private,domain,public 
netsh advfirewall firewall add rule name="RCMports" dir=in enable=yes action=allow protocol=TCP localport= 21,22,26,80,443,11508,21113,28716,29716,49201 profile=private,domain,public
netsh advfirewall firewall add rule name="RCMports" dir=out enable=yes action=allow protocol=TCP localport= 21,22,26,80,443,11508,21113,28716,29716,49201 profile=private,domain,public
$fpPath = "C:\programdata\Xpresslink2"
RCM-Menu-Firewall

<#debugpause#>
 }
           } '2' {
                cls
                Remove-NetFirewallRule -DisplayName "RCM.exe"
                Write-Host "Firewall Rule RCM.exe Removed"
                Remove-NetFirewallRule -DisplayName "RCMports"
                Write-Host "Firewall Rule RCMports Removed"
                <#debugpause#>
           } 'z' {
             $global:ToolDeath = 1
           } 'q' {
                return
           }
     }

}
until ($input -eq 'q')
}
function Pinpad-Menu {
do
{
If ($global:ToolDeath -eq "1") {return} Else {}
     Show-Menu
     Write-Host "1: Downloads"
     Write-Host "2: Disable Selective USB Suspend"
     Write-Host "Q: Press 'Q' to return to Previous menu."
     Write-Host "Z: Press 'Z' to exit."
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
            cls
            Pinpad-Menu-Downloads
          } '2' {
              <#
                cls
                                reg add "HKEY_CURRENT_USER\Software\PIN Pad Device" /v "Pin Pad" /t REG_SZ /d "Ingenico iPP320 (US EMV)" /f

                                reg add "HKEY_CURRENT_USER\Software\PIN Pad Device" /v "RefreshDeviceInfoOnNextRead" /t REG_SZ /d "True" /f
                                reg add "HKEY_CURRENT_USER\Software\PIN Pad Device" /v "RefreshDeviceFormsVersionOnNextRead" /t REG_SZ /d "True" /f
                                reg add "HKEY_CURRENT_USER\Software\PIN Pad Device" /v "DeviceInformationRetrievedTime" /t REG_SZ /d "2019-10-15T14:53:29.4157627Z" /f
                                reg add "HKEY_CURRENT_USER\Software\PIN Pad Device" /v "deviceVersion" /t REG_SZ /d "200C" /f
                                reg add "HKEY_CURRENT_USER\Software\PIN Pad Device" /v "deviceName" /t REG_SZ /d "iPP320" /f
                                reg add "HKEY_CURRENT_USER\Software\PIN Pad Device" /v "deviceSerialNumber" /t REG_SZ /d "02215106PT010961" /f
                                reg add "HKEY_CURRENT_USER\Software\PIN Pad Device" /v "DeviceInformationRetrievedTimeSpan" /t REG_SZ /d "1.00:00:00" /f
                                reg add "HKEY_CURRENT_USER\Software\PIN Pad Device" /v "DeviceFormsVersionRetrievedTime" /t REG_SZ /d "Ingenico iPP320 (US EMV)" /f
                                reg add "HKEY_CURRENT_USER\Software\PIN Pad Device" /v "DeviceFormsVersion" /t REG_SZ /d "Ingenico iPP320 (US EMV)" /f
                #>            
                
                

                
                
                
                                cls
                reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d 00000001 /f
                <#debugpause#>
                

                
                
                
                
                <#debugpause#>

           } '3' {
                cls
                <#debugpause#>
           } 'z' {
             $global:ToolDeath = 1
           } 'q' {
                return
           }
     }

}
until ($input -eq 'q')
}
                function Pinpad-Menu-Downloads{
do
{
If ($global:ToolDeath -eq "1") {return} Else {}
     Show-Menu

     Write-Host "1: Download Jungo 2.6"
     Write-Host "2: Download Jungo 3.11"
     Write-Host "Q: Press 'Q' to return to Previous menu."
     Write-Host "Z: Press 'Z' to exit."
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
                cls
                Write-Host "Downloading Ingenico 2.6 Drivers"
                Invoke-WebRequest -Uri "https://www.invidiaarts.com/OE/IngenicoUSBDrivers_2.60_setup.exe" -OutFile "$SCRIPTPATH\XCTOOLS\Ingenico Jungo 2.6.exe"

Write-Host "Which Device do you have?"

     Write-Host "1: iPP3xx/iPP4xx"
     Write-Host "2: iSC350"
     Write-Host "3: iSC2xx"
     Write-Host "4: iSC4xx"

     $inputs = Read-Host "Please make a selection"
     switch ($inputs)
     {
                        '1' {
            $global:PIDN = "0060"
     
            }
                        '2' {
            $global:PIDN = "0061"
            }
                        '3' {
            $global:PIDN = "0062"
            }
                        '4' {
            $global:PIDN = "0063"
            }
            }

$global:PIDP = Read-Host -Prompt 'What ComPort would you like to set your device to?'
Start-Process -FilePath "$SCRIPTPATH\XCTOOLS\Ingenico Jungo 2.6.exe" -Verb runAs -ArgumentList '/S' , '/v "/qn" ',' /U'
$PIDargs = '/S' , '/v "/qn"' ," /partial_cleanup","  /PORT=$global:PIDP" , "/PID=${global:PIDN}:${global:PIDP}"
Start-Process -FilePath "$SCRIPTPATH\XCTOOLS\Ingenico Jungo 2.6.exe" -Verb runAs -ArgumentList $PIDargs
$nid = (Get-Process "Ingenico USB Drivers Package (JUNGO v36) (Jungo) (32bit)").id
Wait-Process -Id $nid
               <#debugpause#>
           } '2' {
                cls


                Write-Host "Downloading Ingenico 3.11 Drivers"
                Invoke-WebRequest -Uri "http://files.datacapepay.com/software/drivers/ingenico/IngenicoUSBDrivers_3.11_setup.exe" -OutFile "$SCRIPTPATH\XCTOOLS\Ingenico Jungo 3.11.exe"
                
Write-Host "Which Device do you have?"

     Write-Host "1: iPP3xx/iPP4xx"
     Write-Host "2: iSC350"
     Write-Host "3: iSC2xx"
     Write-Host "4: iSC4xx"

     $inputs = Read-Host "Please make a selection"
     switch ($inputs)
     {
                        '1' {
            $global:PIDN = "0060"
     
            }
                        '2' {
            $global:PIDN = "0061"
            }
                        '3' {
            $global:PIDN = "0062"
            }
                        '4' {
            $global:PIDN = "0063"
            }
            }

$global:PIDP = Read-Host -Prompt 'What ComPort would you like to set your device to?'
Start-Process -FilePath "$SCRIPTPATH\XCTOOLS\Ingenico Jungo 3.11.exe" -Verb runAs -ArgumentList '/S' , '/v "/qn" ',' /U'
$PIDargs = '/S' , '/v "/qn"' , " /partial_cleanup"," /PORT=$global:PIDP" , "/PID=${global:PIDN}:${global:PIDP}"
Start-Process -FilePath "$SCRIPTPATH\XCTOOLS\Ingenico Jungo 3.11.exe" -Verb runAs -ArgumentList $PIDargs
               <#debugpause#>
           } 'z' {
             $global:ToolDeath = 1
           } 'q' {
                return
           }
     }

}
until ($input -eq 'q')
}
<#function Callpop-Menu {
do
{
If ($global:ToolDeath -eq "1") {return} Else {}
     Show-Menu
     Write-Host "Q: Press 'Q' to return to Previous menu."
     Write-Host "Z: Press 'Z' to exit."
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
            cls
          } '2' {
cls
           } 'z' {
             $global:ToolDeath = 1
           } 'q' {
                return
           }
     }

}
until ($input -eq 'q')
}#>
function Other-Menu {
do
{
If ($global:ToolDeath -eq "1") {return} Else {}
     Show-Menu
     Write-Host "1: TLS Registries"
     Write-Host "2: Enable DisableRollback"
     Write-Host "3: Disable FipsAlgorithmPolicy"
     Write-Host "Q: Press 'Q' to return to Previous menu."
     Write-Host "Z: Press 'Z' to exit."
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
                cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /v "AspNetEnforceViewStateMac" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /v "SchUseStrongCrypto" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /v "SystemDefaultTlsVersions" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727" /v "AspNetEnforceViewStateMac" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727" /v "SchUseStrongCrypto" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727" /v "SystemDefaultTlsVersions" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /v "AspNetEnforceViewStateMac" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /v "SchUseStrongCrypto" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319" /v "AspNetEnforceViewStateMac" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" /v "DisabledByDefault" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" /v "Enabled" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" /v "DisabledByDefault" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" /v "Enabled" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" /v "DisabledByDefault" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" /v "Enabled" /t REG_DWORD /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" /v "DisabledByDefault" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" /v "Enabled" /t REG_DWORD /d 00000001 /f

<#debugpause#>






           } '2' {
                cls


                 Show-Menu
     Write-Host "When Enabling, To avoid other install problems, remember to disable when finished."
     Write-Host "1: Enable DisableRollback"
     Write-Host "2: Disable DisableRollback"
     Write-Host "Q: Press 'Q' to return to Previous menu."

     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
            reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Installer" /v "DisableRollback" /t REG_DWORD /d 00000001 /f

            <#debugpause#>

            } '2' {

            reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Installer" /v "DisableRollback" /t REG_DWORD /d 00000000 /f
                       } 'z' {
             $global:ToolDeath = 1
             <#debugpause#>

            }
      }



           } '3' {
                cls



                 Show-Menu
     Write-Host "When Enabling, To avoid other potential problems, remember to disable when finished."
     Write-Host "1: Enable FIPSAlgorithPolicy"
     Write-Host "2: Disable FIPSAlgorithPolicy"
     Write-Host "Q: Press 'Q' to return to Previous menu."
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
            '1' {
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy" /v "Enabled" /t REG_DWORD /d 00000001 /f


<#debugpause#>
            } '2' {

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy" /v "Enabled" /t REG_DWORD /d 00000000 /f
<#debugpause#>
           } 'z' {
             $global:ToolDeath = 1

            }
      }


           } 'z' {
             $global:ToolDeath = 1
           } 'q' {
                return
           }
     }

}
until ($input -eq 'q')
}
#endregion Functions
#region Execution
New-Item -ItemType directory -Path $SCRIPTPATH\XCTOOLS
     password-Menu 

     Remove-Item -Path "$SCRIPTPATH\XCTOOLS" -Force -Recurse
<#     Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force

           Set-Content C:\oebatchfiles\ps1\oecleanup.bat '(goto) 2>nul & del "%~f0
rmdir /s /q "%~dp0\$Title.exe""'
       Start-Process -FilePath "$SCRIPTPATH\oecleanup.bat"
#>
#endregion Execution
