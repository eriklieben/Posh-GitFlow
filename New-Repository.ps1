function New-Repository {
        <#
        .SYNOPSIS
                Creates a git repository in the given folder with an optional template
        .DESCRIPTION
                Create script to create a git repository and auto init with template
        .EXAMPLE
                New-Repository -Directory "Repository1" -TemplateDirectory Template:\Git
        .PARAMETER Directory
                The name of the directory to create the repository in.
        .PARAMETER TemplateDirectory
                The path to the template folder which all files are copied from
        #>
 
        [CmdletBinding()]
        PARAM (
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
                # Init Git Repostory
                git init $Directory
                cd $Directory
                $Directory = $(get-location).Path

                # Copy Template over to directory
                if (![string]::IsNullOrEmpty($TemplateDirectory)) 
                {
                        $TemplateDirectory = (Get-Item $TemplateDirectory).FullName
                        RoboCopy $TemplateDirectory $Directory /E

                        git add -A
                        git commit -m "Initial commit"
                }
        }
}