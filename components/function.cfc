<cfcomponent>
    <cffunction name = "login" returnType = "struct">
        <cfargument name = "userName">
        <cfargument name = "password">
        <cfset local.encrypted_pass = hash(arguments.password , 'SHA-512')>
        <cfset local.output = structNew()>

        <cfquery name = "fetchData">
            SELECT userName , password , fullName , profileImage
            FROM addressBook
            WHERE userName = <cfqueryparam value = "#arguments.userName#" cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cfif fetchData.userName EQ arguments.userName AND fetchData.password EQ local.encrypted_pass>
            <cfset session.fullName = fetchData.fullName>
            <cfset session.profileImage = fetchData.profileImage>
            <cflocation url = "dashboard.cfm">
        <cfelse>
            <cfset local.output['red'] = "invalid user">
        </cfif>
        <cfreturn local.output>
    </cffunction>

    <cffunction name = "signup" returnType = "struct">
        <cfargument name = "fullName" type = "String">
        <cfargument name = "email" type = "String">
        <cfargument name = "userName" type = "String">
        <cfargument name = "password" type = "String">
        <cfargument name = "profileImage">
        <cfset local.encrypted_pass = hash(arguments.password , 'SHA-512')>
        <cfset local.output = structNew()>

        <cfquery name = "fetchData">
            SELECT userName , password
            FROM addressBook
            WHERE userName = <cfqueryparam value = "#arguments.userName#" cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cfif queryRecordCount(fetchData) EQ 0>
            <cffile action = "upload" destination = "#expandPath("assets/userProfileImages/")#" nameconflict = "MakeUnique">
            <cfset local.getFilePath = cffile['SERVERFILE']>
            <cfquery name = "insertData">
                INSERT INTO addressBook (fullName,email,userName,password,profileImage)
                VALUES
                (
                    <cfqueryparam value = "#arguments.fullName#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#arguments.email#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#arguments.userName#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#local.encrypted_pass#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#local.getFilePath#" cfsqltype = "cf_sql_varchar">
                );
            </cfquery>
            <cfset local.output['green'] = "Account Created Successfully">
        <cfelse>
            <cfset local.output['red'] = "Account Already Exists">
        </cfif>
        <cfreturn local.output>
    </cffunction>

    <cffunction name = "logout" access = "remote">
        <cfset structDelete(session, "userName")>
        <cfset structDelete(session, "profileImage")>
    </cffunction>
</cfcomponent>