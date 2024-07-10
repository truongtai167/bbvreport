## Sort theo moi nhat
```sql
SELECT * 
FROM [User] u
ORDER BY u.createAt DESC;
```
## Lay theo status
```sql
SELECT u.name , u.createAt,u.role_id, u.status FROM [User] u
WHERE u.status = 1
```

## Lay theo Role
```sql
SELECT * FROM [User] u
WHERE u.role_id =  (SELECT setting_value FROM GetSettingValue('Role','Mentor') )
```

## Seach theo ten
```sql
SELECT * 
FROM [User] u
WHERE u.name = 'Khoa Nguyen'
```
## Lay tat ca user
```sql
SELECT u.name , u.createAt,u.role_id, u.status FROM [User] u
```