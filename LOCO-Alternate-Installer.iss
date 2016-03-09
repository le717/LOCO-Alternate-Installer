;  LEGO LOCO Alternate Installer
;  Created 2013-2016 Caleb Ely
;  <http://Triangle717.WordPress.com/>
;
;  Contains source code from Grim Fandango Setup
;  Copyright (c) 2007-2008 Bgbennyboy
;  <http://quick.mixnmojo.com/>
                                  
; If any version below the specified version is used for compiling, 
; this error will be shown.
#if VER < EncodeVer(5, 5, 8)
  #error You must use Inno Setup 5.5.8 or newer to compile this script
#endif
       
#define MyAppNameNoR "LEGO LOCO"

#define MyAppInstallerName "LEGO Stunt Rally Alternate Installer"
#define MyAppInstallerVersion "1.1.0"
#define MyAppName "LEGO LOCO"
#define MyAppVersion "1.0.18.2"
#define MyAppPublisher "Intelligent Games"
#define MyAppExeName "loco.exe"

[Setup]
AppID={#MyAppName}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
VersionInfoVersion={#MyAppInstallerVersion}
AppPublisher={#MyAppPublisher}
AppCopyright=(c) 1998 {#MyAppPublisher}
LicenseFile=license.txt

DefaultDirName={pf}\LEGO Media\Games\{#MyAppName}
DefaultGroupName=LEGO Media\{#MyAppName}
AllowNoIcons=yes

; Installer Graphics
SetupIconFile=LOCO.ico
WizardImageFile=Sidebar.bmp
WizardSmallImageFile=Small-Image.bmp
WizardImageStretch=True

OutputDir=bin
OutputBaseFilename=LEGO-Stunt-Rally-Alternate-Installer-{#MyAppInstallerVersion}

UninstallFilesDir={app}
UninstallDisplayName={#MyAppName}
UninstallDisplayIcon={app}\LOCO.ico
CreateUninstallRegKey=yes
; This is required so Inno can correctly report the installation size.
UninstallDisplaySize=218103808

Compression=lzma2/ultra64
SolidCompression=True
InternalCompressLevel=ultra
LZMAUseSeparateProcess=yes

PrivilegesRequired=admin
ShowLanguageDialog=no
RestartIfNeededByRun=no

[Languages]
Name: "English"; MessagesFile: "compiler:Default.isl"

[Messages]
BeveledLabel={#MyAppInstallerName}

; DiskSpaceMBLabel is overridden in order to report 
; a correct installation size
DiskSpaceMBLabel=At least 208 MB of free disk space is required.

; Overwrite the finished installation messages
FinishedHeadingLabel=[name] has been installed
FinishedLabelNoIcons=Setup has finished installing [name] on your computer.%nYou will need to change your computer's screen resolution before playing.%nFor complete details, please visit http://wp.me/p1V5ge-br

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "adminrun"; Description: "Run {#MyAppName} with Administrator Rights"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "{code:GetSourceDrive}\Exe\*"; DestDir: "{app}\Exe"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}\art-res\*"; DestDir: "{app}\art-res"; Flags: external ignoreversion recursesubdirs createallsubdirs
Source: "{code:GetSourceDrive}\Video\locoIntr.avi"; DestDir: "{app}\Video"; Flags: external ignoreversion; Components: Full

Source: "licence.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "LOCO.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "Manual.pdf"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
; Start Menu/Screen shortcuts
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\LOCO.ico"; IconIndex: 0; Comment: "Run {#MyAppName}"
Name: "{group}\{#MyAppName} Manual"; Filename: "{app}\Manual.pdf"; Comment: "View {#MyAppName} manual"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\LOCO.ico"; Comment: "Uninstall {#MyAppName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\StuntRally.ico"; IconIndex: 0; Comment: "Run {#MyAppName}"; Tasks: desktopicon

[Registry]
Root: "HKLM"; Subkey: "SOFTWARE\Intelligent Games\LEGO LOCO"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Intelligent Games\LEGO LOCO\Path"; ValueType: String; ValueName: "(Default)"; ValueData: "{app}\Exe"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGO LOCO"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGO LOCO\1.12.008"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\loco.exe"; ValueType: String; ValueName: "(Default)"; ValueData: "{app}\loco.exe"; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\loco.exe"; ValueType: String; ValueName: "Path"; ValueData: "{app}"; Flags: uninsdeletevalue
Root: "HKCU"; Subkey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\Exe\loco.exe"; ValueData: "RUNASADMIN"; Flags: uninsdeletevalue; Tasks: adminrun

[INI]
Filename: "{app}\Exe\LEGO.INI"; Section: "DIRECTORIES"; Key: "Res"; String: "{app}\ART-res"
Filename: "{app}\Exe\LEGO.INI"; Section: "DIRECTORIES"; Key: "ResFile"; String: "{app}\ART-res\resource.rfh"
Filename: "{app}\Exe\LEGO.INI"; Section: "DIRECTORIES"; Key: "exe"; String: "Loco.exe"

Filename: "{app}\Exe\LEGO.INI"; Section: "Video"; Key: "Dir"; String: "{app}\Video\LocoIntr.avi"; Components: Full
Filename: "{app}\Exe\LEGO.INI"; Section: "Video"; Key: "Dir"; String: "{code:GetSourceDrive}\Video\LocoIntr.avi"; Components: Minimal

Filename: "{app}\Exe\LEGO.INI"; Section: "Locale"; Key: "Language"; String: "ENGLISH"

[Types]
; TODO Can I only use Types or only Components?
Name: "Full"; Description: "Full Installation (With Movies)"  
Name: "Minimal"; Description: "Minimal Installation (Without Movies)"

[Components]
Name: "Full"; Description: "Full Installation (With Movies)"; Types: Full
Name: "Minimal"; Description: "Minimal Installation (Without Movies)"; Types: Minimal

[Dirs]
; Do not remove save games and postcards
Name: "{app}\art-res\SAVEGAME"; Flags: uninsneveruninstall
Name: "{app}\art-res\POSTBAG"; Flags: uninsneveruninstall

[Code]
// Pascal script from Bgbennyboy to detect a CD, cleaned up
// and modified to support both ANSI and Unicode Inno Setup
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
