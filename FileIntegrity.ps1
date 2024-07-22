# .\FileIntegrity.ps1 MD5 8F464B21F5FC4AF9FA6A9462384BD046 .\NetworkScanner.ps1
$algorithm=$args[0]
$original_checksum=$args[1]
$file=$args[2]

$FileHash = Get-FileHash $file -Algorithm $algorithm

if ($FileHash.Hash -eq $original_checksum){
    $FileHash
    $original_checksum
    $FileHash.Hash
    Write-Output "File Integrity is Intact."
}
else{
    $FileHash
    $original_checksum
    $FileHash.Hash
    Write-Output "Warning: File Integrity check has failed!"
}