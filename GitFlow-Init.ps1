<#
    .SYNOPSIS
        Initialize a git-flow controlled repository.
    .DESCRIPTION
        The central repository holds two main branches with an infinite lifetime: 'master' and 'develop'.
        The HEAD of 'origin/master' is considered to be production ready code.
        The HEAD of 'origin/develop' is the features for the next release.
    .NOTES
        This function will initialize a directory as a git repository if necessary. 
    .PARAMETER Directory
        The name of the directory to create the repository in.
    .PARAMETER TemplateDirectory
        The path to the template folder which all files are copied from    
#>
function Init-GitFlow
{
        [CmdletBinding()]
        param (
                [Parameter(
                        Mandatory=$True,
                        ValueFromPipeline=$True,
                        ValueFromPipelineByPropertyName=$True,
                        HelpMessage='In what directory would you like to create the git repository?')]
                [Alias('dir')]
                [string]$Directory,
                [Parameter(
                        Mandatory=$False,
                        HelpMessage='Where is your template git dir located?')]
                [Alias('templateDir')]
                [string]$TemplateDirectory
        )

    PROCESS
    {
        if(!(Test-Path ($Directory + "\.git")))
        {
            # Use default if no folder is given
            if ([string]::IsNullOrEmpty($TemplateDirectory))
            {
                $TemplateDirectory = "Template:\Git"
            }
            
            Write-host "Using " $TemplateDirectory " as template directory"
            New-Repository -Directory $Directory -TemplateDirectory $TemplateDirectory
            
            # Tag first version
            git tag 0.0.0
        }

        # Create develop branch
        git checkout -b develop master
    }
}
