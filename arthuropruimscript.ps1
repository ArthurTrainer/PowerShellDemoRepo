#$folder = "$env:USERPROFILE\Downloads"
$folder="C:\users\ArthurGoudswaard(4kn\downloadtest"
$minutengewonefiles=1
$minutenpdf=2
#$days = 30


Get-ChildItem $folder -File |
Where-Object { ($_.LastWriteTime -lt (Get-Date).AddMinutes(-$minutengewonefiles)) -and -not ($_.FullName -like "*.pdf") } |
Remove-Item -Force

Get-ChildItem $folder -File |
Where-Object { $_.LastWriteTime -lt (Get-Date).AddMinutes(-$minutenpdf) -and $_.FullName -like "*.pdf" } |
Remove-Item -Force