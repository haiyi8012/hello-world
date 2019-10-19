##例えば、以下です
#zip_files.ps1の内容：
```
param($a,$b)

$compress = @{
Path = $b
CompressionLevel = "Optimal"
DestinationPath = $a
Update = $True
}
Compress-Archive @compress
```
#plsql の部分：
```
create or replace and compile java source named zipFiles as
import java.io.*;
import java.util.*;
public class zipFiles
{ 
  public static void doIt(String[] args)   
  {
    String cmd = "cmd /c powershell D:/DIR_DUMP/zip_files.ps1 \""+args[0]+"\" \""+args[1]+"\"";
  
    try {
        Process ps = Runtime.getRuntime().exec(cmd);
        System.out.println(ps.getInputStream());
    } catch(IOException ioe) {
        ioe.printStackTrace();
    }
  }   
}

create or replace procedure ZipFiles
(
	Ps_FILE1		 VARCHAR2	,
	Ps_FILE2		 VARCHAR2	
) as language java name 'zipFiles.doIt(java.lang.String[])';

--exec testJava3('D:/DIR_DUMP', 'aDT_DJND0110');
exec JINKYU2TMGIF.exeZipFiles('D:/DIR_DUMP/JINKYU2TMGIF003.zip', 'D:/DIR_DUMP/DT_DJND0110.LOG, D:/DIR_DUMP/DT_DJND0110.BAD, D:/DIR_DUMP/DT_DJND0110.csv');
-- powershell.exe D:\DIR_DUMP\ps1.ps1 "aa" "D:/DIR_DUMP/DT_DJND0110.LOG,D:/DIR_DUMP/DT_DJND0110.BAD, D:/DIR_DUMP/DT_DJND0110.csv"
-- end ======
```

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
