$connectionString = Get-Content -Path ".\vault-agent\db-connection-string.txt"

$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

try {
    $connection.Open()
    Write-Host "Connection to SQL Server successful!"

    $command = $connection.CreateCommand()
    $command.CommandText = "SELECT GETDATE() AS CurrentTime"
    $reader = $command.ExecuteReader()
    while ($reader.Read()) {
        Write-Host "Current SQL Server Time:" $reader["CurrentTime"]
    }
    $reader.Close()
}
catch {
    Write-Host "Error connecting to SQL Server:" $_.Exception.Message
}
finally {
    $connection.Close()
}