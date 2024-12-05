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
                <a class = "nav-link" href="index.cfm">
                    <i class="fa-solid fa-right-to-bracket"></i>
                    <span>Login</span>
                </a>
            </li>
        </ul>
    </nav>
    <div class="container bg-white my-5 d-flex p-0 w-50 border-radius-20 shadow-heavy">
        <div class="left-content d-flex align-items-center flex-grow-1 justify-content-center">
            <img src="assets/designImages/addressbook.png" alt="addressbook">
        </div>
        <div class="right-content flex-grow-3">
            <div class="p-4 align-items-center d-flex flex-column">
                <div class="text-uppercase text-center login-title fs-2 mb-3">Sign up</div>
                <form method = "post" class = "align-items-center d-flex flex-column w-100" enctype="multipart/form-data">
                    <div class="w-100 py-4">
                        <input type="text" name="fullName" id="fullName" class="border-0 border-bottom w-100" placeholder="Full Name">
                        <div id="nameError" class="text-danger fw-bold"></div>
                    </div>
                    <div class="w-100 py-4">
                        <input type="text" name="email" id="email" class="border-0 border-bottom w-100" placeholder="Email ID">
                        <div id="emailError" class="text-danger fw-bold"></div>
                    </div>
                    <div class="w-100 py-4">
                        <input type="text" name="userName" id="userName" class="border-0 border-bottom w-100" placeholder="Username">
                        <div id="userNameError" class="text-danger fw-bold"></div>
                    </div>
                    <div class="w-100 py-4">
                        <input type="password" name="password" id="password" class="border-0 border-bottom w-100" placeholder="Password">
                        <div id="passwordError" class="text-danger fw-bold"></div>
                    </div>
                    <div class="w-100 py-4">
                        <input type="password" id="confirmPassword" class="border-0 border-bottom w-100" placeholder="Confirm password">
                        <div id="confirmpassError" class="text-danger fw-bold"></div>
                    </div>
                    <input type="file" name="profileImage" id="profileImage" accept="image/png, image/jpeg, image/webp">  
                    <div id="profileError" class="text-danger fw-bold"></div>             
                    <input type = "submit" value = "REGISTER" name = "submit" onclick = "return signupValidation()" class="rounded-pill login-btn form-control w-75 my-4 btn fw-bold">
                </form>
                <div>Already have an account? <a href="index.cfm" class="text-decoration-none">Login Here</a></div>
                <cfif structKeyExists(form, "submit")>
                    <cfset signupErrorMsg = application.objFunction.signup(
                        fullName = form.fullName,
                        email = form.email,
                        userName = form.userName,
                        password = form.password,
                        profileImage = form.profileImage
                    )>
                    <cfloop collection = "#signupErrorMsg#" item = "item">
                        <cfoutput>
                            <div class = "#item# mt-3 fw-bold">#signupErrorMsg[item]#</div>
                        </cfoutput>
                    </cfloop>
                </cfif>
            </div>
        </div>
    </div>
    <script src = "js/script.js"></script>
</body>
</html>