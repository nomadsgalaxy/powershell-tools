#This script is a simple copy and paste into a powershell window. It will export a CSV file with all AD groups and their members. This is useful for auditing purposes.
#Please be sure to update the path to the CSV file to your desired location.

#Import the AD module
Import-Module ActiveDirectory

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
