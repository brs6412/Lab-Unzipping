# Define path to downloads folder
$downloadsPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads')

# Enter the lab number
$labNumber = Read-Host "Enter the lab number"

# Create the search pattern with the lab number
$searchPattern = "Lab $labNumber Download*.zip"

$zipFiles = Get-ChildItem -Path $downloadsPath -Filter $searchPattern

if ($zipFiles.Count -eq 0) {
    Write-Host "No zip files found matching 'Lab $labNumber Download' in the Downloads directory." -ForegroundColor Red
    exit
}

foreach ($zipFile in $zipFiles) {
    $destinationPath = [System.IO.Path]::Combine($downloadsPath, [System.IO.Path]::GetFileNameWithoutExtension($zipFile.Name))

    if (Test-Path -Path $destinationPath) {
        Write-Host "$zipFile.FullName has already been unzipped." -ForegroundColor Red
        exit
    }

    New-Item -ItemType Directory -Path $destinationPath | Out-Null

    Expand-Archive -Path $zipFile.FullName -DestinationPath $destinationPath -Force
    Write-Host "Unzipped '$($zipFile.Name)'" -ForegroundColor Green

    $studentFiles = Get-ChildItem -Path $destinationPath -Filter '*.zip' -File
    $totalFilesUnzipped = 0

    foreach ($studentFile in $studentFiles){
        $studentFilePath = [System.IO.Path]::Combine($studentFile.DirectoryName, [System.IO.Path]::GetFileNameWithoutExtension($studentFile.Name))

        if (-Not (Test-Path -Path $studentFilePath)) {
            New-Item -ItemType Directory -Path $studentFilePath | Out-Null
        }

        Expand-Archive -Path $studentFile.FullName -DestinationPath $studentFilePath -Force
        Remove-Item -Path $studentFile.FullName -Force -Recurse
        $totalFilesUnzipped += 1
    }
    Write-Host "Finished unzipping $totalFilesUnzipped student submissions to '$destinationPath'." -ForegroundColor Green
}

