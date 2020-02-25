#######################################  MODIFY AS NEEDED BELOW  ###########################################################################
                    
#Local Account to Modify
$account = "Newbs"

#Remote PC1 ComputerName, Admin Account, Account to modify, Admin Account, Credentials
$RPC1 = "NewbPC"
$RPC1admin = "Boss"
$RPC1pass = "Get-Content C:\Kids-Pass\Creds\RPC1.securestring | ConvertTo-SecureString"
$RPC1account = "Newbs"
                 
#Password List File Name ENSURE IT RESIDES IN CREDS DIRECTORY ($listdir)
$listfile = "pass-list.txt"

#Directory for Creds
$listdir = "C:\Utilities\Kids-Pass\Creds"
                   
#Gmail SMTP Settings
$emailserver = "smtp.gmail.com"
$emailport = "587"
                   
#From & Cc Email Address
$email1 = "bob@gmail.com"
                    
#To Email Address
$email2 = "tom@gmail.com"

#Lock Local System
$xCmdString = {C:\Windows\System32\rundll32.exe user32.dll,LockWorkStation}
                    
#######################################  DO NOT MODIFY BELOW  ###########################################################################
                    
#Date Calculations
$date = Get-Date
$tomorrow = (($date).AddDays(1))
$tomorrowmonth = $tomorrow.Month
                    
#Date Formatting
$weekdaypart = $tomorrow.DayofWeek
$monthpart = $tomorrowmonth | %{(Get-Culture).DateTimeFormat.GetMonthName($_)}
$daypart = $tomorrow.Day
                                    
#Static Variables
$newpassword = Get-Content $listdir\$listfile | Get-Random
$securepass = Get-Content "$listdir\BlitzzXC@gmail.com.securestring" | ConvertTo-SecureString
$emailcreds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $email1,$securepass
                    
#Email Template
$body = "$weekdaypart, $monthpart $daypart - The $account password has been changed to: $newpassword"
$subject = "$account Password Change"
    
#######################################  EXECUTION  ###########################################################################
#Change pass on local system
PowerShell -NoProfile -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile net user $account "$newpassword"' -Verb RunAs}" 
#Change pass on remote system
F:\Utilities\Kids-Pass\Creds\pspasswd64.exe \\$RPC1 -u $RPC1admin -p $RPC1pass -nobanner $RPC1account $newpassword
#Email new pass
Send-MailMessage -From $email1 -To $email2 -Cc $email1 -Credential $emailcreds -SmtpServer $emailserver -Port $emailport -UseSsl -Subject $subject -Body $body   
#reboot remote system... kids get wreked
F:\Utilities\Kids-Pass\Creds\psshutdown.exe -r -u $RPC1admin -p $RPC1pass \\$RPC1
#Sleep for timing
Start-Sleep -Seconds 20
#Lock local system
Invoke-Command $xCmdString
