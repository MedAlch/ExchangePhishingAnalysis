function ValidateEmail($address)
{
     $address -match "^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
}

function ValidateDate($date)
{
     $date -match "(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)[0-9]{2}"
}

$suspicious_email = $args[0]
$suspicious_domain = $suspicious_email.Substring($suspicious_email.IndexOf('@')+1)
$start_date = $args[1]
$end_date = $args[2]
$forceFlushPSSession = $args[3]


if (-Not (ValidateEmail($suspicious_email))) {
    Write-Host "Improper e-mail. Usage : ./ExchangePhishingAnalysis.ps1 test@contoso.com START_DATE END_DATE Flush_PSSession(True/False)"
    Exit
}
if (-Not (ValidateDate($start_date) -Or ValidateDate($end_date))) {
    Write-Host "Improper dates. Usage : ./ExchangePhishingAnalysis.ps1 test@contoso.com START_DATE END_DATE  Flush_PSSession(True/False) (Please us DD/MM/YYYY format. Maximum only 10 days old.)"
    Exit    
}

if ($forceFlushPSSession) { Get-PSSession | Remove-PSSession }

Connect-ExchangeOnline

Write-Host "###############################################"
Write-Host "#    Fetching information for exact address   #"
Write-Host "###############################################"
Get-MessageTrace -SenderAddress $suspicious_email -StartDate $start_date -EndDate $end_date



#Write-Host "###############################################"
#Write-Host "#    Fetching information for whole domain    #"
#Write-Host "###############################################"
#Get-MessageTrace -SenderAddress "*@$($suspicious_domain)" -StartDate 10/14/2021 -EndDate 10/18/2021