# Get all AD groups and their members
$groups = Get-ADGroup -Filter * -Properties Members |
Where-Object { $_.Members.Count -gt 0 } |
ForEach-Object {
    $groupName = $_.Name
    $members = $_.Members | Get-ADObject | Select-Object -ExpandProperty Name

    # Create a custom object for the group and its members
    [PSCustomObject]@{
        Group = $groupName
        Members = $members -join ","
    }
}

# Export the list to a CSV file
$groups | Export-Csv -Path "C:\Path\To\Csv\File.csv" -NoTypeInformation
