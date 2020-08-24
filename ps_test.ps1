# $str = "hoge"
# path: "D:\Mywork\ps\"
# str :"trd0202"
# to-str: "trd0209"

# ./ps_test "D:\Mywork\ps\" "trd0202" "trd0309"
# cmd : powershell.exe -noexit "& 'D:\MyWork\ps\ps_test.ps1 "D:\Mywork\ps\" "trd0202" "trd0309"'"

$args=@("アイアンマン", "キャプテンアメリカ", "ソー", "ハルク", "ブラック・ウィドウ")

$path = $args[0];
[string] $from = $path+$args[1]+"\"+$args[1]+".component.ts"

[string] $toDir = $path+$args[2]
[string] $to = $path+$args[2]+"\"+$args[2]+".component.ts"

[string] $fromTitle = (Get-Culture).TextInfo.ToTitleCase($args[1])
[string] $toTitle = (Get-Culture).TextInfo.ToTitleCase($args[2])
echo $from
echo $to
echo $fromTitle
echo $toTitle

If(!(Test-Path -path "$toDir\"))
    {
        #if it does not create it
        New-Item $toDir -ItemType Directory
    }
# 

$(Get-Content -Encoding UTF8 $from) -creplace $args[1],$args[2] -creplace $fromTitle,$toTitle> $to
