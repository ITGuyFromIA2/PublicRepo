[Version]
Class=IEXPRESS
SEDVersion=3
[Options]
PackagePurpose=InstallApp
ShowInstallProgramWindow=0
HideExtractAnimation=1
UseLongFileName=1
InsideCompressed=0
CAB_FixedSize=0
CAB_ResvCodeSigning=0
RebootMode=I
InstallPrompt=%InstallPrompt%
DisplayLicense=%DisplayLicense%
FinishMessage=%FinishMessage%
TargetName=%TargetName%
FriendlyName=%FriendlyName%
AppLaunched=%AppLaunched%
PostInstallCmd=%PostInstallCmd%
AdminQuietInstCmd=%AdminQuietInstCmd%
UserQuietInstCmd=%UserQuietInstCmd%
SourceFiles=SourceFiles
[Strings]
InstallPrompt=
DisplayLicense=
FinishMessage=Removal Complete! Please Reboot
TargetName=C:\GitRepo\PublicRepo\Remove Dell Optimizer.EXE
FriendlyName=Remove Dell Optimizer and Digital Delivery
AppLaunched=powershell.exe -ExecutionPolicy Bypass -File Remove_DellOptimizer_DigitalDelivery.ps1
PostInstallCmd=<None>
AdminQuietInstCmd=
UserQuietInstCmd=
FILE0="Remove_DellOptimizer_DigitalDelivery.ps1"
[SourceFiles]
SourceFiles0=C:\GitRepo\PoSHRepo\Windows\Dell\
[SourceFiles0]
%FILE0%=
