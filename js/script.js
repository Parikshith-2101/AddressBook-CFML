function logout(){
    if(confirm("Logout! Are you sure?")){
        $.ajax({
            url: "components/function.cfc?method=logout",
            method: "POST",
            success: function(){
                window.location.href = "index.cfm";
            }
        });
    }
}
