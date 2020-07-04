@echo off

ver | find "5.1." && set win_XP=yes
ver | find "6.1." && set win_7=yes

if defined win_XP (
	echo WinXP
	rmdir /S /Q "%userprofile%\Local Settings\Application Data\1C\1Cv82”
	rmdir /S /Q "%userprofile%\Application Data\1C\1Cv82”
	rmdir /S /Q "%userprofile%\Local Settings\Application Data\1C\1Cv8”
	rmdir /S /Q "%userprofile%\Application Data\1C\1Cv8”
) else (
	echo Win 7,10
	rmdir /S /Q  "%USERPROFILE%\AppData\Local\1C\1Cv82"
	rmdir /S /Q "%USERPROFILE%\AppData\Roaming\1C\1Cv82"
	rmdir /S /Q "%USERPROFILE%\AppData\Local\1C\1Cv8"
	rmdir /S /Q "%USERPROFILE%\AppData\Roaming\1C\1Cv8"
)
pause
