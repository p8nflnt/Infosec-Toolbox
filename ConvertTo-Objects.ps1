<#
.SYNOPSIS
    Convert key / value pair strings back into usable objects
    Intended to compliment use of PsExec utility within PoSH scripts

.NOTES
    Name: ConvertTo-Objects
    Author: Payton Flint
    Version: 1.1
    DateCreated: 2023-Aug

.LINK
    https://paytonflint.com/powershell-convert-psexec-run-cmdlet-output-strings-back-to-objects-properties-values/
    https://github.com/p8nflnt/Infosec-Toolbox/blob/main/ConvertTo-Objects.ps1
#>
Function ConvertTo-Objects {
    param (
        $inputString
    )

    # Split the input string into lines
    $lines = $inputString -split "`n"

    # Initialize an empty array to hold objects
    $objects = @()

    # Initialize an empty hashtable to hold property values
    $properties = @{}

    # Iterate through each line and extract property and value using regex
    foreach ($line in $lines) {
        if ($line -match '^(.*?):\s*(.*)$') {
            $property = $matches[1].Trim()
            $value = $matches[2].Trim()

            if ($property -ne '') {
                $properties[$property] = $value
            }
        }
    }

    # If there are properties, create an object and add it to the array
    if ($properties.Count -gt 0) {
        $object = [PSCustomObject]$properties
        $objects += $object
    }

    # Return the resulting objects
    Write-Output $objects
} # End Function ConvertTo-Objects

# Call the function with the input
$Output = ConvertTo-Objects -inputString $input

$Output
