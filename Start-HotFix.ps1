<#
    .SYNOPSIS
    Start a new hot fix branch from the 'master' branch.

    .DESCRIPTION
    Hot fix branches are used to fix bugs in the master/ production branch.

    .PARAMETER name
    The name of the issue to start/ fix.
#>
function Start-HotFix
{
    [CmdletBinding()]
    PARAM(
        [Parameter(
                Mandatory=$True,
                ValueFromPipeline=$True,
                ValueFromPipelineByPropertyName=$True,
                HelpMessage='What is the name of your hot fix?')]
        [Alias('issue')]
        [string]$name
    )

    PROCESS
    {
        # Format name of branch
        $name = $name -replace " ","."
        $hotFixBranch = "hotfix/{0}" -f $name

        # create hot fix branch
        git checkout -b $hotFixBranch master
    }
}
