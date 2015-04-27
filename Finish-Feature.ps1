<#
    .SYNOPSIS
    Merge a feature branch with 'develop' and delete the feature branch.
    
    .DESCRIPTION
    Finished features will be merged back into the 'develop' branch and pushed to the 'origin/develop'. 
    The feature branch will then be deleted. This function uses '--no-ff' by default (look it up!).
    
    .PARAMETER name
    The name of the feature to finish. If not given, 
    use name of current branch and check if it is a feature branch.
    
#>
function Finish-Feature 
{
    PARAM(
        [Parameter(
                Mandatory=$False,
                HelpMessage='The name of the feature to finish?')]
        [string]$name
    )
    
    PROCESS 
    {
        # Check if feature name is given, otherwise take current    
        if ([string]::IsNullOrEmpty($name))
        {
            $featureBranch = (git rev-parse --abbrev-ref HEAD)
        } 
        else 
        {
            $name = $name -replace " ","."
            $featureBranch = "feature/{0}" -f $name
        }

        # Only process feature branches
        if ($featureBranch -like "feature/*") 
        {
            git checkout develop
            git merge --no-ff $featureBranch
            git branch -d $featureBranch
        }
    }
}