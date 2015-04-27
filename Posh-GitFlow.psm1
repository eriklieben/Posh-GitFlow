Push-Location $psScriptRoot

. .\New-Repository.ps1
. .\GitFlow-Init.ps1
. .\Start-Feature.ps1
. .\Finish-Feature.ps1
. .\Start-Release.ps1
. .\Finish-Release.ps1
. .\Git-Alias.ps1

Pop-Location

Export-ModuleMember -Alias @('sf','ff', 'sr', 'fr') -Function @('Init-GitFlow', 'Start-Feature', 'Start-Release', 'Finish-Feature', 'Finish-Release')


