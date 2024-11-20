<cfcomponent>
    <cffunction name = "login" returnType = "struct">
        <cfargument name = "userName">
        <cfargument name = "password">
        <cfset local.encrypted_pass = hash(arguments.password , 'SHA-512')>
        <cfset local.output = structNew()>
        <cfquery name = "fetchData">
            SELECT userID, userName , password , fullName , profileImage
            FROM addressBook
            WHERE userName = <cfqueryparam value = "#arguments.userName#" cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cfif fetchData.userName EQ arguments.userName AND fetchData.password EQ local.encrypted_pass>
            <cfset session.fullName = fetchData.fullName>
            <cfset session.userName = fetchData.userName>
            <cfset session.userID = fetchData.userID>
            <cfset session.profileImage = fetchData.profileImage>
            <cflocation url = "dashboard.cfm" addToken = "No">
        <cfelse>
            <cfset local.output['red'] = "Invalid User">
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
        <cfset structDelete(session, "fullName")>
        <cfset structDelete(session, "profileImage")>
    </cffunction>

    <cffunction name = "createContact" returnType = "struct">
        <cfargument name = "title">
        <cfargument name = "firstName">
        <cfargument name = "lastName">
        <cfargument name = "gender">
        <cfargument name = "dob">
        <cfargument name = "profilePhoto">
        <cfargument name = "address">
        <cfargument name = "street">
        <cfargument name = "district">
        <cfargument name = "state">
        <cfargument name = "country">
        <cfargument name = "pincode">
        <cfargument name = "email">
        <cfargument name = "mobile">
        <cfset local.output = structNew()>
        <cfquery name = "fetchData">
            SELECT firstName, lastName , email , mobile 
            FROM contactDetails
            WHERE email = <cfqueryparam value = "#arguments.email#" cfsqltype = "cf_sql_varchar">
            AND mobile = <cfqueryparam value = "#arguments.mobile#" cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfif queryRecordCount(fetchData) EQ 0>
            <cffile action = "upload" destination = "#expandPath("assets/contactProfileImages/")#" nameconflict = "MakeUnique">
            <cfset local.getFilePath = cffile['SERVERFILE']>
            <cfquery name = "insertData">
                INSERT INTO contactDetails(title, firstName, lastName, gender, dateOfBirth, profilephoto, address ,street ,district , state, country, pincode ,email, mobile , _createdBy, _updatedBy)
                VALUES(
                    <cfqueryparam value = "#arguments.title#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#arguments.firstName#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#arguments.lastName#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#arguments.gender#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#arguments.dob#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#local.getFilePath#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#arguments.address#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#arguments.street#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#arguments.district#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#arguments.state#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#arguments.country#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#arguments.pincode#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#arguments.email#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#arguments.mobile#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#session.userID#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#session.userID#" cfsqltype = "cf_sql_varchar">
                );
            </cfquery>
            <cfset local.output['green'] = "Contact Added Successfully">
            <cflocation url = "dashboard.cfm" addToken = "No">
        <cfelse>
            <cfset local.output['red'] = "Contact Already Exists">
        </cfif>
        <cfreturn local.output>
    </cffunction>

    <cffunction name = "contactList" returnType = "query">
        <cfquery name = "contactList">
            SELECT contactID, profilephoto, firstName, email, mobile
            FROM contactDetails
            WHERE _createdBy = <cfqueryparam value = "#session.userID#" cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cfreturn contactList>
    </cffunction>

    <cffunction name = "viewContact" returnType = "struct" returnFormat = "JSON" access = "remote">
        <cfargument name = "contactID">
        <cfquery name = "viewContact">
            SELECT contactID, title, firstName, lastName, gender, dateOfBirth, address, street, district, state, country, pincode, email, mobile, profilephoto
            FROM contactDetails
            WHERE contactID = <cfqueryparam value = "#arguments.contactID#" cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cfset local.queryStruct = queryGetRow(viewContact, 1)>
        <cfreturn local.queryStruct>
    </cffunction>

    <cffunction name = "deleteContact" access = "remote" returnType = "void">
        <cfargument name = "contactID">
        <cfquery name = "deleteContact">
            DELETE FROM contactDetails
            WHERE contactID = <cfqueryparam value = "#arguments.contactID#" cfsqltype = "cf_sql_varchar">;
        </cfquery>
    </cffunction>

    <cffunction name = "editContact" returnType = "void">
        <cfargument name = "title">
        <cfargument name = "firstName">
        <cfargument name = "lastName">
        <cfargument name = "gender">
        <cfargument name = "dob">
        <cfargument name = "profilePhoto">
        <cfargument name = "address">
        <cfargument name = "street">
        <cfargument name = "district">
        <cfargument name = "state">
        <cfargument name = "country">
        <cfargument name = "pincode">
        <cfargument name = "email">
        <cfargument name = "mobile">
        <cfargument name = "contactID">
        <cfquery name = "editContact">
            UPDATE contactDetails
            SET 
                title = <cfqueryparam value = "#arguments.title#" cfsqltype = "cf_sql_varchar">, 
                firstName = <cfqueryparam value = "#arguments.firstName#" cfsqltype = "cf_sql_varchar">,
                lastName = <cfqueryparam value = "#arguments.lastName#" cfsqltype = "cf_sql_varchar">,
                gender = <cfqueryparam value = "#arguments.gender#" cfsqltype = "cf_sql_varchar">,
                dateOfBirth = <cfqueryparam value = "#arguments.dob#" cfsqltype = "cf_sql_varchar">, 
                address = <cfqueryparam value = "#arguments.address#" cfsqltype = "cf_sql_varchar">,
                street = <cfqueryparam value = "#arguments.street#" cfsqltype = "cf_sql_varchar">,
                district = <cfqueryparam value = "#arguments.district#" cfsqltype = "cf_sql_varchar">,
                state = <cfqueryparam value = "#arguments.state#" cfsqltype = "cf_sql_varchar">,
                country = <cfqueryparam value = "#arguments.country#" cfsqltype = "cf_sql_varchar">,
                pincode = <cfqueryparam value = "#arguments.pincode#" cfsqltype = "cf_sql_varchar">,
                email = <cfqueryparam value = "#arguments.email#" cfsqltype = "cf_sql_varchar">,
                mobile = <cfqueryparam value = "#arguments.mobile#" cfsqltype = "cf_sql_varchar">,
                profilephoto = <cfqueryparam value = "#local.getFilePath#" cfsqltype = "cf_sql_varchar">
            WHERE contactID = <cfqueryparam value = "#arguments.contactID#" cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cflocation url = "dashboard.cfm" addToken = "No">
    </cffunction>
</cfcomponent>