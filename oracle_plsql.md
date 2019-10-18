#发送邮件异常ORA-29278 Service not available
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

-- commit
--提交完成后，查看acl文件是否建立；
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
--============

```

#SQL developer Tool　debug setting
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
＃SQLCODE:-1031-ORA-01031: 権限が不足しています
```
SELECT * FROM system_privilege_map;
grant all privileges to NAGAOKA
```
