# Get-SqlDataSet

PowerShell Script helper to Get System.Data.DataSet from query and ConnectionString

PS> Install-Script Get-SqlDataSet

Examples:
PS> Get-SqlDataSet (-help) - help

PS> Get-SqlDataSet az armtemplate\path.json

PS> Get-SqlDataSet name.json

.EXAMPLE
PS> Get-SqlDataSet 'name' 'template'

.EXAMPLE
PS> Get-SqlDataSet 'name' 'template' 'd:\repos'
