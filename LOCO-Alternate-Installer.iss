; LEGO LOCO Alternate Installer V1.0.1
; Created 2013 Triangle717
; <http://triangle717.wordpress.com/>
; Contains source code from Grim Fandango Setup
; Copyright (c) 2007-2008 Bgbennyboy
; <http://quick.mixnmojo.com/>
                                  
; If any version below the specified version is used for compiling, this error will be shown.
#if VER < EncodeVer(5,5,2)
  #error You must use Inno Setup 5.5.2 or newer to compile this script
#endif
         
#define MyAppInstallerName "LEGO LOCO Alternate Installer"
#define MyAppInstallerVersion "1.0.1"
#define MyAppName "LEGO LOCO"
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
DefaultDirName={pf}\LEGO Media\Constructive\{#MyAppName}
DefaultGroupName=LEGO Media\{#MyAppName}
AllowNoIcons=yes
; Installer Graphics
SetupIconFile=Lego.ico
WizardImageFile=Installfig1.bmp
WizardSmallImageFile=InnoSetup LEGO Logo.bmp
WizardImageStretch=True
WizardImageBackColor=clBlack
; Location of the compiled Exe
OutputDir=Here Lie The EXE
OutputBaseFilename={#MyAppInstallerName} {#MyAppInstallerVersion}
; Uninstallation stuff
UninstallFilesDir={app}
UninstallDisplayIcon={app}\Lego.ico
CreateUninstallRegKey=true
UninstallDisplayName={#MyAppName}
; Compression
SolidCompression=True
Compression=lzma/ultra64
InternalCompressLevel=ultra
LZMAUseSeparateProcess=yes
; From top to bottom: Allows installation to C:\ (and the like),
; Explicitly set Admin rights, no other languages, do not restart upon finishing.
AllowRootDirectory=yes
PrivilegesRequired=admin
ShowLanguageDialog=no
RestartIfNeededByRun=no

[Languages]
Name: "English"; MessagesFile: "compiler:Default.isl"

[Messages]
BeveledLabel={#MyAppInstallerName}

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "Admin"; Description: "Run {#MyAppName} with Administrator Rights"; GroupDescription: "{cm:AdditionalIcons}"

[Registry]
; Registry strings are always hard-coded (No ISPP functions) to ensure everything works properly.
Root: "HKCU"; Subkey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\LEGORacers.exe"; ValueData: "RUNASADMIN"; Flags: uninsdeletevalue; Tasks: Admin

[Files]
Source: "{code:GetSourceDrive}Exe\loco.exe"; DestDir: "{app}\Exe"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}Exe\LEGO LOCO.scr"; DestDir: "{app}\Exe"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}setupdir\0009\licence.txt"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}Lego.ico"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}Exe\LEGO.INI"; DestDir: "{app}\Exe"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}art-res\*"; DestDir: "{app}\art-res"; Flags: external ignoreversion recursesubdirs createallsubdirs
Source: "{code:GetSourceDrive}Video\locoIntr.avi"; DestDir: "{app}\Video"; Flags: external ignoreversion

[INI]
Filename: "{app}\Exe\LEGO.INI"; Section: "DIRECTORIES"; Key: "Res"; String: "{app}\ART-res";
Filename: "{app}\Exe\LEGO.INI"; Section: "DIRECTORIES"; Key: "ResFile"; String: "{app}\ART-res\resource.rfh";
Filename: "{app}\Exe\LEGO.INI"; Section: "DIRECTORIES"; Key: "exe"; String: "Loco.exe"
Filename: "{app}\Exe\LEGO.INI"; Section: "Video"; Key: "Dir"; String: "{app}\Video\LocoIntr.avi"
Filename: "{app}\Exe\LEGO.INI"; Section: "Locale"; Key: "Language"; String: "ENGLISH"

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\Exe\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\Exe\{#MyAppExeName}"; Tasks: desktopicon

[Registry]
Root: "HKLM"; Subkey: "SOFTWARE\Intelligent Games\LEGO LOCO\Path"; ValueType: String; ValueName: "(Default)"; ValueData: "{app}\Exe"; Flags: uninsdeletevalue createvalueifdoesntexist
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGO LOCO\1.12.008"; ValueType: none; Flags: uninsdeletevalue createvalueifdoesntexist
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\loco.exe"; ValueType: String; ValueName: "(Default)"; ValueData: "{app}\loco.exe"; Flags: uninsdeletevalue createvalueifdoesntexist
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\loco.exe"; ValueType: String; ValueName: "Path"; ValueData: "{app}"; Flags: uninsdeletevalue createvalueifdoesntexist
Root: "HKCU"; Subkey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\Exe\loco.exe"; ValueData: "RUNASADMIN"; Flags: uninsdeletevalue createvalueifdoesntexist

[Code]
// Pascal script from Bgbennyboy to pull files off a CD, greatly trimmed up and modified to support ANSI and Unicode Inno Setup by Triangle717.
var
  SourceDrive: string;

#include "FindDisc.iss"

function GetSourceDrive(Param: String): String;
begin
	Result:=SourceDrive;
end;

procedure InitializeWizard();
begin
	SourceDrive:=GetSourceCdDrive();
end;
