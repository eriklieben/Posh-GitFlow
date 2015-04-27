<#
    .SYNOPSIS
    Merge a release branch with 'develop' and 'master' and delete the release branch.
    .DESCRIPTION
    When the release branch is ready to become a real release, it is merged with 'master' and 'master' is tagged with 
    the version number. The branch is also merged with 'develop'. The release is done, so the branch is deleted.   
    .PARAMETER version
    The version of the release to finish.
#>
function Finish-Release 
{
    param(
            [Parameter(
            Mandatory=$False,
            HelpMessage='The version of the release branch to finish')]
            [string]$version
    )
    
    PROCESS 
    {
        if ([string]::IsNullOrEmpty($version))
        {
            $releaseBranch = (git rev-parse --abbrev-ref HEAD)
        } 
        else 
        {
            $releaseBranch = "release-{0}" -f $name
        }

        if ($releaseBranch -like "release-*") 
        {
            # Update master branch with latest changes
            git checkout master
            git merge --no-ff $releaseBranch    
            git tag -a -m "released $version" ($releaseBranch -replace "release-", "")

            # Update the develop branch with the latest changes
            git checkout develop
            git merge --no-ff $releaseBranch
            git branch -d $releaseBranch        
        }
    }
}