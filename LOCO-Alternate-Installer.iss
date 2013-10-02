; LEGO LOCO Alternate Installer V1.0.3
; Created 2013 Triangle717
; <http://Triangle717.WordPress.com/>
; Contains source code from Grim Fandango Setup
; Copyright (c) 2007-2008 Bgbennyboy
; <http://quick.mixnmojo.com/>
                                  
; If any version below the specified version is used for compiling, 
; this error will be shown.
#if VER < EncodeVer(5,5,2)
  #error You must use Inno Setup 5.5.2 or newer to compile this script
#endif
       
#define MyAppInstallerName "LEGO® LOCO Alternate Installer"
#define MyAppInstallerVersion "1.0.3"
#define MyAppName "LEGO® LOCO"
#define MyAppNameNoR "LEGO LOCO"
#define MyAppVersion "1.0.18.2"
#define MyAppPublisher "LEGO International Ltd."
#define MyAppExeName "loco.exe"

[Setup]
AppID={#MyAppInstallerName}{#MyAppInstallerVersion}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
VersionInfoVersion={#MyAppInstallerVersion}
AppPublisher={#MyAppPublisher}
AppCopyright=© 1998 {#MyAppPublisher}
LicenseFile=licence.txt
; Start menu/screen and Desktop shortcuts
DefaultDirName={pf}\LEGO Media\Constructive\{#MyAppNameNoR}
DefaultGroupName=LEGO Media\{#MyAppNameNoR}
AllowNoIcons=yes
; Installer Graphics
SetupIconFile=Lego.ico
WizardImageFile=Installfig1.bmp
WizardSmallImageFile=Small-Image.bmp
WizardImageStretch=True
WizardImageBackColor=clBlack
; Location of the compiled Exe
OutputDir=bin
OutputBaseFilename={#MyAppNameNoR} Alternate Installer {#MyAppInstallerVersion}
; Uninstallation stuff
UninstallFilesDir={app}
UninstallDisplayIcon={app}\Lego.ico
CreateUninstallRegKey=true
UninstallDisplayName={#MyAppName}
; This is required so Inno can correctly report the installation size.
UninstallDisplaySize=218103808
; Compression
SolidCompression=True
Compression=lzma/ultra64
InternalCompressLevel=ultra
LZMAUseSeparateProcess=yes
; From top to bottom:
; Explicitly set Admin rights, no other languages, do not restart upon finishing.
PrivilegesRequired=admin
ShowLanguageDialog=no
RestartIfNeededByRun=no

[Languages]
Name: "English"; MessagesFile: "compiler:Default.isl"

[Messages]
BeveledLabel={#MyAppInstallerName}
; DiskSpaceMBLabel is overridden because it reports an incorrect installation size.
DiskSpaceMBLabel=At least 208 MB of free disk space is required.
; Overwrite the finished installation messages
FinishedHeadingLabel=[name] has been installed
FinishedLabelNoIcons=Setup has finished installing [name] on your computer.%nYou will need to change your computer's screen resolution before playing.%nFor complete details, please visit http://wp.me/p1V5ge-br

; Both Types and Components sections are required to create the installation options.
[Types]
Name: "Full"; Description: "Full Installation (With Movies)"  
Name: "Minimal"; Description: "Minimal Installation (Without Movies)"

[Components]
Name: "Full"; Description: "Full Installation (With Movies)"; Types: Full
Name: "Minimal"; Description: "Minimal Installation (Without Movies)"; Types: Minimal

[Files]
; Icon and PDF manual from 2001 rerelease
Source: "Lego.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "Manual.pdf"; DestDir: "{app}"; Flags: ignoreversion skipifsourcedoesntexist
; Grab the files off the disc
Source: "{code:GetSourceDrive}setupdir\0009\licence.txt"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}Exe\*"; DestDir: "{app}\Exe"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}art-res\*"; DestDir: "{app}\art-res"; Flags: external ignoreversion recursesubdirs createallsubdirs
; Install the intro video only if user choose to do so
Source: "{code:GetSourceDrive}Video\locoIntr.avi"; DestDir: "{app}\Video"; Flags: external ignoreversion; Components: Full

[INI]
; Write LEGO.INI
Filename: "{app}\Exe\LEGO.INI"; Section: "DIRECTORIES"; Key: "Res"; String: "{app}\ART-res"
Filename: "{app}\Exe\LEGO.INI"; Section: "DIRECTORIES"; Key: "ResFile"; String: "{app}\ART-res\resource.rfh"
Filename: "{app}\Exe\LEGO.INI"; Section: "DIRECTORIES"; Key: "exe"; String: "Loco.exe"
; Write path to video on the HDD if it was installed
Filename: "{app}\Exe\LEGO.INI"; Section: "Video"; Key: "Dir"; String: "{app}\Video\LocoIntr.avi"; Components: Full
; Otherwise, write path to video on the disc
Filename: "{app}\Exe\LEGO.INI"; Section: "Video"; Key: "Dir"; String: "{code:GetSourceDrive}\Video\LocoIntr.avi"; Components: Minimal
Filename: "{app}\Exe\LEGO.INI"; Section: "Locale"; Key: "Language"; String: "ENGLISH"

[Registry]
; Registry strings are always hard-coded (!No ISPP functions!) to ensure everything works properly.
; 2001 rerelease requires both LEGO.INI and Registry strinsg to run. 
; Original release only needs LEGO.INI.
; Do these have any adverse side-effects on 1998 copy, and can they not be installed if a 1998 copy is being used?
Root: "HKLM"; Subkey: "SOFTWARE\Intelligent Games\LEGO LOCO"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Intelligent Games\LEGO LOCO\Path"; ValueType: String; ValueName: "(Default)"; ValueData: "{app}\Exe"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGO LOCO"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGO LOCO\1.12.008"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\loco.exe"; ValueType: String; ValueName: "(Default)"; ValueData: "{app}\loco.exe"; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\loco.exe"; ValueType: String; ValueName: "Path"; ValueData: "{app}"; Flags: uninsdeletevalue
Root: "HKCU"; Subkey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\Exe\loco.exe"; ValueData: "RUNASADMIN"; Flags: uninsdeletevalue

[Tasks]
; Create a Destkop icon, run with Administrator rights
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "Admin"; Description: "Run {#MyAppName} with Administrator Rights"; GroupDescription: "{cm:AdditionalIcons}"

[Icons]
; Start Menu/Screen shortcuts
Name: "{group}\{#MyAppName}"; Filename: "{app}\Exe\{#MyAppExeName}"; IconFilename: "{app}\Lego.ico"
; Add shortcut to manual
Name: "{group}\{#MyAppName} Manual"; Filename: "{app}\Manual.pdf";
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\Lego.ico"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\Exe\{#MyAppExeName}"; IconFilename: "{app}\Lego.ico"; Tasks: desktopicon

[Dirs]
; Created to ensure the save games and postcards are not removed 
; (which should never ever happen).
Name: "{app}\art-res\SAVEGAME"; Flags: uninsneveruninstall
Name: "{app}\art-res\POSTBAG"; Flags: uninsneveruninstall

[Code]
// Pascal script from Bgbennyboy to pull files off a CD, greatly trimmed up 
// and modified to support ANSI and Unicode Inno Setup by Triangle717.
// https://github.com/bgbennyboy/Grim-Fandango-Setup-and-Launcher
var
  SourceDrive: string;

#include "FindDisc.pas"

function GetSourceDrive(Param: String): String;
begin
	Result:=SourceDrive;
end;

procedure InitializeWizard();
begin
	SourceDrive:=GetSourceCdDrive();
end;
