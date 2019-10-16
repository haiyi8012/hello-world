・設定を行って、
1. 系统管理员 启动PowerShell
2. get-ExecutionPolicy
3. set-ExecutionPolicy RemoteSigned

CMDで下記のソースコードが実行するの
powershell.exe D:\DIR_DUMP\ps1.ps1 "aa" "D:/DIR_DUMP/DT_DJND0110.LOG,D:/DIR_DUMP/DT_DJND0110.BAD, D:/DIR_DUMP/DT_DJND0110.csv"

ps1.ps1の内容は下記
'''
param($a,$b)

# $pathArr = "D:/DIR_DUMP"+"/"+"DT_DJND0110"+".BAD", "D:/DIR_DUMP"+"/"+"DT_DJND0110"+".LOG"
# $pathArr = "D:/DIR_DUMP/DT_DJND0110.BAD", "D:/DIR_DUMP/DT_DJND0110.LOG"
$pathArr = @("$a/$b.BAD", "$a/$b.LOG")
# $pathArr = "args[0]/args[1].BAD", "args[0]/args[1].LOG"

# $zipStr = "D:/DIR_DUMP"+"/"+"DT_DJND0110555"+".zip"
$zipStr = "$a/$b.zip"
# $zipStr = "D:/DIR_DUMP/DT_DJND0110890.zip"

$compress = @{
Path = $pathArr
CompressionLevel = "Optimal"
DestinationPath = $zipStr
Update = $True
}
Compress-Archive @compress
'''