FILE STRUCTURE =         [PARENT FOLDER] "Kids-Pass"         [CHILD FOLDER] "Creds"
                                "Kids Reset.ps1"                 ALL OTHER FILES


Run the following to create .securestring credential file:

-Open PowerShell as Admin
-Change directory to ~Kids-Pass\Creds\
-Enter "Read-Host -AsSecureString | ConvertFrom-SecureString | Out-File -FilePath bob@gmail.com.securestring"
[ENTER PASSWORD] (will be masked as *'s)

DO THIS FOR EVERY REQUIRED CREDENTIAL (email, local pc's, remote pc's, etc..)
