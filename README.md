# Get-SqlDataSet
## Description
PowerShell Script helper to Get System.Data.DataSet from query and ConnectionString

## Installation (Powered by [PowerShellGallery](https://powershellgallery.com/packages/Get-SqlDataSet))
PS> Install-Script Get-SqlDataSet

## Example
PS> Get-SqlDataSet (-help) - help

PS> Get-SqlDataSet az armtemplate\path.json

PS> Get-SqlDataSet name.json

PS> Get-SqlDataSet 'name' 'template'

PS> Get-SqlDataSet 'name' 'template' 'd:\repos'

## Example output results
for ($i = 0; $i -lt $dataset.Tables.Count; $i++) { $dataset.Tables[$i] | Format-Table | Out-Host }

## Copyright
David Walker, Radical Dave, Sitecore Dave
MIT License: https://github.com/Radical-Dave/Get-SqlDataSet/blob/main/LICENSE
