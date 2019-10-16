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