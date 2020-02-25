FILE STRUCTURE =         [PARENT FOLDER] "Kids-Pass"         [CHILD FOLDER] "Creds"
                                "Kids Reset.ps1"                 ALL OTHER FILES


Run the following to create .securestring credential file:

-Open PowerShell as Admin
-Change directory to ~Kids-Pass\Creds\
-Enter "Read-Host -AsSecureString | ConvertFrom-SecureString | Out-File -FilePath bob@gmail.com.securestring"
[ENTER PASSWORD] (will be masked as *'s)

DO THIS FOR EVERY REQUIRED CREDENTIAL (email, local pc's, remote pc's, etc..)

or if you don't care about security... put your passwords as plaintext... may the odds ever be in your favor
