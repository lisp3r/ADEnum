<#
.SYNOPSIS
    LDAPSearch queries all objects from AD
.EXAMPLE
    PS> LDAPSearch -LDAPQuery "(samAccountType=805306368)"
.EXAMPLE
    PS> foreach ($group in $(LDAPSearch -LDAPQuery "(objectCategory=group)")) { $group.properties | select {$_.cn}, {$_.member} }
#>
function LDAPSearch {
    param (
        [string]$LDAPQuery
    )

    $PDC = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().PdcRoleOwner.Name
    $DistinguishedName = ([adsi]'').distinguishedName

    $DirectoryEntry = New-Object System.DirectoryServices.DirectoryEntry("LDAP://$PDC/$DistinguishedName")

    $DirectorySearcher = New-Object System.DirectoryServices.DirectorySearcher($DirectoryEntry, $LDAPQuery)

    return $DirectorySearcher.FindAll()
}

<#
.SYNOPSIS
    Returns all groups from AD
.EXAMPLE
    PS> LDAPSearch-Groups

    Path                                                                                   Properties
    ----                                                                                   ----------
    LDAP://DC1.corp.com/CN=Administrators,CN=Builtin,DC=corp,DC=com                        {objectcategory, usnchanged, ...
    LDAP://DC1.corp.com/CN=Users,CN=Builtin,DC=corp,DC=com                                 {usnchanged, distinguishednam...
    ...
#>
function LDAPSearch-Groups {
    return LDAPSearch -LDAPQuery "(objectCategory=group)"
}

<#
.SYNOPSIS
    Returns specific group from AD
.EXAMPLE
    PS> LDAPSearch-Group "Sales Department"

    Path                                                    Properties
    ----                                                    ----------
    LDAP://DC1.corp.com/CN=Sales Department,DC=corp,DC=com  {usnchanged, distinguishedname, grouptype, whencreated...}
#>
function LDAPSearch-Group {
    param (
        [string]$GroupName
    )

    return LDAPSearch -LDAPQuery "(&(objectCategory=group)(cn=$GroupName))"
}
