#################################################
# This quick script will evaluate your User     #
# Profile Disks in your RDS environment against #
# user objectSid attributes in AD and remove    #
# any that are orphaned.                        #
#################################################

$profiledir = "E:\Profiles"       #You must update this to the path where you are storing your user profile disks.
$profiledisks = (Get-Item $profiledir\UVHD-S*).Basename


foreach($profiledisk in $profiledisks){
    
    $sid = $profiledisk.Substring(5)
   
    $user = Get-ADUser -Filter {objectSID -like $sid}
    
    if ($user -eq $null){
        Write-Host "Removing file. No matching AD account found for: $profiledir\UVHD-$sid.vhdx" -ForegroundColor Red
        Remove-Item $profiledir\UVHD-$sid.vhdx

    }Else {
        #Do nothing. Use this section for testing.
        #Write-Host $user.sAMAccountName -ForegroundColor Green
    }

    $user = $null
}
