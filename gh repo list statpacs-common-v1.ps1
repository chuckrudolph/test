$uri = "https://api.github.com/repos/statpacs-common/dicom/commits/b77b36a0b2b53584dd1e1a1fac4cf5df0d3f0270"

#$stuff = Invoke-RestMethod -uri $uri -Method Get
$stuff = gh api /repos/statpacs-common/dicom/commits/b77b36a0b2b53584dd1e1a1fac4cf5df0d3f0270
$pretty = $stuff | ConvertFrom-Json

Write-Host $pretty.commit.author.name
Write-Host $pretty.commit.author.date


$repolist = gh repo list statpacs-common --json name,url | ConvertFrom-Json
Write-Host "`nRepos in common:"
$repolist | ForEach-Object {
    Write-Host "Name: $($_.name), Url:$($_.url)"
}

$repoIndex = 0
for ($repoIndex = 0; $repoIndex -lt $repolist.Count; $repoIndex++) {
    $branchBlob = git ls-remote --branches $repolist[$repoIndex].url
    $branches = $branchBlob | ConvertFrom-String -PropertyNames id,ref
    Write-Host "`nBranches in $($repolist[$repoIndex].name)"
    $branches | ForEach-Object {
        Write-Host "id: $($_.id), ref:$($_.ref)"
    }
}




# $lastPush = gh repo view $($repolist[0].url)  --branch $branches[0].id --json pushedAt,updatedAt,name,owner | ConvertFrom-Json
# Write-Host "repo view on $($branches[0].ref)"
# Write-Host ($lastPush | Format-Table | Out-String)