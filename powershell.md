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
