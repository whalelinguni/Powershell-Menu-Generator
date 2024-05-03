<#
.EXAMPLE
    # Set the menu title, options, and choose between fixed or dynamic menu dimensions.
    $myTitle = "Whale Linguini Powershell Menu - Fixed Size"
    $MenuOptions = @("[1]. Shrimps", "[2]. Fishes", "[3]. Grandma?", "[0]. EMERGENCY EXIT")
    $conersChar = "#"    # Corners of Menu
    $lineChar = "~"      # Horizontal Lines
    $sideChar = "|"      # Vertical Lines

    # Run the script to display the menu and interact with options.
    do {
        # Static menu call
        # Show-BorderedMenuFixed -Title $myTitle -MenuOptions $MenuOptions -Width 50 -Height 15  

        # Dynamic menu call
        # Show-BorderedMenuDynamic -Title $myTitle -MenuOptions $MenuOptions

        # This line needs to be set for static or dynamic menu. Uncomment one of the above lines based on your choice.
        Show-BorderedMenuFixed -Title $myTitle -MenuOptions $MenuOptions -Width 50 -Height 15  

		$choice = Read-Host "Enter your choice"
			switch ($choice) {
				"exit" { exit }
				"0" { exit }
				default {
					if ($MenuOptions -and $choice -ge 1 -and $choice -le $MenuOptions.Count) {
						$selectedOption = $MenuOptions[$choice - 1]
						Write-Host "Selected option: $selectedOption"
						launchWhales $choice
					} else {
						Write-Host "Please select a valid option"
					}
				}
			}
			Write-Host "`nPress any key to continue..."
			$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
		} while ($choice -ne "exit")



#### Demp Code Setup Below (you can run this now) ####
See running demo code.
Search for "WhalesHaveFeelingsToo" to jump down to the area to edit the main menu.
#>

#demo function for demo 
function option1Demo {
	Write-Host "This is an example function named option1Demo"
	Start-Process "calc.exe"
}

#demo function for demo
function demoMore {
	param(
	[string]$inputString
	)
	Write-Host "Demo function named demoMore. Passed this string: $inputString"
}



# No need to edit this function.
function Show-BorderedMenuFixed {
    param (
        [string]$Title,
        [array]$MenuOptions,
        [int]$Width = 40,  # Default width
        [int]$Height = 10,  # Default height
        [bool]$StaticSize = $true  # Default to static size
    )

    $borderTop = $conersChar + $lineChar * ($Width - 2) + $conersChar
    $borderBottom = $conersChar + $lineChar * ($Width - 2) + $conersChar
    $borderSide = $sideChar

    $titlePadded = $Title.PadRight($Width - 4, ' ')  # Adjust for border characters

    Write-Host $borderTop
    Write-Host "$borderSide $titlePadded $borderSide"
    Write-Host $borderTop

    if ($StaticSize) {
        $availableLines = $Height - 4  # Deduct space for top border, title, and bottom border
    } else {
        $availableLines = $MenuOptions.Count
    }

    for ($i = 0; $i -lt $availableLines -and $i -lt $MenuOptions.Count; $i++) {
        $optionPadded = $MenuOptions[$i].PadRight($Width - 4, ' ')  # Adjust for border characters
        Write-Host "$borderSide $optionPadded $borderSide"
    }

    # Fill remaining lines with side walls if using dynamic size
    if (!$StaticSize) {
        for ($i = $MenuOptions.Count; $i -lt $Height - 4; $i++) {
            $sideWall = "$borderSide" + " " * ($Width - 2) + "$borderSide"
            Write-Host "$sideWall"
        }
    }

    Write-Host $borderBottom
}

# No need to edit this function.
function Show-BorderedMenuDynamic {
    param (
        [string]$Title,
        [array]$MenuOptions
    )

    $maxLength = ($MenuOptions + $myTitle | Measure-Object -Maximum -Property Length).Maximum # Get the length of the widest option
    
    $borderTop = $cornerChar + $lineChar * ($maxLength + 2) + $cornerChar
    $borderBottom = $cornerChar + $lineChar * ($maxLength + 2) + $cornerChar
    $borderSide = $sideChar

    Write-Host $borderTop
    Write-Host "$borderSide $($Title.PadRight($maxLength, ' ')) $borderSide"
    Write-Host $borderTop

    foreach ($option in $MenuOptions) {
        Write-Host "$borderSide $($option.PadRight($maxLength, ' ')) $borderSide"
    }

    Write-Host $borderBottom
}

###############################################################################################
### WhalesHaveFeelingsToo - Set code to run per option above. Set menu vars and type below. ###
###############################################################################################
# Is need to edit THIIIIIS function!
function launchWhales {
	param(
	[int]$mOption
	)
	
		If ($mOption -eq 1) {
			Write-Host "Option 1 Code Execution Place Holder"
			option1Demo
		}
		
		If ($mOption -eq 2) {
			Write-Host "Option 2 Code Execution Place Holder"
			Write-Host "I want to exit with this option too!"
			exit
		}
		
		If ($mOption -eq 3) {
			Write-Host "Option 3 Code Execution Place Holder"
			demoMore "passing this string to demoMore"
			option1Demo # running a second function.
		}
	
}

# Change these vars below. Menu will auto generate and pass option number to launchWhales function.
## The idea is to use this function as a starting point as to not need to edit/create switches in the do loop below. 
### Nothing really needs to be changed below except the vars and the 1 line in the do loop (along with dimentions if static is used)

# [--- Fixed Menu Dimentions ---]
# Show-BorderedMenuFixed -Title $myTitle -MenuOptions $MenuOptions -Width 50 -Height 15

# [--- Dynamic Menu Dimentions ---]
# Show-BorderedMenuDynamic -Title $myTitle -MenuOptions $MenuOptions

$myTitle = "ShortTitle" # Menu Title .... pretty obvi
$MenuOptions = @("[1]. Shrimps Make a long menu option don't they?", "[2]. Fishes", "[3]. Grandma?", "[0]. EMERGENCY EXIT") # setup your menu options here. 0 is hard coded to be exit as well.

$conersChar = "#" 	# Corners of Menu
$lineChar = "~" 	# Horizontal Lines
$sideChar = "|" 	# Vertical Lines
$exitOption = "0"	# Set what option number (if any) for an exit option.
#cls

do {
cls
	#Show-BorderedMenuFixed -Title $myTitle -MenuOptions $MenuOptions -Width 100 -Height 40  # <------ This line needs to be set for Static or Dyanmic.
	Show-BorderedMenuDynamic -Title $myTitle -MenuOptions $MenuOptions
#####---		 No Need To Edit Anyting Below 		---#####
#Write-Host "[DEBUG] MenuOptions: $MenuOptions"
    $choice = Read-Host "Enter your choice"
    switch ($choice) {
        "exit" { exit }
		$exitOption { exit }
		default {
			if ($MenuOptions -and $choice -ge 1 -and $choice -le $MenuOptions.Count) {
				$selectedOption = $MenuOptions[$choice - 1]
				Write-Host "Selected option: $selectedOption"
				launchWhales $choice # <----------- this is where the menu option number gets passed to launchWhales function. Everything can dynamically populate here.
			} else {
				Write-Host "Please select a valid option"
			}
		}
    }
    Write-Host "`nPress any key to continue..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
} while ($choice -ne "exit")