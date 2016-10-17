#
# BuildScript.ps1
#
#
# BuildScript.ps1
#
Param( 
        [Parameter(Mandatory=$true)] $env
    ) 
 $rootDir = Split-Path $MyInvocation.MyCommand.Path
 $SolutionPath=$rootDir +"\SampleApplication.sln" 

$msbuild ="C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe "
Write-Host $msbuild
$options = " /p:Configuration="+$env +" /p:CreatePackageOnPublish=True /p:DeployOnBuild=True /p:AutoParameterizationWebConfigConnectionStrings=False /p:DeployIisAppPath=""/Default Web Site/MySite"""
$clean = $msbuild + $SolutionPath + " /t:Clean"
Write-Host $clean
$build = $msbuild + $SolutionPath + $options 
#msbuild.exe $SolutionPath /t:Clean
Invoke-Expression $clean
Invoke-Expression $build
Write-Host "Successfully build solution "
