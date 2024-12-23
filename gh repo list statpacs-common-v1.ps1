function getCommitInfo([String] $orgName, [String] $repoName, [string] $commitSha){
#$stuff = gh api /repos/statpacs-common/dicom/commits/b77b36a0b2b53584dd1e1a1fac4cf5df0d3f0270
#Write-Host $pretty.commit.author.name
#Write-Host $pretty.commit.author.date

$ghCommitInfo =  gh api /repos/$orgName/$repoName/commits/$commitSha | ConvertFrom-Json

$commitInfo = [PSCustomObject]@{
    Name = $ghCommitInfo.commit.author.name
    Date = $ghCommitInfo.commit.author.date
}
return $commitInfo
}

$orgList = @("statpacs-common","statpacs-services")

#todo Iterate
$orgIndex = 0

$repolist = gh repo list $orgList[$orgIndex] --json name,url | ConvertFrom-Json
Write-Host "`nRepos in $($orgList[$orgIndex]):"
Write-Host ("-"*35)
Write-Host $("{0,-35} {1,-25}" -f "Name", "Url")
$repolist | ForEach-Object {
    Write-Host $("{0,-35} {1,-25}" -f $_.name, $_.url)
}

$repoIndex = 0
for ($repoIndex = 0; $repoIndex -lt $repolist.Count; $repoIndex++) {
    $branchBlob = git ls-remote --branches $repolist[$repoIndex].url
    $branches = $branchBlob | ConvertFrom-String -PropertyNames id,ref
    Write-Host "`n`n$($repolist[$repoIndex].name) Branches"
    Write-Host ("-"*35)
    Write-Host $("{0,-35} {1,-25} {2,-25} {3,-35}" -f "Branch", "Last Author", "Date", "Commit Sha")
    $branches | ForEach-Object {
        $branchSha = $_.id
        $branchName = $_.ref -replace "refs/heads/", ""
        $lastAction = getCommitInfo $orgList[$orgIndex] $repolist[$repoIndex].name $branchSha
        Write-Host $("{0,-35} {1,-25} {2,-25} {3,-35}" -f $branchName, $lastAction.Name, $lastAction.Date,$branchSha)
    }

    
}
