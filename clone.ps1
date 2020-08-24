# $str = "hoge"
# path: "D:\Mywork\ps\"
# str :"trd0202"
# to-str: "trd0209"

# ./ps_test "D:\Mywork\ps\" "trd0202" "trd0309"
# cmd : powershell.exe -noexit "& 'D:\MyWork\ps\ps_test.ps1 "D:\Mywork\ps\" "trd0202" "trd0309"'"
# >> $r1 = [Console]::Out
# >> $r1
# >> [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
# >> $r1
$args=@("D:\MyWork\client03\src\app\page\trd02\", "trd0202", "trd0204")
# $args=@("D:\Mywork\ps\", "trd0202", "trd0204") 

$path = $args[0];
[string] $fromDir = $path+$args[1]
[string] $fromDir_1 = $fromDir +"\"+$args[1]+"01"
[string] $fromDir_2 = $fromDir +"\"+$args[1]+"02"
[string] $from_component_ts 	= $fromDir +"\"+$args[1]+".component.ts"
[string] $from_component_scss = $fromDir +"\"+$args[1]+".component.scss"
[string] $from_component_html = $fromDir +"\"+$args[1]+".component.html"
[string] $from_dto 						= $fromDir +"\"+$args[1]+".dto.ts"
[string] $from_service 				= $fromDir +"\"+$args[1]+".service.ts"
#01
[string] $from_01_component_ts 		= $fromDir_1 +"\"+$args[1]+"01"+".component.ts"
[string] $from_01_component_scss 	= $fromDir_1 +"\"+$args[1]+"01"+".component.scss"
[string] $from_01_component_html 	= $fromDir_1 +"\"+$args[1]+"01"+".component.html"
[string] $from_01_service 				= $fromDir_1 +"\"+$args[1]+"01"+".service.ts"
#02
[string] $from_02_component_ts 		= $fromDir_2 +"\"+$args[1]+"02"+".component.ts"
[string] $from_02_component_scss 	= $fromDir_2 +"\"+$args[1]+"02"+".component.scss"
[string] $from_02_component_html 	= $fromDir_2 +"\"+$args[1]+"02"+".component.html"
[string] $from_02_service 				= $fromDir_2 +"\"+$args[1]+"02"+".service.ts"

#--to
[string] $toDir = $path+$args[2]
[string] $toDir_1 = $toDir +"\"+$args[2]+"01"
[string] $toDir_2 = $toDir +"\"+$args[2]+"02"
[string] $to_component_ts 	= $toDir +"\"+$args[2]+".component.ts"
[string] $to_component_scss = $toDir +"\"+$args[2]+".component.scss"
[string] $to_component_html = $toDir +"\"+$args[2]+".component.html"
[string] $to_dto 						= $toDir +"\"+$args[2]+".dto.ts"
[string] $to_service 				= $toDir +"\"+$args[2]+".service.ts"
#01
[string] $to_01_component_ts 		= $toDir_1 +"\"+$args[2]+"01"+".component.ts"
[string] $to_01_component_scss 	= $toDir_1 +"\"+$args[2]+"01"+".component.scss"
[string] $to_01_component_html 	= $toDir_1 +"\"+$args[2]+"01"+".component.html"
[string] $to_01_service 				= $toDir_1 +"\"+$args[2]+"01"+".service.ts"
#02
[string] $to_02_component_ts 		= $toDir_2 +"\"+$args[2]+"02"+".component.ts"
[string] $to_02_component_scss 	= $toDir_2 +"\"+$args[2]+"02"+".component.scss"
[string] $to_02_component_html 	= $toDir_2 +"\"+$args[2]+"02"+".component.html"
[string] $to_02_service 				= $toDir_2 +"\"+$args[2]+"02"+".service.ts"


[string] $fromTitle = (Get-Culture).TextInfo.ToTitleCase($args[1])
[string] $toTitle = (Get-Culture).TextInfo.ToTitleCase($args[2])
echo $from_component
echo $fromTitle
echo $toTitle
echo $to_component

If(!(Test-Path -path "$toDir\"))
    {
	#echo 'exit'
	#exit
        #if it does not create it
        New-Item $toDir -ItemType Directory
		New-Item $toDir_1 -ItemType Directory
		New-Item $toDir_2 -ItemType Directory
    }
#Test-Path .\*.log
If(!(Test-Path -path "$from_component_ts") `
	-Or !(Test-Path -path "$from_component_scss") `
	-Or !(Test-Path -path "$from_component_html") `
	-Or !(Test-Path -path "$from_dto") `
	-Or !(Test-Path -path "$from_service") `
	-Or !(Test-Path -path "$from_01_component_ts") `
	-Or !(Test-Path -path "$from_01_component_scss") `
	-Or !(Test-Path -path "$from_01_component_html") `
	-Or !(Test-Path -path "$from_01_service") `
	-Or !(Test-Path -path "$from_02_component_ts") `
	-Or !(Test-Path -path "$from_02_component_scss") `
	-Or !(Test-Path -path "$from_02_component_html") `
	-Or !(Test-Path -path "$from_02_service") `
	)
    {
	echo $from_component_ts
	echo 'exit'
	exit
    }
$(Get-Content -Encoding UTF8 $from_component_ts) 			-creplace $args[1],$args[2] -creplace $fromTitle,$toTitle> $to_component_ts 
$(Get-Content -Encoding UTF8 $from_component_scss) 		-creplace $args[1],$args[2] -creplace $fromTitle,$toTitle> $to_component_scss
$(Get-Content -Encoding UTF8 $from_component_html) 		-creplace $args[1],$args[2] -creplace $fromTitle,$toTitle> $to_component_html
$(Get-Content -Encoding UTF8 $from_dto) 							-creplace $args[1],$args[2] -creplace $fromTitle,$toTitle> $to_dto
$(Get-Content -Encoding UTF8 $from_service) 					-creplace $args[1],$args[2] -creplace $fromTitle,$toTitle> $to_service
#01
$(Get-Content -Encoding UTF8 $from_01_component_ts) 	-creplace $args[1],$args[2] -creplace $fromTitle,$toTitle> $to_01_component_ts
$(Get-Content -Encoding UTF8 $from_01_component_scss) -creplace $args[1],$args[2] -creplace $fromTitle,$toTitle> $to_01_component_scss
$(Get-Content -Encoding UTF8 $from_01_component_html) -creplace $args[1],$args[2] -creplace $fromTitle,$toTitle> $to_01_component_html
$(Get-Content -Encoding UTF8 $from_01_service) 				-creplace $args[1],$args[2] -creplace $fromTitle,$toTitle> $to_01_service
#02
$(Get-Content -Encoding UTF8 $from_02_component_ts) 	-creplace $args[1],$args[2] -creplace $fromTitle,$toTitle> $to_02_component_ts
$(Get-Content -Encoding UTF8 $from_02_component_scss) -creplace $args[1],$args[2] -creplace $fromTitle,$toTitle> $to_02_component_scss
$(Get-Content -Encoding UTF8 $from_02_component_html) -creplace $args[1],$args[2] -creplace $fromTitle,$toTitle> $to_02_component_html
$(Get-Content -Encoding UTF8 $from_02_service) 				-creplace $args[1],$args[2] -creplace $fromTitle,$toTitle> $to_02_service
echo 'success'
