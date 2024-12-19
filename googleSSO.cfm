<cfoauth  
    Type="Google"  
    clientid="43635055841-tliva9lkk8ehq7g441j0oqek80qv38hr.apps.googleusercontent.com"  
    scope="email" 
    secretkey="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"  
    result="session.ssoResult"
>

<cfif structKeyExists(session, "ssoResult")>
    <cfset application.objAddressBook.googleLogin(session.ssoResult)>
    <cflocation  url="dashboard.cfm" addToken = "No">
</cfif>