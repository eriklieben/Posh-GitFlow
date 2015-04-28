<#
    .SYNOPSIS
    Merge a hot fix branch with 'master' and 'develop' and delete the hot fix branch.

    .DESCRIPTION
    Hot fix branch is merged back into master and develop.

    .PARAMETER name
    The name of the hot fix to finish. If not given,
    use name of current branch and check if it is a hot fix branch.

#>
function Finish-HotFix
{
    PARAM(
        [Parameter(
                Mandatory=$False,
                HelpMessage='The name of the hot fix to finish?')]
        [string]$name
    )

    PROCESS
    {
        # Check if hot fix name is given, otherwise take current
        if ([string]::IsNullOrEmpty($name))
        {
            $hotFixBranch = (git rev-parse --abbrev-ref HEAD)
        }
        else
        {
            $name = $name -replace " ","."
            $hotFixBranch = "hotfix/{0}" -f $name
        }

        # Only process hot fix branches
        if ($hotFixBranch -like "hotfix/*")
        {
            # Master branch
            git checkout master
            git merge --no-ff $hotFixBranch

            # TODO: git tag -a 1.2.1 / tag version

            # Develop branch
            git checkout develop
            git merge --no-ff $hotFixBranch

            # TODO: check if Release exists? then merge also in that

            git branch -d $hotFixBranch
        }
    }
}
