<cfparam name ="url.userID" default = "">
<cfparam name = "url.userEmail" default = "abc@gmail.com">
<cfquery name = "fetchContactData">
    SELECT title, firstName, lastName, dateOfBirth, email
        FROM contactDetails
        WHERE _createdBy = <cfqueryparam value = "#url.userID#" cfsqltype = "cf_sql_varchar">;
</cfquery>

<cfloop query = "fetchContactData">
    <cfset local.getDay = day(fetchContactData.dateOfBirth)>
    <cfset local.getMonth = month(fetchContactData.dateOfBirth)>

    <cfif local.getDay EQ day(now()) AND local.getMonth EQ month(now())>
        <cfmail  from = "#url.userEmail#"  subject = "Birthday Wishesh"  to = "#fetchContactData.email#">
            Happy Birthday #now()#
        </cfmail>
    </cfif>
    
</cfloop>
