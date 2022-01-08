Describe 'Get-SqlDataSet.Sql.Tests' {
    It 'passes sql smoke test' {
        $ModuleScriptPath = "$($PSCommandPath.Substring(0, $PSCommandPath.IndexOf('.'))).ps1"
        $results = . $ModuleScriptPath
        $results | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error* but found: $results'
        $? | Should -Be $true
        for ($i = 0; $i -lt $results.Tables.Count; $i++) { $results.Tables[$i] | Format-Table | Out-Host }
        #Write-Host $results | Out-GridView
        #Write-Verbose $results | Format-Table | Out-String -Stream
    }
    It 'passes sql list databases test' {
        $ModuleScriptPath = "$($PSCommandPath.Substring(0, $PSCommandPath.IndexOf('.'))).ps1"
        $results = (. $ModuleScriptPath 'SELECT * FROM SYS.databases' -Verbose) 
        $results | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error* but found: $results'
        $? | Should -Be $true
        #$results | Format-Table | Out-String -Stream
        for ($i = 0; $i -lt $results.Tables.Count; $i++) { $results.Tables[$i] | Format-Table | Out-Host }
        Write-Host $results.GetType()
    }
}
