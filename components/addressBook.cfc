<cfcomponent>
    <cffunction name = "login" returnType = "struct" access = "public">
        <cfargument name = "userName" type = "String" required = "true">
        <cfargument name = "password" type = "String" required = "true">
        <cfset local.encrypted_pass = hash(arguments.password , 'SHA-512')>
        <cfset local.output = structNew()>
        <cfquery name = "local.qryFetchData">
            SELECT 
                userID, 
                userName, 
                password, 
                fullName, 
                profileImage, 
                email
            FROM 
                addressBook
            WHERE 
                userName = <cfqueryparam value = "#arguments.userName#" cfsqltype = "cf_sql_varchar">
                AND password =  <cfqueryparam value = "#local.encrypted_pass#" cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cfif local.qryFetchData.RecordCount>
            <cfset session.fullName = local.qryFetchData.fullName>
            <cfset session.userName = local.qryFetchData.userName>
            <cfset session.userID = local.qryFetchData.userID>
            <cfset session.emailID = local.qryFetchData.email>
            <cfset session.profileImage = local.qryFetchData.profileImage>
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
        <cfset local.encrypted_pass = hash(arguments.password, 'SHA-512')>
        <cfset local.output = structNew()>
        <cfquery name = "local.qryFetchData">
            SELECT 
                userName,
                password
            FROM 
                addressBook
            WHERE 
                userName = <cfqueryparam value = "#arguments.userName#" cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cfif local.qryFetchData.RecordCount EQ 0>
            <cffile action = "upload" destination = "#expandPath("assets/userProfileImages/")#" nameconflict = "MakeUnique">
            <cfset local.getFilePath = cffile['SERVERFILE']>
            <cfquery name = "local.qryInsertData">
                INSERT INTO addressBook(
                    fullName,
                    email,
                    userName,
                    password,
                    profileImage
                )
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
        <cfargument name = "title" type = "String" required = "true">
        <cfargument name = "firstName" type = "String" required = "true">
        <cfargument name = "lastName" type = "String" required = "true">
        <cfargument name = "gender" type = "String" required = "true">
        <cfargument name = "dob" type = "date" required = "true">
        <cfargument name = "profilePhoto" type = "String" required = "true">
        <cfargument name = "address" type = "String" required = "true">
        <cfargument name = "street" type = "String" required = "true">
        <cfargument name = "district" type = "String" required = "true">
        <cfargument name = "state" type = "String" required = "true">
        <cfargument name = "country" type = "String" required = "true">
        <cfargument name = "pincode" type = "String" required = "true">
        <cfargument name = "email" type = "String" required = "true">
        <cfargument name = "mobile" type = "String" required = "true">
        <cfargument name = "roleID" type = "string" required = "true">

        <cfset local.output = structNew()>
        <cfquery name = "local.qryFetchData">
            SELECT 
                contactID,
                firstName, 
                lastName, 
                email, 
                mobile, 
                createdBy
            FROM 
                contactDetails
            WHERE 
                email = <cfqueryparam value = "#arguments.email#" cfsqltype="cf_sql_varchar">
                AND createdBy = <cfqueryparam value = "#session.userID#" cfsqltype="cf_sql_varchar">
                AND active = <cfqueryparam value = "true" cfsqltype="cf_sql_bit">;
        </cfquery>
        <cfif (trim(arguments.email) EQ trim(session.emailID))>
            <cfset local.output['red'] = "You Cannot Create Email Using Username">
        <cfelseif local.qryFetchData.RecordCount>
            <cfset local.output['red'] = "Contact Already Exists">
        <cfelse>
            <cfif len(trim(arguments.profilePhoto))>
                <cffile action = "upload" destination = "#expandPath("assets/contactProfileImages/")#" nameconflict = "MakeUnique">
                <cfset local.getFilePath = cffile['SERVERFILE']>
            <cfelse>
                <cfset local.getFilePath = "profile.png">
            </cfif>
            <cfquery name = "local.qryInsertData" result = "local.createResult">
                INSERT INTO contactDetails(
                    title, 
                    firstName, 
                    lastName, 
                    gender, 
                    dateOfBirth, 
                    profilephoto, 
                    address,
                    street,
                    district, 
                    state, 
                    country, 
                    pincode,
                    email,
                    mobile, 
                    createdBy,
                    updatedBy,
                    active
                )
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
                    <cfqueryparam value = "#session.userID#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "true" cfsqltype="cf_sql_bit">
                );
            </cfquery>
            <cfloop list = "#arguments.roleID#" item = "local.roleID">
                <cfquery name = "local.qryInsertRole">
                    INSERT INTO contactToRole(
                        contactID,
                        roleID
                    )
                    VALUES(
                        <cfqueryparam value = "#local.createResult.generatedkey#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#local.roleID#" cfsqltype = "cf_sql_varchar">
                    );
                </cfquery>
            </cfloop>
            <cfset local.output['green'] = "Contact Added Successfully">
        </cfif>
        <cfreturn local.output>
    </cffunction>

    <cffunction name = "viewContact" returnType = "struct" returnFormat = "JSON" access = "remote">
        <cfargument name = "contactID">
        <cfset local.contactListData = contactList()>
        <cfset local.contactDetails = "">
        <cfloop query = "local.contactListData">
            <cfif local.contactListData.contactID EQ arguments.contactID>
                <cfset local.contactDetails = structNew()>
                <cfset local.contactDetails['contactID'] = local.contactListData.contactID>
                <cfset local.contactDetails['title'] = local.contactListData.title>
                <cfset local.contactDetails['firstName'] = local.contactListData.firstName>
                <cfset local.contactDetails['lastName'] = local.contactListData.lastName>
                <cfset local.contactDetails['gender'] = local.contactListData.gender>
                <cfset local.contactDetails['dateOfBirth'] = local.contactListData.dateOfBirth>
                <cfset local.contactDetails['address'] = local.contactListData.address>
                <cfset local.contactDetails['street'] = local.contactListData.street>
                <cfset local.contactDetails['district'] = local.contactListData.district>
                <cfset local.contactDetails['state'] = local.contactListData.state>
                <cfset local.contactDetails['country'] = local.contactListData.country>
                <cfset local.contactDetails['pincode'] = local.contactListData.pincode>
                <cfset local.contactDetails['email'] = local.contactListData.email>
                <cfset local.contactDetails['mobile'] = local.contactListData.mobile>
                <cfset local.contactDetails['profilephoto'] = local.contactListData.profilephoto>
                <cfset local.contactDetails['role'] = local.contactListData.role>
                <cfset local.contactDetails['roleID'] = local.contactListData.roleID>
                <cfbreak>
            </cfif>
        </cfloop>
        <cfreturn local.contactDetails>
    </cffunction>

    <cffunction name = "deleteContact" access = "remote" returnType = "void">
        <cfargument name = "contactID">
<!---         <cfquery name = "local.qryDeleteContactID">
            DELETE 
                FROM contactToRole
            WHERE   
                contactID = <cfqueryparam value = "#arguments.contactID#" cfsqltype = "cf_sql_varchar">; 
        </cfquery> --->
        <cfquery name = "local.qryDeleteContact">
            UPDATE 
                contactDetails
            SET 
                active = <cfqueryparam value = "false" cfsqltype="cf_sql_bit">,
                deletedBy = <cfqueryparam value = "#session.userID#" cfsqltype = "cf_sql_varchar">,
                deletedOn = <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_timestamp">
            WHERE 
                contactID = <cfqueryparam value = "#arguments.contactID#" cfsqltype = "cf_sql_varchar">;
        </cfquery>
    </cffunction>

    <cffunction name = "editContact" access = "public" returnType = "Struct">
        <cfargument name = "title" type = "string" required="true">
        <cfargument name = "firstName" type = "string" required="true">
        <cfargument name = "lastName" type = "string" required="true">
        <cfargument name = "gender" type = "string" required="true">
        <cfargument name = "dob" type = "date" required="true">
        <cfargument name = "profilePhoto" type = "string" required="false">
        <cfargument name = "address" type = "string" required="true">
        <cfargument name = "street" type = "string" required="true">
        <cfargument name = "district" type = "string" required="true">
        <cfargument name = "state" type = "string" required="true">
        <cfargument name = "country" type = "string" required="true">
        <cfargument name = "pincode" type = "string" required="true">
        <cfargument name = "email" type = "string" required="true">
        <cfargument name = "mobile" type = "string" required="true">
        <cfargument name = "contactID" type = "string" required="true">
        <cfargument name = "roleID" required="true">
       
        <cfset local.output = structNew()>
        <cfquery name = "local.qryFetchPhoto">
            SELECT 
                profilephoto
            FROM 
                contactDetails
            WHERE 
                contactID = <cfqueryparam value = "#arguments.contactID#" cfsqltype = "cf_sql_varchar">
        </cfquery>
        <cfquery name = "local.qryReferData">
            SELECT 
                firstName, 
                lastName, 
                profilephoto, 
                email, 
                mobile
            FROM 
                contactDetails
            WHERE 
                email = <cfqueryparam value = "#arguments.email#" cfsqltype = "cf_sql_varchar"> 
                AND contactID != <cfqueryparam value = "#arguments.contactID#" cfsqltype = "cf_sql_varchar">,
                AND active = <cfqueryparam value = "true" cfsqltype="cf_sql_bit">;
        </cfquery>
        <cfif local.qryReferData.RecordCount EQ 0>  
            <cfif len(trim(arguments.profilePhoto))>
                <cffile action = "upload" destination = "#expandPath('assets/contactProfileImages/')#" nameconflict="MakeUnique">
                <cfset local.getFilePath = cffile['SERVERFILE']>
            <cfelse>
                <cfset local.getFilePath = local.qryFetchPhoto.profilephoto>
            </cfif>
            <cfquery name = "local.qryEditContact">
                UPDATE 
                    contactDetails
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
                    profilephoto = <cfqueryparam value = "#local.getFilePath#" cfsqltype = "cf_sql_varchar">,
                    updatedOn = <cfqueryparam value = "#now()#" cfsqltype = "cf_sql_timestamp">
                WHERE 
                    contactID = <cfqueryparam value = "#arguments.contactID#" cfsqltype = "cf_sql_varchar">;
            </cfquery>
            <cfquery name = local.qryDeleteContactID>
                DELETE FROM contactToRole                
                WHERE contactID = <cfqueryparam value = "#arguments.contactID#" cfsqltype = "cf_sql_varchar">;
            </cfquery>
            <cfloop list = "#arguments.roleID#" item = "local.roleID">
                <cfquery name = "local.qryInsertRole">
                    INSERT INTO contactToRole(
                        contactID,
                        roleID
                    )
                    VALUES(
                        <cfqueryparam value = "#arguments.contactID#" cfsqltype = "cf_sql_varchar">,
                        <cfqueryparam value = "#local.roleID#" cfsqltype = "cf_sql_varchar">
                    );
                </cfquery>
            </cfloop>
            <cfset local.output['green'] = "Contact Updated Successfully">
        <cfelseif trim(arguments.email) EQ trim(session.emailID)>
            <cfset local.output['red'] = "Cannot Create Email Using Username">
        <cfelse>
            <cfset local.output['red'] = "Contact Already Exists">
        </cfif>
        <cfreturn local.output>
    </cffunction>


    <cffunction name = "contactList" returnFormat = "JSON" access = "remote" returnType = "query">
        <cfquery name = "local.qryContactDetails">
            SELECT 
                c.title, 
                c.firstName, 
                c.lastName, 
                c.gender, 
                c.dateOfBirth, 
                c.address, 
                c.street, 
                c.district, 
                c.state, 
                c.country, 
                c.pincode, 
                c.email, 
                c.mobile,
                c.profilephoto,
                c.contactID,
                STRING_AGG(r.roleName, ',') AS role,
                STRING_AGG(r.roleID, ',') AS roleID
            FROM 
                contactDetails c
                LEFT JOIN contactToRole ctr ON c.contactID = ctr.contactID
                LEFT JOIN roleDetails r ON ctr.roleID = r.roleID
            WHERE 
                c.createdBy = <cfqueryparam value = "#session.userID#" cfsqltype = "cf_sql_varchar">
                AND c.active = <cfqueryparam value = "true" cfsqltype="cf_sql_bit">
            GROUP BY 
                c.title, 
                c.firstName, 
                c.lastName, 
                c.gender, 
                c.dateOfBirth, 
                c.address, 
                c.street, 
                c.district, 
                c.state, 
                c.country, 
                c.pincode, 
                c.email, 
                c.mobile, 
                c.profilephoto, 
                c.contactID;
        </cfquery> 
        <cfset local.output = local.qryContactDetails>
        <cfreturn local.output>
    </cffunction>
	
  	<cffunction name = "googleLogin" returnType = "any">
        <cfargument name = "structSSO">
        <cfset session.fullName = arguments.structSSO.name>
        <cfset session.emailID = arguments.structSSO.other.email>
        <cfset session.photo = arguments.structSSO.other.picture>
        <cfquery name = "local.qryFetchData">
            SELECT 
                email
            FROM 
                addressBook
            WHERE 
                email = <cfqueryparam value = "#session.emailID#" cfsqltype = "cf_sql_varchar">
                AND password IS NULL;
        </cfquery>
        <cfif local.qryFetchData.RecordCount EQ 0>
            <cfquery name = "local.qryInsertData">
                INSERT INTO addressBook(
                    fullName, 
                    email, 
                    userName, 
                    profileImage
                )
                VALUES(
                    <cfqueryparam value = "#session.fullName#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#session.emailID#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#session.emailID#" cfsqltype = "cf_sql_varchar">,
                    <cfqueryparam value = "#session.photo#" cfsqltype = "cf_sql_varchar">
                );
            </cfquery>
        </cfif>
        <cfquery name = "local.qryFetchID">
            SELECT 
                userID
            FROM 
                addressBook
            WHERE 
                email = <cfqueryparam value = "#session.emailID#" cfsqltype = "cf_sql_varchar">;
        </cfquery>
        <cfset session.userID = local.qryFetchID.userID>
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

    <cffunction name = "uploadExcel">
        <cfargument name = "uploadedExcel">
        <cffile action = "upload" destination = "#expandPath('/uploadedExcel')#" nameconflict="overwrite">
        <cfset local.filePath = expandPath('/uploadedExcel') & "/" & cffile.serverFile>
        <cfspreadsheet action = "read" src = "#local.filePath#" query = "addquery">
        <cfdump var = "#addquery#">
    </cffunction>
</cfcomponent>