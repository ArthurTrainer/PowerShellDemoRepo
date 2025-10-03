#M7 Scripting (.PS1) (Reporting) (Functions)

Find-Module 'msonline'
Find-Module  'AzureAD'

Find-module 'azure*'
Find-module 'Sharepoint*'

Find-Module  AzureAD
Update-Module AzureAD
Import-Module AzureAD
Get-Module -ListAvailable
Get-module -all


Get-PSRepository 

#cert signing explain gaat in lab gebeuren
$cert = New-SelfSignedCertificate -KeyUsage DigitalSignature -KeySpec `
 Signature -KeyAlgorithm RSA -KeyLength 2048 -DNSName "Arthur's Code Signing Demo " `
 -CertStoreLocation Cert:\CurrentUser\My -Type CodeSigningCert -Subject "AZ-104 code signing demo class"

Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert
$cert = Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert| where {$_.Thumbprint -eq '610E22E325361DF252FF40408C06C69E5816A108'}
Set-AuthenticodeSignature -FilePath vandaag2.ps1 -Certificate $cert

Set-ExecutionPolicy Unrestricted


#If -- ElseIf -- Else
$freespace=3GB
$freespace.getType()

If ($freeSpace -le 5GB) {
     Write-Host "Free disk space is less than 5 GB"
} ElseIf ($freeSpace -le 10GB) {
     Write-Host "Free disk space is less than 10 GB"
} Else {
     Write-Host "Free disk space is more than 10 GB"
}

#For
For($teller=1; $teller -le 10; $teller++) {
     Write-Host "Create something $teller"
}
#Alternatief voor For
1..9 | ForEach-Object {Write-Host $_}


#Tests IF ELSE -- Switch

#Switch


$choice='1'
$choice=Read-host

Switch ($choice) {
     1 { Write-Host "You selected menu item 1" }
     2 { Write-Host "You selected menu item 2" }
     3 { Write-Host "You selected menu item 3" }
     Default { Write-Host "You did not select a valid option" }
}


$choice='jaap'

Switch ($choice) {
     jaap { Write-Host "You selected menu item $choice" }
     truus { Write-Host "You selected menu item $choice" }
     petra { Write-Host "You selected menu item $choice" }
     Default { Write-Host "You did not select a valid option" }
}


#loops -- ForEach -- Foreach-object -- For -- Do While -- Do Until -- While

$users=@('reef','jay','Administrator','jaap')
ForEach ($user in $users) {
     Set-ADUser $user -Department "Marketing"
}

#{continue}  continue is verder gaan en de actie skippen -- dus gaat met jaap verder
ForEach ($user in $users) {
     If ($user -eq "Administrator") {Continue}
     Write-Host "Modify user object --> $user" 
}

#number is extra lus en deze testen --> beide lussen verlaten is {break}
$max=3
$number=0
ForEach ($user in $users) {
     $number++
     Write-Host "Modify User object $number $user"
     If ($number -ge $max) {Break}
}



$answer="go"
Do {
    Write-Host 'do someting'
} While ($answer -eq "go")

Do {
     Write-Host 'do someting'
} Until ($answer -eq "stop")

While ($answer -eq "go") {
write-host 'eerste de test dan de actie'

}


#import

Import-Csv "C:\Users\Administrator\Desktop\import-csv.txt" | Foreach {New-aduser -Name $_.Name -Givenname $_.demonaam `
 -UserPrincipalname $_.UserPrincipalName -Title $_.Title `
 -AccountPassword (ConvertTo-Securestring $_.AccountPassword -AsPlainText -Force) -Enabled $true} 

#maak in notepad deze CSV aan
Name,demonaam,UserPrincipalName,Title,AccountPassword
Docent,Docent,Docent@adatum.com,cursist,123St@rt
User01,User01,User01@adatum.com,cursist,123St@rt
User02,User02,User02@adatum.com,cursist,123St@rt
User03,User03,User03@adatum.com,cursist,123St@rt
User04,User04,User04@adatum.com,cursist,123St@rt
User05,User05,User05@adatum.com,cursist,123St@rt
User06,User06,User06@adatum.com,cursist,123St@rt
User07,User07,User07@adatum.com,cursist,123St@rt
User08,User08,User08@adatum.com,cursist,123St@rt
User09,User09,User09@adatum.com,cursist,123St@rt

$content = 'Name,demonaam,UserPrincipalName,Title,AccountPassword
Docent,Docent,Docent@adatum.com,cursist,123St@rt
User01,User01,User01@adatum.com,cursist,123St@rt
User02,User02,User02@adatum.com,cursist,123St@rt
User03,User03,User03@adatum.com,cursist,123St@rt
User04,User04,User04@adatum.com,cursist,123St@rt
User05,User05,User05@adatum.com,cursist,123St@rt
User06,User06,User06@adatum.com,cursist,123St@rt
User07,User07,User07@adatum.com,cursist,123St@rt
User08,User08,User08@adatum.com,cursist,123St@rt
User09,User09,User09@adatum.com,cursist,123St@rt' | out-file -filepath .\testfile1.csv

notepad .\testfile1.csv

Import-Csv .\testfile1.csv | foreach ($_.Name) { Write-Output $_.Name}

#rapportage
#voeg eerst een Sales user toe!!
#Get-AdUser -Identity 'administrator' | Set-Aduser -Country 'NL'

$UserReport = "C:\Users\Administrator\Desktop\SalesUsers.CSV"
$STR = "User Name, Department, Distinguished Name"
Add-Content $UserReport $STR
$AllUsers = Get-ADUser -Filter * -Properties Department, DistinguishedName -SearchBase "CN=Users, DC=Adatum, DC=Com"
ForEach ($ThisUser in $AllUsers)
{
IF ($ThisUser.Department -eq "Sales")
{
$STR = $ThisUser.CN+",Sales,"+$ThisUser.DistinguishedName
Add-Content $UserReport $STR
}
}

#komt voor in het lab met genereren password …..is ASCII tabel
$l=97
$letter=[char]$l
$letter


#M7 vervolg Advanced Scripting (Debug, Error handling)

#noem deze myscript.ps1

$passwordlength=8
$password=$null

For($t=1;$t -le $passwordlength;$t++){
    #65 is hoofdletter A, 97 is kleine letter a
    $number= Get-Random -Maximum 120 -Minimum 65
    $letter= [char]$number
    $password += $letter
    #Write-Host $password 
    #Read-Host
  # Write-Host "u bent op regel 21 van het script"
   #Start-Sleep 6
#debug is veel makkelijker!!!
}
write-host "The password is : "$password

#----einde myscript.ps1


get-help Write-Verbose -Online

#laat niets zien $VerbosePreference staat op SilentlyContinue
Write-Verbose -Message "Searching the Application Event Log."

$VerbosePreference

#laat het altijd zien ongeacht $VerbosePreference
Write-Verbose -Message "Searching the Application Event Log." -Verbose

$VerbosePreference = "Continue"
$VerbosePreference = "SilentlyContinue"




Restart-Service RemoteFXbestaatnietservice
#is het array waar de error(s) in zitten
#$Error
$Error[0]
Restart-Service RemoteFXbestaatnietservice2
#nieuwe foutmelding
$Error[0]
#oude foutmelding
$Error[1]

#fijne commando's in het script
Start-Sleep 6
Write-Host "u bent op regel 21 van het script"

#volgende 3 regels tegelijk uitvoeren en met enter verder Read-Host is een soort pauze
Get-PSdrive
Read-Host 
Get-Service

#breakpoints F10 over, F11 into Shift + F11 cancel
Set-PSBreakPoint -Line 2 -Script "MyScript.ps1"
Set-PSBreakPoint -Command "Get-PSDrive" -Script "MyScript.ps1"
Set-PSBreakPoint -Variable "computert" -Mode ReadWrite -Script "MyScript.ps1"

.\myscript.ps1

Get-Command *breakpoint

Get-PSBreakpoint

Remove-PSBreakpoint -Line 2 -Script "MyScript.ps1"

#defines what happens for non-terminating errors:Continue, SilentlyContinue, Inquire, Stop

# is global
$ErrorActionPreference 
$ErrorActionPreference = "Stop"

#per command -- plak deze in een ps1 op eigen computer -- lon-svr1 en dc1 bestaan niet, dus foutmelding
#kopieer deze in myscript.ps1
Get-WmiObject -Class Win32_BIOS -ComputerName LON-DC1 -ErrorAction Stop
Get-WmiObject -Class Win32_BIOS -ComputerName LON-DC1 -ErrorAction Continue

#TRY CATCH FINALLY
try
{
    # Try something that could cause an error
    1/0
}
catch
{
    # Catch any error
    Write-Host "An heel erg error occurred"
}
finally
{
    # [Optional] Run this part always
    Write-Host "cleaning up ..."
}

# To show your default error action type
$ErrorActionPreference
$ErrorActionPreference = "continue"
$ErrorActionPreference = "Stop"

try {
    dir "c:\some\non-existing\path"
    
}
catch {
    Write-host "Directory does not exist"
}




$comp='Arthur-pc'
$comp='bestaatniet'

Get-WmiObject –Class Win32_BIOS –ComputerName $comp 
$ErrorActionPreference = "Stop"
#kan ook in try block Get-WmiObject –Class Win32_BIOS –ComputerName $comp -ErrorAction Stop

Try 
{
Get-WmiObject –Class Win32_BIOS –ComputerName $comp 
 } 
Catch
 {
Write-Host "Error connecting to $comp" -ForegroundColor yellow
}
 Finally 
{
Write-Host "Bios WMI query for $comp is complete" -ForegroundColor yellow
}


$file='tryandcatchdemofile.txt'
New-Item $file
$file='c:\folderbestaatniet\tryandcatchdemofile.txt'
New-Item $file

Try {
New-Item $file
} Catch [System.IO.DirectoryNotFoundException] {
Write-Host "path niet gevonden"
#optionele code om bv de foler te maken.
#optionele code om dan alsnog de file te maken.
} Catch [System.IO.IOException] {
Write-Host "de file bestaat al"
} Catch {
Write-Host "An unknown error occurred"
}

Try {dir c:\tmpddd -ErrorAction Stop}
Catch [System.Management.Automation.ItemNotFoundException] {"Caught the exception!!"}
Finally {$error.Clear() ; "errors cleared"}



#Find the specific error type by using:
$Error[0].Exception
$Error[0].Exception.GetType().Fullname


#functions
#elevated priv nodig --run as admin
Get-EventLog -LogName Security -Newest 10

Function Get-ArthurSecurityEvent {
Param (
[string]$naamcomputert
) #end Param
Get-EventLog -LogName Security -ComputerName $naamcomputert -Newest 10
}


Get-ArthurSecurityEvent -naamcomputert acert



#Advanced Scripting nog steeds vervolg
#functions demo Green -and Red

function Green
{
    process { Write-Host $_ -ForegroundColor Green }
}
function Red
{
    process { Write-Host $_ -ForegroundColor Red }
}
Write-Output "this is a test" | Green
Write-Output "this is a test" | Red

#bewaar als psm1
function Green
{
    process { Write-Host "Greeeeeen" -ForegroundColor Green }
}
function Red
{
    process { Write-Host "Reeeed" -ForegroundColor Red }
}

Set-Alias Groen Green
Set-Alias Rood Red
Export-ModuleMember -Function Green -Alias groen
Export-ModuleMember -Function Red -Alias rood


Import-Module .\mymodule.psm1
cd $HOME
green
groen

Get-Command *module

Remove-Module mymodule

Get-Module


#deze laden in de sessie -- ook remote
Import-module e:\mijnmodule.psm1

#parameters -- maak demo.ps1 file

param([Int32]$step=30,[Int32]$stepp=30)
write-host $step

$stap=Read-Host

.\demo.ps1 -step 21 -stepp 22


Param (
[string]$naamcomputer=(Read-Host 'geef computernaam'),
#switch data type en is false als je niets meegeeft
[switch]$alternatecred,
#true or false
[Bool]$alternatievecred
) #end Param



#uitleg scope variable

#diff scopes
$x=1
& {$x=2;write-host 'in het scriptblok is het ' $x}
write-host 'buiten het scriptblok is het' $x

#same scope
$x=1 
.{$x=2;write-host 'in het scriptblok is het ' $x}
write-host 'buiten het scriptblok is het' $x

#same scope
invoke-expression ' $i=5; echo $i '

#same scope
.\$PSScriptRoot\myscipt.ps1

#diff scope
& $PSScriptRoot\myscript.ps1


#&  
#The call operator (&) allows you to execute a command, script or function.
#https://ss64.com/ps/call.html




$global:a = 'foo'

$global:a

$script:a = 'foo_script'

$a

Set-Variable -Name a -Value 'Hello world!' -Option AllScope

Get-Variable



#autoload psm1
#Zie autoload psm1 page
