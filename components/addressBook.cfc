<cfcomponent>
    <cffunction name = "login" returnType = "struct" access = "public">
        <cfargument name = "userName" type = "String" required = "true">
        <cfargument name = "password" type = "String" required = "true">
        <cfset local.encrypted_pass = hash(arguments.password , 'SHA-512')>
        <cfset local.output = structNew()>

        <cfquery name = "qryFetchData">
            SELECT userID, userName, password, fullName, profileImage, email
            FROM addressBook
            WHERE userName = <cfqueryparam value = "#arguments.userName#" cfsqltype = "cf_sql_varchar">;
        </cfquery>

        <cfif qryFetchData.userName EQ arguments.userName AND qryFetchData.password EQ local.encrypted_pass>
            <cfset session.fullName = qryFetchData.fullName>
            <cfset session.userName = qryFetchData.userName>
            <cfset session.userID = qryFetchData.userID>
            <cfset session.emailID = qryFetchData.email>
            <cfset session.profileImage = qryFetchData.profileImage>
            <cflocation url = "dashboard.cfm" addToken = "No">
        <cfelse>
            <cfset local.output['red'] = "Invalid User">
        </cfif>

        <cfreturn local.output>
    </cffunction>

    <cffunction name = "signup" returnType = "struct" access = "public">
        <cfargument name = "fullName" type = "String" required = "true">
        <cfargument name = "email" type = "String" required = "true">
        <cfargument name = "userName" type = "String" required = "true">
        <cfargument name = "password" type = "String" required = "true">
        <cfargument name = "profileImage" required = "true">
        <cfset local.encrypted_pass = hash(arguments.password , 'SHA-512')>
        <cfset local.output = structNew()>

        <cfquery name = "qryFetchData">
            SELECT userName , password
            FROM addressBook
            WHERE userName = <cfqueryparam value = "#arguments.userName#" cfsqltype = "cf_sql_varchar">;
        </cfquery>

        <cfif queryRecordCount(qryFetchData) EQ 0>
            <cffile action = "upload" destination = "#expandPath("assets/userProfileImages/")#" nameconflict = "MakeUnique">
            <cfset local.getFilePath = cffile['SERVERFILE']>

            <cfquery name = "qryInsertData">
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

    <cffunction name = "logout" access = "remote" returnType = "void">
        <cfset structClear(session)>
    </cffunction>

    <cffunction name = "createContact" access = "public" returnType = "struct">
        <cfargument name = "title" type = "String">
        <cfargument name = "firstName" type = "String">
        <cfargument name = "lastName" type = "String">
        <cfargument name = "gender" type = "String">
        <cfargument name = "dob">
        <cfargument name = "profilePhoto" type = "String">
        <cfargument name = "address" type = "String">
        <cfargument name = "street" type = "String">
        <cfargument name = "district" type = "String">
        <cfargument name = "state" type = "String">
        <cfargument name = "country" type = "String">
        <cfargument name = "pincode" type = "String">
        <cfargument name = "email" type = "String">
        <cfargument name = "mobile" type = "String">
        <cfset local.output = structNew()>

        <cfquery name = "qryFetchData">
            SELECT firstName, lastName, email, mobile, _createdBy
            FROM contactDetails
            WHERE (email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">
                OR mobile = <cfqueryparam value="#arguments.mobile#" cfsqltype="cf_sql_varchar">)
            AND _createdBy = <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_varchar">;
        </cfquery>

        <cfif (queryRecordCount(qryFetchData) EQ 0) AND (trim(arguments.email) NEQ trim(session.emailID))>

            <cfif len(trim(arguments.profilePhoto))>
                <cffile action = "upload" destination = "#expandPath("assets/contactProfileImages/")#" nameconflict = "MakeUnique">
                <cfset local.getFilePath = cffile['SERVERFILE']>
            <cfelse>
                <cfset local.getFilePath = "profile.png">
            </cfif>

            <cfquery name = "qryInsertData">
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

            <cflocation url = "dashboard.cfm" addToken = "No">
            <cfset local.output['green'] = "Contact Added Successfully">
        <cfelse>
            <cfset local.output['red'] = "Contact Already Exists">
        </cfif>
        
        <cfreturn local.output>
    </cffunction>


    <cffunction name = "viewContact" returnType = "struct" returnFormat = "JSON" access = "remote">
        <cfargument name = "contactID">

        <cfquery name = "qryViewContact">
            SELECT contactID, title, firstName, lastName, gender, dateOfBirth, address, street, district, state, country, pincode, email, mobile, profilephoto
            FROM contactDetails
            WHERE contactID = <cfqueryparam value = "#arguments.contactID#" cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cfset local.queryStruct = queryGetRow(qryViewContact, 1)>

        <cfreturn local.queryStruct>
    </cffunction>

    <cffunction name = "deleteContact" access = "remote" returnType = "void">
        <cfargument name = "contactID">

        <cfquery name = "qryDeleteContact">
            DELETE FROM contactDetails
            WHERE contactID = <cfqueryparam value = "#arguments.contactID#" cfsqltype = "cf_sql_varchar">;
        </cfquery>

    </cffunction>

    <cffunction name = "editContact" access = "public" returnType = "Struct">
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
        <cfset local.output = structNew()>
        <cfquery name = "qryFetchData">
            SELECT profilephoto, email, mobile
            FROM contactDetails
            WHERE contactID = <cfqueryparam value = "#arguments.contactID#" cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cfquery name = "qryReferData">
            SELECT firstName, lastName, profilephoto, email, mobile 
            FROM contactDetails
            WHERE (email = <cfqueryparam value = "#arguments.email#" cfsqltype = "cf_sql_varchar">
            OR mobile = <cfqueryparam value = "#arguments.mobile#" cfsqltype = "cf_sql_varchar">)
            AND contactID != <cfqueryparam value = "#arguments.contactID#" cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfif queryRecordCount(qryReferData) NEQ 0>
            <cfset local.output['red'] = "Contact Already Exists">
        <cfelseif trim(arguments.email) EQ trim(session.emailID)>
            <cfset local.output['red'] = "Cannot Create Email Using Username">
        <cfelse>
            <cfif len(trim(arguments.profilePhoto))>
                <cffile action = "upload" destination = "#expandPath("assets/contactProfileImages/")#" nameconflict = "MakeUnique">
                <cfset local.getFilePath = cffile['SERVERFILE']>
            <cfelse>
                <cfset local.getFilePath = qryFetchData.profilephoto>
            </cfif>
            <cfquery name = "qryEditContact">
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
            <cfset local.output['green'] = "Contact Added Successfully">
        </cfif>
        <cfreturn local.output>
    </cffunction>

    <cffunction name = "contactList" access = "public" returnType = "query">

        <cfquery name = "qryContactDetails">
            SELECT title, firstName, lastName, gender, dateOfBirth, address, street, district, state, country, pincode, email, mobile, profilephoto
            FROM contactDetails
            WHERE _createdBy = <cfqueryparam value = "#session.userID#" cfsqltype = "cf_sql_varchar">;
        </cfquery> 

        <cfset local.output = qryContactDetails>

        <cfreturn local.output>
    </cffunction>
	
  	<cffunction name = "googleLogin" returnType = "any">
        <cfargument name = "structSSO">
        <cfset session.fullName = arguments.structSSO.name>
        <cfset session.emailID = arguments.structSSO.other.email>
        <cfset session.photo = arguments.structSSO.other.picture>

        <cfquery name = "qryFetchData">
            SELECT email
            FROM addressBook
            WHERE email = <cfqueryparam value = "#session.emailID#" cfsqltype = "cf_sql_varchar">
            AND password IS NULL;
        </cfquery>

        <cfif queryRecordCount(qryFetchData) EQ 0>
            <cfquery name = "qryInsertData">
                INSERT INTO addressBook(fullName, email, userName, profileImage)
                VALUES(
                    <cfqueryparam value = "#session.fullName#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#session.emailID#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#session.emailID#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#session.photo#" cfsqltype = "cf_sql_varchar">
                );
            </cfquery>
        </cfif>

        <cfquery name = "qryFetchID">
            SELECT  userID
            FROM addressBook
            WHERE email = <cfqueryparam value = "#session.emailID#" cfsqltype = "cf_sql_varchar">;
        </cfquery>

        <cfset session.userID = qryFetchID.userID>

	</cffunction>
    
    <cffunction name = "scheduleEnabler">
        <cfargument name = "userID">
        <cfschedule
            action = "update"
            task = "task_bdayMail"
            operation = "HTTPRequest"
            url = "http://addressbook.org/mail.cfm?userID=#arguments.userID#&userEmail=#session.emailID#"
            startDate = "#dateFormat(now(),'mm/dd/yyyy')#"        
            startTime = "10:33 AM"
            interval = "daily" 
            resolveURL = "Yes">

    </cffunction>
</cfcomponent>