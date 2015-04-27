<#
    .SYNOPSIS
    Start a new release branch from the 'develop' branch.
    
    .DESCRIPTION
    Release branches support preparation of a new production release (minor bug fixes, preparing metadata, etc). By 
    doing all of this in a release branch, the 'develop' branch is clear to receive features for the next release. 
    
    .PARAMETER version
    The version of the release to start.
#>
function Start-Release 
{ 
    [CmdletBinding()]
    PARAM(
        [Parameter(
                Mandatory=$True,
                ValueFromPipeline=$True,
                ValueFromPipelineByPropertyName=$True,
                HelpMessage='Which version are you creating a release for?')]
        [Alias('v')]
        [string]$version
    )
    
    PROCESS 
    {
        $releaseBranch = "release-{0}" -f $version   
        git checkout -b $releaseBranch develop
    }
}