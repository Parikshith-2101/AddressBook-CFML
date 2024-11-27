<cfcomponent>
    <cfset this.name = "app">
    <cfset this.sessionManagement = "true">
    <cfset this.dataSource = "myDBMS">
    <cfset application.objFunction = createObject("component", "components.function")>

    <cffunction name = "onRequest">
        <cfargument name = "requestPage">
        <cfif structKeyExists(session, "fullName") 
            OR arguments.requestPage EQ "/signup.cfm" 
            OR arguments.requestPage EQ "/googleSSO.cfm"
        >
            <cfinclude template = "#arguments.requestPage#">
        <cfelse> 
            <cfinclude template = "/index.cfm">
        </cfif>
    </cffunction>
    
</cfcomponent>