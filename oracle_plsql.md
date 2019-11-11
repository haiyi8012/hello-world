## start with connect by prior 递归查询用法
select t.praentid, t.subid, level
  from a_test t
  start with t.subid = '7'
  connect by subid = prior parentid 
  order by level desc;
  | praentid | subid | level |
  | 1 | 3 | 2 |
  | 3 | 7 | 1 |
```
start with 子句：遍历起始条件，有个小技巧，如果要查父结点，这里可以用子结点的列，反之亦然。
connect by 子句：连接条件。关键词prior，prior跟父节点列parentid放在一起，就是往父结点方向遍历；prior跟子结点列subid放在一起，则往叶子结点方向遍历， parentid、subid两列谁放在“=”前都无所谓，关键是prior跟谁在一起。
order by 子句：排序，不用多说。
```
## DML/DDL 自检
```

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods` (

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (1,' iPhone X',' 当天发/12分期/送大礼 Apple/苹果 iPhone X移动联通4G手机中移动','/img/iphone.jpg',' 当天发/12分期/送大礼 Apple/苹果 iPhone X移动联通4G手机中移动',7268.00,1000,'2018-07-12 19:06:20','2018-07-12 19:06:20'),(2,'xiaomi 8',' 小米8现货【送小米耳机】Xiaomi/小米 小米8手机8plus中移动8se','/img/xiaomi.jpg',' 小米8现货【送小米耳机】Xiaomi/小米 小米8手机8plus中移动8se',2799.00,1000,'2018-07-12 19:06:20','2018-07-12 19:06:20'),(3,'荣耀 10',' 12期分期/honor/荣耀10手机中移动官方旗舰店正品荣耀10手机playv10 plαy','/img/rongyao.jpg',' 12期分期/honor/荣耀10手机中移动官方旗舰店正品荣耀10手机playv10 plαy',2699.00,1000,'2018-07-12 19:06:20','2018-07-12 22:32:20'),(4,'oppo find x',' OPPO R15 oppor15手机全新机限量超薄梦境r15梦镜版r11s find x','/img/oppo.jpg',' OPPO R15 oppor15手机全新机限量超薄梦境r15梦镜版r11s find x',4999.00,1000,'2018-07-12 19:06:20','2018-07-12 19:06:20');
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;
```
## COALESCE / GREATEST /LEAST
```
select coalesce ( null, 2, 1 ) from dual ; -- 返回2
select greatest (1, 3, 2 ) from dual ; -- 返回3
select least (1, 3, 2 ) from dual ; -- 返回1
select least (null, 'B', 'C' ) from dual ; -- 返回null
```
## 索引
```
 DT_DJND0220
ALTER TABLE DT_DJND0220
  ADD CONSTRAINT DT_DJND0220_IDX
  UNIQUE("CSHAINNO", "START_DTE", "KEY_DTE");

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;

 DT_DJND0310
drop INDEX "KOUBE"."DT_DJND0310_IDX_2"

ALTER TABLE DT_DJND0310
  ADD CONSTRAINT DT_DJND0310_IDX
  UNIQUE("CSHAINNO", "SEQ_NUM", "HTREINGB_DTE", "IDO_CDE");
  
```
## ORA-29532 调用java方法出错
```
ORA-29532: 不明なJava例外でJavaコールが終了しました: 
java.security.AccessControlException: the Permission (java.io.FilePermission <<ALL FILES>> execute) 
has not been granted to KOUBE. Th...
プロセスが終了しました。

exec dbms_java.grant_permission( 'KOUBE', 'SYS:java.io.FilePermission', '<<ALL FILES>>', 'execute' );
```
## CREATE OR REPLACE DIRECTORY
```
CREATE OR REPLACE DIRECTORY DIR_JINKYU2TMGIF_CSV AS 'D:\JINKYU2TMGIF_CSV';

select directory_name, directory_path from all_directories 
  where directory_name like 'DIR_JINKYU2TMGIF%';
```

## 将文件写入到BLOB字段
```
    wsWk_fname := 'aaa.zip'; --test
    piece_bfile := BFILENAME('DATA_PUMP_DIR',wsWk_fname); --创建一个BFILE指针
    DBMS_LOB.CREATETEMPORARY(wsWk_fbody,TRUE);
    DBMS_LOB.OPEN(wsWk_fbody, DBMS_LOB.LOB_READWRITE);
    DBMS_LOB.OPEN(piece_bfile, DBMS_LOB.FILE_READONLY);
    -- 将b_file中的内容转换到b_lob
    DBMS_LOB.LOADFROMFILE(wsWk_fbody, piece_bfile,DBMS_LOB.GETLENGTH(piece_bfile));
    -- wsWk_fbody := piece_bfile;
```

## 发送邮件异常ORA-29278 Service not available
```
    test mark::
        conn := utl_smtp.open_connection( 'smtp.qq.com', 25 );    
        utl_smtp.helo(conn, 'smtp.qq.com' );
        UTL_SMTP.COMMAND(conn,'AUTH LOGIN');
        UTL_SMTP.COMMAND(conn,UTL_RAW.CAST_TO_VARCHAR2(UTL_ENCODE.BASE64_ENCODE(UTL_RAW.CAST_TO_RAW('83109357'))));
        UTL_SMTP.COMMAND(conn,UTL_RAW.CAST_TO_VARCHAR2(UTL_ENCODE.BASE64_ENCODE(UTL_RAW.CAST_TO_RAW('wnymmcpkdujebhdh'))));
    test mark end::
```
```
--首先创建一个新的ACL文件
BEGIN  
    dbms_network_acl_admin.create_acl(acl         => 'httprequestpermission.xml',   --新文件名
                                      DESCRIPTION => 'Normal Access',  
                                      principal   => 'CONNECT',  --赋予角色 CONNECT
                                      is_grant    => TRUE,  
                                      PRIVILEGE   => 'connect',  
                                      start_date  => NULL,  
                                      end_date    => NULL);  
END;
/

 commit
提交完成后，查看acl文件是否建立；
SELECT * --any_path 
FROM resource_view WHERE any_path like '/sys/acls/%.xml';

--将改ACL授权給某个用户，这里用scott代替；
begin  
    dbms_network_acl_admin.add_privilege(acl        => 'httprequestpermission.xml',  
                                         principal  => 'NAGAOKA',  
                                         is_grant   => TRUE,  
                                         privilege  => 'connect',  
                                         start_date => null,  
                                         end_date   => null);  
end; 
/

--授权主机域名地址等
    begin  
        dbms_network_acl_admin.assign_acl(acl        => 'httprequestpermission.xml',  
                                          host       => 'www.qq.com',  
                                          lower_port => 80,  
                                          upper_port => NULL);  
    end;  
/
begin  
        dbms_network_acl_admin.assign_acl(acl        => 'httprequestpermission.xml',  
                                          host       => 'smtp.qq.com',  
                                          lower_port => 25,  
                                          upper_port => NULL);  
    end;  
/

--acl查询
select * from dba_network_acl_privileges;
============

```

# SQL developer Tool　debug setting
```
  ---============ ADD ACL START
  SELECT acl,
         principal,
         privilege,
         is_grant,
         TO_CHAR(start_date, 'DD-MON-YYYY') AS start_date,
         TO_CHAR(end_date, 'DD-MON-YYYY') AS end_date
    FROM dba_network_acl_privileges;

  BEGIN
   DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE
   (
   host => '192.168.1.63', --指定host
   lower_port => null,
   upper_port => null,
   ace => xs$ace_type(privilege_list => xs$name_list('jdwp'),
   principal_name => 'NAGAOKA', --指定user
   principal_type => xs_acl.ptype_db)
   );
  END;
  ---+++++++++++++++END
```
```  
SET SERVEROUTPUT ON;   
CALL dbms_java.set_output(2000);
```
＃ SQLCODE:-1031-ORA-01031: 権限が不足しています
```
SELECT * FROM system_privilege_map;
grant all privileges to NAGAOKA
```

## ORA-29471: DBMS_SQL
```
客户端session过期引起。关闭客户端，重新打开即可。
```
