# ADEnum

Collection of PowerShell functions for AD enumeration.

## Usage

### Import finctions

```powershell
PS > powershell -ep bypass
PS > Import-Module ADEnum.ps1
```

### LDAPSearch

`LDAPSearch` returns all objects from AD.

```powershell
PS > $objects = $(LDAPSearch -LDAPQuery "(objectCategory=group)")
PS > foreach ($obj in $objects) { ... }
```

### LDAPSearch-Groups

`LDAPSearch-Groups` returns all groups from AD

```powershell
PS > LDAPSearch-Groups

Path                                                                                   Properties
----                                                                                   ----------
LDAP://DC1.corp.com/CN=Administrators,CN=Builtin,DC=corp,DC=com                        {objectcategory, usnchanged, ...
LDAP://DC1.corp.com/CN=Users,CN=Builtin,DC=corp,DC=com                                 {usnchanged, distinguishednam...
LDAP://DC1.corp.com/CN=Guests,CN=Builtin,DC=corp,DC=com                                {usnchanged, distinguishednam...
...
```

### LDAPSearch-Group

`LDAPSearch-Group <GroupName>` returns specific group from AD

```powershell
PS > LDAPSearch-Group "Sales Department"
Path                                                   Properties
----                                                   ----------
LDAP://DC1.corp.com/CN=Sales Department,DC=corp,DC=com {usnchanged, distinguishedname, grouptype, whencreated...}
```

```powershell
PS > $(LDAPSearch-Group "Sales Department").Properties.member
CN=Development Department,DC=corp,DC=com
CN=pete,CN=Users,DC=corp,DC=com
CN=stephanie,CN=Users,DC=corp,DC=com
```
