function Get-DisplayAlert {
	Param (
		#we do the params this way so the help shows the description
		[Parameter(Mandatory = $true)][string]
		#required, text for the notification
		$alertText,
		[Parameter(Mandatory = $false)][string]
		#the type, either critical/informational/warning
		$alertType,
		[Parameter(Mandatory = $false)][string[]]
		#an array (applescript list) of buttons. Can be up to three (check)
		$alertButtons,
		[Parameter(Mandatory = $false)][string]
		#name of the default button. This HAS to be in $alertButtons or it's a no go
		$alertDefaultButtonText,
		[Parameter(Mandatory = $false)][Int32]
		#number of the default button, this has to match the position in $alertButtons. Range is 1-3. Mutually exclusive with text
		[ValidateRange(1,3)]
		$alertDefaultButtonNum,
		[Parameter(Mandatory = $false)][string]
		#name of the cancel button. This HAS to be in $alertButtons or it's a no go
		$alertCancelButtonText,
		[Parameter(Mandatory = $false)][Int32]
		#number of the default button, this has to match the position in $alertButtons. Range is 1-3. Mutually exclusive with text
		[ValidateRange(1,3)]
		$alertCancelDefaultButtonNum,
		[Parameter(Mandatory = $false)][Int32]
		#optional parameter for auto-dismissing the alert. will add a "gave up" status to the reply if present
		$alertGivingUpAfter,
		[Paramter(Mandatory = $false)][string]
		#optional explanatory text
		$alertMessage
	)

	if (-Not $IsMacOS) {
		Write-Output "This module only runs on macOS, exiting"
		Exit
	}

	$displayAlertCommand = "display alert "

	##parameter processing
	#notification text
	#since this is mandatory, we don't have to test
	$displayAlertCommand = $displayAlertCommand + "`"$alertText`" "

	#sound name text
	if(-not [string]::IsNullOrEmpty($soundName)) {
		$displayNotificationCommand = $displayNotificationCommand + "sound name `"$soundName`" "
	}

	#subtitle processing
	if(-not [string]::IsNullOrEmpty($subTitle)) {
		$displayNotificationCommand = $displayNotificationCommand + "subtitle `"$subTitle`" "
	}

	#title processing
	if(-not [string]::IsNullOrEmpty($title)) {
		$displayNotificationCommand = $displayNotificationCommand + "with title `"$title`" "
	}

	$displayNotificationCommand |/usr/bin/osascript -so
}

#what the module shows the world
