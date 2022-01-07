###########################################################
#  Search for items within zip files based in input file.
#  Originaly designed to search through archived and 
#    zipped LOG-MD Hash_Baseline.txt files. Slow but works.
#  https://github.com/elnao/
#  Date:  01/07/2022
###########################################################

# Define Variables
$ProgressPreference = "SilentlyContinue"
$zipArrays = Get-ChildItem -Recurse -Path 'E:\Hashes' -Include *.zip | Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-30)}
$inputValues = (Get-Content 'E:\temp\hashes.txt')
$FilesProcessedCount = 0

# Create Search Start Date Timestamp and Start Transcript
$SearchStartDate = (Get-Date -Format FileDateTimeUniversal)
Start-Transcript -path .\$SearchStartDate"-ELNAO_IOC_SEARCH.log"
write-host -ForegroundColor Magenta -BackgroundColor Yellow $SearchStartDate "- Start Time"

# Unzip Log-MD Zip files and search for values in input file
ForEach ($zipArray in $zipArrays) {
    $tempFile = 'E:\temp\' + $zipArray.PSChildName
    Expand-Archive -LiteralPath $zipArray.PSPath -DestinationPath $tempFile
    Get-ChildItem -Recurse -LiteralPath $tempFile -Include *Hash_Baseline.txt | Select-String -SimpleMatch -Pattern $inputValues | Select-Object | Out-File -FilePath .\$SearchStartDate"-ELNAO_IOC_SEARCH.txt" -Append -Width 800
    Remove-Item -LiteralPath $tempFile -Recurse -Confirm:$false
    $FilesProcessedCount = $FilesProcessedCount + 1
}

# Create Search Stop Date Timestamp
$SearchStopDate = (Get-Date -Format FileDateTimeUniversal)
write-host -ForegroundColor Magenta -BackgroundColor Yellow $SearchStopDate "- Stop Time"
write-host -ForegroundColor Magenta -BackgroundColor Yellow "Total Hash Baseline Files Processed:" $FilesProcessedCount 

Stop-Transcript