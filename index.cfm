<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Address Book</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <nav class="navbar fixed-top p-0">
        <a href="" class="nav-link">
            <div class="d-flex nav-brand">
                <img src="assets/designImages/addressbook.png" alt="addressbook" width="40">
                <span class="fs-4">ADDRESS BOOK</span>
            </div>
        </a>
        <ul class = "d-flex list-unstyled my-0">
            <li class = "nav-item">
                <a class = "nav-link" href = "signup.cfm">
                    <i class="fa-solid fa-user-plus"></i>
                    <span>Sign Up</span>
                </a>
            </li>
            <li class = "nav-item">
                <a class = "nav-link" href = "index.cfm">
                    <i class="fa-solid fa-right-to-bracket"></i>
                    <span>Login</span>
                </a>
            </li>
        </ul>
    </nav>
    <div class="container my-5 mt-3 d-flex p-0 w-50 bg-white border-radius-20 shadow-heavy">
        <div class="left-content d-flex align-items-center flex-grow-1 justify-content-center">
            <img src="assets/designImages/addressbook.png" alt="addressbook">
        </div>
        <div class="right-content flex-grow-3">
            <div class="p-4 align-items-center d-flex flex-column">
                <div class="text-uppercase text-center login-title fs-2 mb-3">Login</div>
                <form method = "post" class = "align-items-center d-flex flex-column w-100" enctype="multipart/form-data">
                    <div class="w-100 py-4">
                        <input type="text" name="userName" class="border-0 border-bottom w-100" placeholder="username">
                        <div id = "userName-error" class="text-danger fw-bold"></div>
                    </div>
                    <div class="w-100 py-4">
                        <input type="password" name="password" class="border-0 border-bottom w-100" placeholder="password">
                        <div id = "password-error" class="text-danger fw-bold"></div>
                    </div>
                    <input type = "submit" value = "LOGIN" onclick = "return loginValidation()" name = "submit" class="rounded-pill login-btn form-control w-75 my-4 btn fw-bold">
                    <div>Or Sign In Using </div>
                    <div class="d-flex align-items-center">
                        <a href="" class="me-1 py-3"><img src="assets/designImages/fb-icon.png" alt="fbIcon" width="50"></a>
                        <button class="py-3 btn" type = "submit" name = "googleSignin"><img src="assets/designImages/gmail-icon.png" alt="gmailIcon" width="50" class="g-img"></button>
                    </div>
                </form>
                <div>Don't have an account? <a href="signup.cfm" class="text-decoration-none">Register Here</a></div>
                <cfoutput>
                    <cfif structKeyExists(form, "submit")>
                        <cfset local.result = application.objFunction.login(form.userName,form.password)>
                        <cfloop collection="#local.result#" item="item">
                            <div class = "#item# fw-bold fs-3">#local.result['#item#']#</div>
                        </cfloop>
                    </cfif>
                </cfoutput>
            </div>
        </div>
        <cfif structKeyExists(form, "googleSignin")>
            <cflocation  url="googleSSO.cfm">
        </cfif>
    </div>
	<script src="jquery/jquery-3.7.1.min.js"></script>
    <script src="js/script.js"></script>
</body>
</html>