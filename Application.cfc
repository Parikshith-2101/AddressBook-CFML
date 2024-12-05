<cfcomponent>
    <cfset this.name = "app">
    <cfset this.sessionManagement = "true">
    <cfset this.dataSource = "myDBMS">
    <cfset application.objFunction = createObject("component", "components.addressBook")>
    <cfset this.ormEnabled = "true">

    <cffunction name = "onRequest">
        <cfargument name = "requestPage">
        <cfif structKeyExists(session, "fullName") 
            OR arguments.requestPage EQ "/signup.cfm" 
            OR arguments.requestPage EQ "/googleSSO.cfm"
            OR cgi.HTTP_USER_AGENT EQ "CFSCHEDULE"
        >
            <cfinclude template = "#arguments.requestPage#">
        <cfelse> 
            <cfinclude template = "/index.cfm">
        </cfif>
    </cffunction>
    
</cfcomponent>