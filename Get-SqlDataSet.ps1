#Set-StrictMode -Version Latest
#####################################################
# Get-SqlDataSet
#####################################################
<#PSScriptInfo

.VERSION 0.1

.GUID 602bc07e-a621-4738-8c27-0edf4a4cea8e

.AUTHOR David Walker, Sitecore Dave, Radical Dave

.COMPANYNAME David Walker, Sitecore Dave, Radical Dave

.COPYRIGHT David Walker, Sitecore Dave, Radical Dave

.TAGS sitecore powershell local install iis solr

.LICENSEURI https://github.com/SitecoreDave/SharedSitecore.SitecoreLocal/blob/main/LICENSE

.PROJECTURI https://github.com/SitecoreDave/SharedSitecore.SitecoreLocal

.ICONURI

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES
Additional details:
https://stackoverflow.com/questions/13974676/why-does-powershell-think-im-trying-to-return-an-object-rather-then-a-datatab

for ($i = 0; $i -lt $dataset.Tables.Count; $i++) { $dataset.Tables[$i] | Format-Table | Out-Host }

#>

<#
.SYNOPSIS
Get-SqlDataSet All The Things!

.DESCRIPTION
PowerShell script that helps you Automate All The Things!

.EXAMPLE
PS> Get-SqlDataSet 'name'

PS> Get-SqlDataSet az armtemplate.json

.EXAMPLE
PS> Get-SqlDataSet 'name' 'template'

.EXAMPLE
PS> Get-SqlDataSet 'name' 'template' 'd:\repos'

.Link
https://github.com/Radical-Dave/Get-SqlDataSet

.OUTPUTS
    System.String
#>
[CmdletBinding(SupportsShouldProcess=$true)]
Param(
	[Parameter(Mandatory = $false, Position=0)]
	[string] $query = 'SELECT @@version',
	[Parameter(Mandatory = $false, Position=1)]
	[string] $connectionstring = 'Data Source=.;Initial Catalog=master;Integrated Security=SSPI;'
)
begin {
	$PSScriptName = ($MyInvocation.MyCommand.Name.Replace(".ps1",""))
	$PSScriptVersion = (Test-ScriptFileInfo -Path $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty Version)
	$PSCallingScript = if ($MyInvocation.PSCommandPath) { $MyInvocation.PSCommandPath | Split-Path -Parent } else { $null }
	Write-Verbose "#####################################################"
	Write-Verbose "# $PSScriptRoot/$PSScriptName $($PSScriptVersion):$query $connectionstring called by:$PSCallingScript"
}
process {
	try {
		if($PSCmdlet.ShouldProcess($query)) {
			$conn = New-Object System.Data.SqlClient.SqlConnection $connectionstring
			$dc = New-Object System.Data.SqlClient.SqlCommand
			$dc.CommandText = $query
			$dc.Connection = $conn
			$dc.CommandTimeout = 300 | Out-Null
			$conn.Open();
			#$datatable = New-Object System.Data.DataTable
			$da = New-Object System.Data.SqlClient.SqlDataAdapter
			$da.SelectCommand = $dc
			$da.SelectCommand.CommandTimeout = 300
			$dataset = New-Object System.Data.DataSet
			$null = $da.Fill($dataset)
			$results = $dataset
		}
	}
	finally {
		$null = $conn.Close();
		$null = $conn.Dispose();
		$null = $da.Dispose()
	}	
}
end {
	return ,$results
}