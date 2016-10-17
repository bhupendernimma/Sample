#
# DeployScript.ps1
#

Param( 
       [String]$ServerName = "",
       [String]$PackageSource =""
    ) 

function Get-MSDeployPath()
{

    Get-ChildItem "HKLM:\Software\Microsoft\IIS Extensions\MSDeploy" -Recurse | % {
                                                                                $prop=Get-ItemProperty $_.pspath
                                                                                if($prop.InstallPath -ne $null)
                                                                                    {
                                                                                      return $prop.InstallPath
                                                                                    }
                                                                                  }
}

$path = Get-MSDeployPath

if($path -eq $null)
{
    write-host "MS Deploy is not installed."
	return
}
write-host $path

 $rootDir = Split-Path $MyInvocation.MyCommand.Path
 if($PackageSource -eq "")
 {
  $PackageSource=$rootDir +"\SampleApplication\obj\Prod\Package\SampleApplication.zip" 
  }


 cd $path
 $log = cmd.exe /C $("msdeploy.exe -verb:sync -source:package=`"{0}`" -dest:auto" -f $PackageSource )
 Write-Host $log


