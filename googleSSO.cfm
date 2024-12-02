<!--- <cflogin> --->
    <cfoauth  
        Type="Google"  
  
        scope="email" 

        result="session.ssoResult"
    >
<!--- </cflogin> --->
<cfif structKeyExists(session, "ssoResult")>
    <cfset application.objFunction.googleLogin(session.ssoResult)>
    <cflocation  url="dashboard.cfm" addToken = "No">
</cfif>