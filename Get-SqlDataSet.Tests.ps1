Describe 'Get-SqlDataSet.Tests' {
    It 'passes default PSScriptAnalyzer rules' {
        $ModuleScriptPath = "$($PSCommandPath.Substring(0, $PSCommandPath.IndexOf('.'))).ps1"
        Invoke-ScriptAnalyzer -Path $ModuleScriptPath | Should -BeNullOrEmpty
    }
    It 'passes no params' {
        $ModuleScriptPath = "$($PSCommandPath.Substring(0, $PSCommandPath.IndexOf('.'))).ps1"
        $results = (. $ModuleScriptPath -Verbose) 
        $results | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error* but found: $results'
        $? | Should -Be $true
        #$results | Format-Table | Out-String -Stream
        for ($i = 0; $i -lt $results.Tables.Count; $i++) { $results.Tables[$i] | Format-Table | Out-Host }
    }
}
