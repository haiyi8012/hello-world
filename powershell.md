## 数组 index from 0：
```
SET SERVEROUTPUT ON; 
DECLARE  
  TYPE test_type_array IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER; --定义存放test记录的数组类型 
  test_rec_array test_type_array; --声明变量，类型：存放test记录的数组类型
BEGIN
  --数组赋值
  test_rec_array(1) := 'test1';
  test_rec_array(2) := 'test55';

  --循环输出数组元素
  FOR i IN 1 .. test_rec_array.count LOOP
    DBMS_OUTPUT.PUT_LINE('i=' || i || ',line_1=' || test_rec_array(i)
                          || ',line_2=' || test_rec_array(i));
  END LOOP;
END;
```

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
```
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
```

[using-powershell-to-compare-and-copy-files](https://stackoverflow.com/questions/26567850/using-powershell-to-compare-and-copy-files-of-a-certain-type-recursively)


```
Get-Extension.ps1
function Get-Extension {
  $name = $args[0] + ".txt"
  $name
}

exec:
Get-Extension myTextFile

output:
myTextFile.txt
```

```
function Add-Numbers {
 $args[0] + $args[1]
}

PS C:\> Add-Numbers 5 10
15
```

https://ss64.com/ps/

[ps good idea](https://community.idera.com/database-tools/powershell/ask_the_experts/f/powershell_for_windows-12/5333/copy-and-rename-file-from-text-file)

```
Copy-Item -Path "C:\Logfiles\*" -Destination "C:\Drawings" -Recurse

Copy-Item C:\Path\To\File\file.ext "C:\Path\To\New\File\$newfilename"

(Get-Content c:\temp\test.txt) -replace '\[MYID\]', 'MyValue' | Set-Content c:\temp\test.txt

PS >$text = "hello" PS >$newText = $text.Substring(0,1).ToUpper() + >> $text.Substring(1) >> $newText >> Hello

```
[PowerShell 使い方メモ](https://qiita.com/opengl-8080/items/bb0f5e4f1c7ce045cc57)

[WindowsのPowerShellのGet-ChildItemを使ってファイルを検索する](https://qiita.com/sukkyxp/items/bfe901b779cf25ce6a30)

[(Powershell) ファイル内の文字列を置換してコピーするスクリプト](https://qiita.com/ttn_tt/items/af60c693690207a350ca)

```
$(Get-Content -Encoding UTF8 '.\t.txt')　-creplace 'abc','Abc' | % { [Text.Encoding]::UTF8.GetBytes($_) }  | Set-Content -Path ".\BOMなしUF8なファイル.txt" -Encoding Byte
$(Get-Content -Encoding UTF8 '.\t1.txt') -creplace 'abc','Abc' | Set-Content -Path '.\t02.txt' -Encoding UTF8
```
