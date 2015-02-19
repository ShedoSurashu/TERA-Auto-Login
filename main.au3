#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile=teralogin.exe
#AutoIt3Wrapper_Res_Description=TERA Auto Login
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=blog.surashu.com
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         blog.surashu.com

 Script Function:
	Logs you in to TERA.

#ce ----------------------------------------------------------------------------

; This section loads your defined email and password in the INI file.
$usermail = IniRead("teralogin.ini", "account", "mail", "")
$userpass = IniRead("teralogin.ini", "account", "pass", "")

; If there is no email in your settings, you get this error and the program closes.
If ($usermail = '') Then
	MsgBox(65584, "TERA Auto Login", "Your email is blank.")
	Exit
EndIf

; If there is no password in your settings, you get this error and the program closes.
If ($userpass = '') Then
	MsgBox(65584, "TERA Auto Login", "Your password is blank.")
	Exit
EndIf

; This checks if the TERA Launcher is open and then attempts to restore it if it's minimized.
If (WinExists("TERA Launcher")) Then
	WinActivate("TERA Launcher")
	WinWaitActive("TERA Launcher")
EndIf

; This section measures the launcher size (1024x617) just in case it got the wrong window.
If (Not WinExists("[TITLE:TERA Launcher; W:1024; H:617;]")) Then
	MsgBox(65584, "TERA Auto Login", "Can't find the TERA launcher window. Make sure it is open and the login area is already present.")
	Exit
EndIf

; This puts up a question prompt that asks you if you want to continue logging in. (Yes / No)
If (MsgBox(65572,"TERA Auto Login","Do you want to login to TERA?") = 6) Then
	WinActivate("[TITLE:TERA Launcher; W:1024; H:617;]") ; <- This puts the TERA Launcher to the front.
	WinWaitActive("[TITLE:TERA Launcher; W:1024; H:617;]") ; <-'
	$winrect = WinGetPos("[TITLE:TERA Launcher; W:1024; H:617;]") ; <- Gets the TERA Launcher position to properly target things to click.
	MouseClick("left", ($winrect[0]+509), ($winrect[1]+266), 1, 2) ; <- This clicks on the email input box.
	Send("^a") ; <- This selects all text (Ctrl + A) just in case something is in the input box.
	Send($usermail,1) ; <- This types the email you provided.
	MouseClick("left", ($winrect[0]+509), ($winrect[1]+336), 1, 2) ; <- This clicks on the password input box.
	Send("^a") ; <- This selects all text (Ctrl + A) just in case something is in the input box.
	Send($userpass,1) ; <- This types the password you provided.
	MouseClick("left", ($winrect[0]+509), ($winrect[1]+421), 1, 2) ; <- This clicks the login button.
EndIf
