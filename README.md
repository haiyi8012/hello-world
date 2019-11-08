```
java的反射
class.forName("xxx.class");
Method.invoke(Object obj, Object... args);
```
```
可变参数
Object... args
public int update(String sql, Object... params) throws SQLException {
    Connection conn = this.prepareConnection();
    return this.update(conn, true, sql, params);
}
```
