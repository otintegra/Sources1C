path = "\\WIN2008R2AD1\d$\Archiv\1C"
'' Удалять в подкаталогах
bIncludeSubFolders = 0
''Даты
killdate_1 = date() - 183
killdate_2 = date() - 92
killdate_3 = date() - 30


Dim date_d_1 (1)
Dim date_d_2 (3)
Dim date_d_3 (6)

date_d_1(0) = 1

date_d_2(0) = 1
date_d_2(1) = 10
date_d_2(2) = 20

date_d_3(0) = 1
date_d_3(1) = 5
date_d_3(2) = 10
date_d_3(3) = 15
date_d_3(4) = 20
date_d_3(5) = 25

arFiles = Array()



set fso = createobject("scripting.filesystemobject")

Set f1 = fso.CreateTextFile(path + "\протокол.txt", True)

SelectFiles path, killdate_1, killdate_2, killdate_3, arFiles, bIncludeSubFolders, date_d_1, date_d_2, date_d_3, f1 
for n = 0 to ubound(arFiles)
	on error resume next

	arFiles(n).delete true



	if err.number <> 0 then
		wscript.echo "Unable to delete: " & arFiles(n).path
	else
		nDeleted = nDeleted + 1
	end if
	on error goto 0
next

f1.Close
Set fso = Nothing 

sub SelectFiles(sPath, vKillDate_1, vKillDate_2, vKillDate_3, arFilesToKill, bIncludeSubFolders, date_d_1, date_d_2, date_d_3, f1 )
	on error resume next
	set folder = fso.getfolder(sPath)
	set files = folder.files

	for each file in files
		dtlastmodified = null
		on error resume Next
		dtdatecreated = file.DateLastModified
		dtnday = day(dtdatecreated)
		on error goto 0
		if not isnull(dtdatecreated) then



			if (dtdatecreated < vKillDate_3 and (dtnday <> date_d_3(0) and dtnday <> date_d_3(1) and dtnday <> date_d_3(2) and dtnday <> date_d_3(3) and dtnday <> date_d_3(4) and dtnday <> date_d_3(5)))	or (dtdatecreated < vKillDate_2 and (dtnday <> date_d_2(0) and dtnday <> date_d_2(1) and dtnday <> date_d_2(2)))  or (dtdatecreated < vKillDate_1 and	(dtnday <> date_d_1(0)))  then
				count = ubound(arFilesToKill) + 1
				redim preserve arFilesToKill(count)
				set arFilesToKill(count) = file
	f1.WriteLine( dtdatecreated  & " - удален")
			Else
	f1.WriteLine( dtdatecreated   )
			end if



		end if
	next

	if bIncludeSubFolders then
		for each fldr in folder.subfolders
			SelectFiles path, killdate_1, killdate_2, killdate_3, arFiles, truenDeleted = 0, date_d_1, date_d_2, date_d_3
		next
	end if
end sub
