#Get Active Regions in the account
Write-Host "Finding active aws regions on this account ..." -ForegroundColor Yellow
$Regions = Get-EC2Region | Select RegionName

$InstancesWithIMDSv1 = @()
Write-Host "Finding EC2 instances in active regions ..." -ForegroundColor Yellow

ForEach($R in $Regions.RegionName)
{
    
    #Get number of EC2 Instance per region
    $InstancesPerRegionCount = (Get-EC2Instance -Region $R).Count
    
    if($InstancesPerRegionCount -ne 0)
	{
        "`n"
        $InstancesPerRegionCount.ToString() + " instances in " + $R 
        $InstancesInRegion = (Get-EC2Instance -Region $R).Instances.InstanceId
        
        ForEach($InstanceId in $InstancesInRegion)
        {
            $InstanceHttpTokenOption = (Get-EC2Instance -InstanceId $InstanceId -Region $R).Instances.MetaDataOptions.HttpTokens.Value
            "|"
            Write-Host "--- " -NoNewline

            if($InstanceHttpTokenOption -eq "optional")
            {
               Write-Host  $InstanceId -ForegroundColor Red
               $InstancesWithIMDSv1 += $InstanceId + ';' + $R
            }
            elseif($InstanceHttpTokenOption -eq "required")
            {
               Write-Host $InstanceId -ForegroundColor Green
            }
        
        }
    }
}


if($InstancesWithIMDSv1.Count -eq 0)
{
    "`n"
    Write-Host "No action needed" -ForegroundColor Green
}
elseif($InstancesWithIMDSv1.Count -gt 0)
{
    "`n" 
    Write-Host $InstancesWithIMDSv1.Count.ToString() -ForegroundColor Yellow -NoNewline
    Write-Host " EC2 Instances are currently using IMDSv1." -ForegroundColor Yellow

    "`n"
    $userInput = Read-Host "Would you like to covert all EC2 instance metadata to IMDSv2? (y/n)"


    if($userInput.ToLower() -eq "y")
    {
        Write-Host "`nThis script doesn't perform any pre-checks for applications dependencies on IMDSv1. The script only updates the EC2 Instance metadata option to use IMDSv2.`n" -ForegroundColor Yellow
        $confirmation = Read-Host "Please, write cofirm to move forward"
        if($confirmation.ToLower() -eq "confirm")
        {
            "Updating EC2 instances metadata option to IMDSv2"

            foreach($ins in $InstancesWithIMDSv1)
            {
                $ins = $ins.Split(';')
                "Updating EC2 instance $ins[0]"
                Edit-EC2InstanceMetadataOption -InstanceId $ins[0] -Region $ins[1] -HttpToken required
            }
        }
        else
        {
            "Exiting script..."
            break
        }
    } 

}
