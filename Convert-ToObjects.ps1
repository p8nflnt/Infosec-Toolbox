<#
.SYNOPSIS
    Convert Property : Value strings back into usable objects
    Intended for use w/ PsExec utility

.NOTES
    Name: Convert-ToObjects
    Author: Payton Flint
    Version: 1.0
    DateCreated: 2023-Aug

.LINKS
    https://paytonflint.com/powershell-convert-psexec-run-cmdlet-output-strings-back-to-objects-properties-values/
    
#>
Function Convert-ToObjects {
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
} # End Function Convert-ToObjects

# Call the function with the input
$Output = Convert-ToObjects -inputString $input

$Output
