# Define the list of computer names
$computerNames = # add a list of your PCs like this: "PC1", "PC2", etc

# Define the credential to use for stopping computers
$credential = Get-Credential -Credential "admin"

# Define the script block to be executed in the background job
$scriptBlock = {
    param($computerName, $cred)
    Stop-Computer -ComputerName $computerName -Force -Credential $cred -ErrorAction SilentlyContinue
}

# Create a background job for each computer
foreach ($computer in $computerNames) {
    Start-Job -ScriptBlock $scriptBlock -ArgumentList $computer, $credential
}

# Wait for all background jobs to complete
Get-Job | Wait-Job

# Retrieve job results
Get-Job | Receive-Job

# Remove completed jobs
Get-Job | Remove-Job
