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
function loginValidation(){
    let userName = document.getElementsByName("userName")[0].value;
    let password = document.getElementsByName("password")[0].value;
    let nameError = document.getElementById("userName-error");
    let passError = document.getElementById("password-error");
    nameError.textContent = "";
    passError.textContent = "";
    let emailCheck = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    let isValid = true;
    if(userName === '' || !emailCheck.test(userName)){
        nameError.textContent = "Please Enter a valid email";
        isValid = false;
    }
    if(password === ''){
        passError.textContent = "please enter ur password";
        isValid = false;
    }
    if(isValid == false){
        event.preventDefault();
    }
}
function signupValidation(){
    let fullName = document.getElementById("fullName").value;
    let email = document.getElementById("email").value;
    let userName = document.getElementById("userName").value;
    let password = document.getElementById("password").value;
    let confirmpass = document.getElementById("confirmPassword").value;
    let profileImage = document.getElementById("profileImage").value;
    let nameError = document.getElementById("nameError");
    let emailError  = document.getElementById("emailError");
    let userNameError = document.getElementById("userNameError");
    let passError = document.getElementById("passwordError");
    let confirmpassError = document.getElementById("confirmpassError");
    let profileError = document.getElementById("profileError");
    nameError.textContent = "";
    emailError.textContent = "";
    userNameError.textContent = "";
    passError.textContent = "";
    confirmpassError.textContent = "";
    profileError.textContent = "";
    let isValid = true;

    if(fullName === "" || fullName.length < 3){
        nameError.textContent = "Enter valid Name";
        isValid = false;
    }
    let emailCheck = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if(email === "" || !emailCheck.test(email)){
        emailError.textContent = "Enter valid Email";
        isValid = false;
    }
    if(userName === "" || !emailCheck.test(userName)){
        userNameError.textContent = "Enter a valid Username";
        isValid = false;
    }
    let passCheck = /^(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%&*]{6,20}$/;
    if(password === "" || !passCheck.test(password)){
        passError.textContent = "Enter a Strong password";
        isValid = false;
    }
    if(confirmpass !== password || confirmpass === ""){
        confirmpassError.textContent = "password missmatch";
        isValid = false;
    }
    if(!profileImage){
        profileError.textContent = "choose any image file";
        isValid = false;
    }
    if(isValid == false){
        event.preventDefault();
    }
}

function contactValidation(){
    let title = document.getElementById("title");
    let firstName = document.getElementsByName("firstName")[0];
    let lastName = document.getElementsByName("lastName")[0];
    let gender = document.getElementById("gender");
    let dob = document.getElementsByName("dob")[0];
    let address = document.getElementsByName("address")[0];
    let street = document.getElementsByName("street")[0];
    let district = document.getElementsByName("district")[0];
    let state = document.getElementsByName("state")[0];
    let country = document.getElementsByName("country")[0];
    let pincode = document.getElementsByName("pincode")[0];
    let email = document.getElementsByName("email")[0];
    let number = document.getElementsByName("mobile")[0];
    let isValid = true;

    if(title.value === ""){
        title.parentElement.style.border = "1px solid #ff0000";
        title.parentElement.style.background = "#fdb1b1";
        isValid = false;
    }
    else{
        title.parentElement.style.border = "unset";
        title.parentElement.style.background = "unset";
    }

    if(firstName.value === "" || firstName.value.length < 3){
        firstName.parentElement.style.border = "1px solid #ff0000";
        firstName.parentElement.style.background = "#fdb1b1";
        isValid = false;
    }
    else{
        firstName.parentElement.style.border = "unset";
        firstName.parentElement.style.background = "unset";
    }

    if(lastName.value === "" || lastName.value.length < 3){
        lastName.parentElement.style.border = "1px solid #ff0000";
        lastName.parentElement.style.background = "#fdb1b1";
        isValid = false;
    }
    else{
        lastName.parentElement.style.border = "unset";
        lastName.parentElement.style.background = "unset";
    }
    
    if(gender.value === ""){
        gender.parentElement.style.border = "1px solid #ff0000";
        gender.parentElement.style.background = "#fdb1b1";
        isValid = false;
    }
    else{
        gender.parentElement.style.border = "unset";
        gender.parentElement.style.background = "unset";
    }

    if(dob.value === ""){
        dob.parentElement.style.border = "1px solid #ff0000";
        dob.parentElement.style.background = "#fdb1b1";
        isValid = false;
    }
    else{
        dob.parentElement.style.border = "unset";
        dob.parentElement.style.background = "unset";
    }

    if(address.value === "" || address.value.length < 5){
        address.parentElement.style.border = "1px solid #ff0000";
        address.parentElement.style.background = "#fdb1b1";
        isValid = false;
    }
    else{
        address.parentElement.style.border = "unset";
        address.parentElement.style.background = "unset";
    }

    if(street.value === "" || street.value.length < 5){
        street.parentElement.style.border = "1px solid #ff0000";
        street.parentElement.style.background = "#fdb1b1";
        isValid = false;
    }
    else{
        street.parentElement.style.border = "unset";
        street.parentElement.style.background = "unset";
    }

    if(district.value === "" || district.value.length < 5){
        district.parentElement.style.border = "1px solid #ff0000";
        district.parentElement.style.background = "#fdb1b1";
        isValid = false;
    }
    else{
        district.parentElement.style.border = "unset";
        district.parentElement.style.background = "unset";
    }

    if(state.value === "" || state.value.length < 5){
        state.parentElement.style.border = "1px solid #ff0000";
        state.parentElement.style.background = "#fdb1b1";
        isValid = false;
    }
    else{
        state.parentElement.style.border = "unset";
        state.parentElement.style.background = "unset";
    }

    if(country.value === "" || country.value.length < 5){
        country.parentElement.style.border = "1px solid #ff0000";
        country.parentElement.style.background = "#fdb1b1";
        isValid = false;
    }
    else{
        country.parentElement.style.border = "unset";
        country.parentElement.style.background = "unset";
    }
    if(pincode.value === "" || pincode.value.length > 6){
        pincode.parentElement.style.border = "1px solid #ff0000";
        pincode.parentElement.style.background = "#fdb1b1";
        isValid = false;
    }
    else{
        pincode.parentElement.style.border = "unset";
        pincode.parentElement.style.background = "unset";
    }
    if(email.value === "" || !/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email.value)){
        email.parentElement.style.border = "1px solid #ff0000";
        email.parentElement.style.background = "#fdb1b1";
        isValid = false;
    }
    else{
        email.parentElement.style.border = "unset";
        email.parentElement.style.background = "unset";
    }
    if(number.value === "" || !NaN(number.value)){
        number.parentElement.style.border = "1px solid #ff0000";
        number.parentElement.style.background = "#fdb1b1";
        isValid = false;
    }
    else{
        number.parentElement.style.border = "unset";
        number.parentElement.style.background = "unset";
    }
    if(!isValid){
        event.preventDefault();
    }
}
function editModal(){
    document.getElementById("modal-heading").innerText = "EDIT CONTACT";
}
function createModal(){
    document.getElementById("modal-heading").innerText = "CREATE CONTACT";
}
