<cfcomponent>
    <cfset this.name = "app">
    <cfset this.sessionManagement = "true">
    <cfset this.dataSource = "myDBMS">
    <cfset application.objFunction = createObject("component", "components.function")>
    <cfset this.ormEnabled = "true">

    <cffunction name = "onRequest">
        <cfargument name = "requestPage">
        <cfif structKeyExists(session, "fullName") 
            OR arguments.requestPage EQ "/Tasks/AddressBook-CFML/signup.cfm" 
            OR arguments.requestPage EQ "/Tasks/AddressBook-CFML/googleSSO.cfm"
            OR cgi.HTTP_USER_AGENT EQ "CFSCHEDULE"
        >
            <cfinclude template = "#arguments.requestPage#">
        <cfelse> 
            <cfinclude template = "/Tasks/AddressBook-CFML/index.cfm">
        </cfif>
    </cffunction>
    
</cfcomponent>