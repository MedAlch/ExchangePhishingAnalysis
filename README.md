# ExchangePhishingAnalysis
A simple set of tools to investigate phishing incidents through Exchange using Powershell.

At the moment the only tool available is ExchangePhishingAnalysis.ps1, aiming to provide a quick way to get a report of all the targets of a phishing campaign without using the HORRIBLE, VERY SLOW, HORRENDOUS Exchange interface.

The script is still in building phase and lacks a lot of documentation. I'll be back.

ExchangePhishingAnalysis.ps1 requires and administrative account on your Exchange tenant, as well as the Exchange Online Powershell module. See here how to install it : https://365tips.be/fr/installez-le-nouveau-module-exchange-online-powershell-v2/


![image](https://user-images.githubusercontent.com/39335291/137759835-f34e7de3-d90e-415d-8986-7ded1ff73a79.png)

## Usage :
**Get a view of what is currently blacklisted** 

`.\ExchangePhishingAnalysis.ps1 -Action Review`
 
**Analyze all mails sent by a specific sender (within last 10 days at most)**

`.\ExchangePhishingAnalysis.ps1 -Action Analyze -Target test@email.com -StartDate MM/dd/yyyy -EndDate MM/dd/yyyy`
 
**Analyze all mails sent by the whole domain (within last 10 days at most)**

`.\ExchangePhishingAnalysis.ps1 -Action Analyze -Target \*@email.com -StartDate MM/dd/yyyy -EndDate MM/dd/yyyy`
 
**Blacklist a specific sender**

`.\ExchangePhishingAnalysis.ps1 -Action BlockSender -Target test@email.com`
 
**Blacklist a whole domain**

`.\ExchangePhishingAnalysis.ps1 -Action BlockDomain -Target \*@email.com`
 
**Remove from blacklist a specific sender**

`.\ExchangePhishingAnalysis.ps1 -Action AllowSender -Target test@email.com`
 
**Remove from blacklist a whole domain**

`.\ExchangePhishingAnalysis.ps1 -Action AllowDomaun -Target \*@email.com`
