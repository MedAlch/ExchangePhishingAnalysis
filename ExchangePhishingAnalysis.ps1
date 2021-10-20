param (
    [Parameter(Mandatory = $true)][string]$Action,
    [string]$Target,
    [boolean]$BlockSender,
    [boolean]$BlockSenderDomain,
    [DateTime]$StartDate,
    [DateTime]$EndDate
)

function ValidateEmail($address) {
     $address -match "^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
}

function PrintReview() {
    Write-Host "###############################################"
    Write-Host "#     Recap of formerly blocked senders       #"
    Write-Host "###############################################"
    Get-HostedContentFilterPolicy Default| Format-List -Property BlockedSenders

    Write-Host "###############################################"
    Write-Host "#     Recap of formerly blocked domains       #"
    Write-Host "###############################################"
    Get-HostedContentFilterPolicy Default| Format-List -Property BlockedSenderDomains
}

function SetDate() {
    $StartDate = [Datetime]::ParseExact($StartDate, 'dd/MM/yyyy', [GlobalizationCultureInfo]::CreateSpecificCulture('fr-FR'))
    $EndDate = [Datetime]::ParseExact($EndDate, 'dd/MM/yyyy', [Globalization.CultureInfo]::CreateSpecificCulture('fr-FR'))
}

Get-PSSession | Remove-PSSession
Connect-ExchangeOnline


if ($Action -eq "Analyze") {
    #SetDate

    Write-Host "###############################################"
    Write-Host "#      Fetching information for target        #"
    Write-Host "###############################################"
    Get-MessageTrace -SenderAddress $Target -StartDate $StartDate -EndDate $EndDate

    Write-Host "`r`n If this field is empty, this means no mail information has been retrieved with the following e-mail. Are you sure you are using the good tenant ? `r`n"

} 
Elseif ($Action -eq "Review") {
    PrintReview
} Elseif ($Action -eq "BlockSender") {
    Set-HostedContentFilterPolicy default -BlockedSenders @{add=$Target}
} Elseif ($Action -eq "BlockDomain") {
    Set-HostedContentFilterPolicy default -BlockedSenderDomains @{add=$Target}
} Elseif ($Action -eq "AllowSender") {
    Set-HostedContentFilterPolicy default -BlockedSenders @{remove=$Target}
} Elseif ($Action -eq "AllowDomain") {
    Set-HostedContentFilterPolicy default -BlockedSenderDomains @{remove=$Target}
}
