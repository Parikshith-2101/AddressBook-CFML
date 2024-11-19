<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Address Book</title>
    <link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>

<body>
    <nav class="navbar fixed-top p-0">
        <a href="#" class="nav-link">
            <div class="d-flex nav-brand align-items-center">
                <img src="assets/designImages/addressbook.png" alt="addressbook" width="40">
                <span class="fs-4">ADDRESS BOOK</span>
            </div>
        </a>
        <ul class="d-flex list-unstyled my-0">
            <li class="nav-item">
                <a class="nav-link" href="##" onclick="logout()">
                    <i class="fa-solid fa-right-to-bracket"></i>
                    <span>Logout</span>
                </a>
            </li>
        </ul>
    </nav>
    <cfoutput>
        <div class="container d-flex flex-column">
            <div class="bg-white d-flex rounded">
                <div class="d-flex p-3 ms-auto w-15 justify-content-around">
                    <a href=""><img src="assets/designImages/pdf.png" alt="pdf" width="30"></a>
                    <a href=""><img src="assets/designImages/excel.png" alt="excel" width="30"></a>
                    <a href="" onclick="window.print()"><img src="assets/designImages/printer.png" alt="print" width="30"></a>
                </div>
            </div>
            <div class="d-flex mt-4">
                <div class="userProfile d-flex flex-column bg-white p-3 align-items-center rounded">
                    <img src="assets/userProfileImages/#session.profileImage#" alt="profile" class="rounded-circle" width="80" height="80">
                    <p class="user-fullName text-uppercase my-3">#session.fullName#</p>
                    <button class="rounded-pill create-btn btn" data-bs-toggle="modal" data-bs-target="##createModal" onclick="createModal()">Create contact</button>
                </div>

                <div class="dashboard bg-white ms-3 rounded px-2 flex-grow">
                    <div class="header d-flex py-4 border-bottom">
                        <div class="profileImgDiv me-3"></div>
                        <div class="nameDiv title me-3">NAME</div>
                        <div class="emailDiv title me-3">EMAIL ID</div>
                        <div class="numberDiv title me-3">PHONE NUMBER</div>
                    </div>
                    <cfset local.contactList = application.objFunction.contactList()>
                    <cfloop query = "#local.contactList#">
                        <div class="d-flex border-bottom py-3 align-items-center">
                            <div class="profileImgDiv me-3">
                                <img src="assets/contactProfileImages/#profilephoto#" alt="profile" width="60">
                            </div>
                            <div class="nameDiv me-3">#local.contactList.firstName#</div>
                            <div class="emailDiv me-3">#local.contactList.email#</div>
                            <div class="numberDiv me-3">#local.contactList.mobile#</div>
                            <div class="d-flex justify-content-around flex-grow-1">
                                <button class="rounded-pill login-btn px-4 btn" data-bs-toggle="modal" data-bs-target="##createModal" onclick="editModal()">EDIT</button>
                                <button class="rounded-pill login-btn px-4 btn">DELETE</button>
                                <button class="rounded-pill login-btn px-4 btn" data-bs-toggle="modal" data-bs-target="##viewModal">VIEW</button>
                            </div>
                        </div>
                    </cfloop>
                </div>
            </div>
        </div>
        <!--view modal-->
        <div class="modal fade" id="viewModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
            aria-labelledby="viewModalLabel" aria-hidden="true">
            <div class="modal-dialog w-50">
                <div class="modal-content">
                    <div class="bg-lightblue d-flex px-3">
                        <div class="contact-details bg-white p-4 flex-grow-1 d-flex flex-column">
                            <div class="p-5 pb-3">
                                <div class="heading p-3 text-center">
                                    CONTACT DETAILS
                                </div>
                            </div>
                            <div class="p-4 d-flex flex-column line-height-2">
                                <div class="d-flex">
                                    <div class="details-div d-flex w-50 title fw-bold">Name<span
                                            class="ms-auto me-25">:</span>
                                    </div>
                                    <div class="w-50">Miss. Anjana S</div>
                                </div>
                                <div class="d-flex">
                                    <div class="details-div d-flex w-50 title fw-bold">Gender<span
                                            class="ms-auto me-25">:</span></div>
                                    <div class="w-50">Female</div>
                                </div>
                                <div class="d-flex">
                                    <div class="details-div d-flex w-50 title fw-bold">Date of birth<span
                                            class="ms-auto me-25">:</span></div>
                                    <div class="w-50">12/05/2021</div>
                                </div>
                                <div class="d-flex">
                                    <div class="details-div d-flex w-50 title fw-bold">Address<span
                                            class="ms-auto me-25">:</span></div>
                                    <div class="w-50">Thaliyal street , thiruvattar psot , kanyakukari</div>
                                </div>
                            </div>
                            <button class="rounded-pill w-25 mx-auto create-btn btn"
                                data-bs-dismiss="modal">close</button>
                        </div>
                        <div class="flex-grow-1 d-flex justify-content-center align-items-center">
                            <img src="assets/designImages/profile.png" alt="profile" width="100">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--create modal-->
        <div class="modal fade" id="createModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
            aria-labelledby="createModalLabel" aria-hidden="true">
            <div class="modal-dialog w-50">
                <div class="modal-content">
                    <div class="bg-lightblue d-flex px-3">
                        <div class="contact-details bg-white p-4 flex-grow-1 d-flex flex-column max-width-475">
                            <div class="p-5 pb-2">
                                <div class="heading p-3 text-center" id="modal-heading">
                                </div>
                            </div>
                            <form method="post" class="p-5 py-2" enctype="multipart/form-data">
                                <div class="d-flex flex-column line-height-2">
                                    <div class="subTitle mt-3 mb-1">Personal Contact</div>
                                    <div class="d-flex justify-content-between my-3">
                                        <div class="d-flex flex-column w-25">
                                            <label for="title" class="label-title">Title*</label>
                                            <select name="title" id="title">
                                                <option value=""></option>
                                                <option value="Mr.">Mr.</option>
                                                <option value="Mrs.">Mrs.</option>
                                            </select>
                                        </div>
                                        <div class="d-flex flex-column w-25">
                                            <label for="firstName" class="label-title">FirstName*</label>
                                            <input type="text" name = "firstName" placeholder="Your First Name" value="">
                                        </div>
                                        <div class="d-flex flex-column w-25">
                                            <label for="lastName" class="label-title">LastName*</label>
                                            <input type="text" name = "lastName" placeholder="Your Last Name">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between my-3">
                                        <div class="d-flex flex-column w-50 me-4">
                                            <label for="gender" class="label-title">Gender*</label>
                                            <select name="gender" id="gender">
                                                <option value=""></option>
                                                <option value="male">Male</option>
                                                <option value="female">Female</option>
                                            </select>
                                        </div>
                                        <div class="d-flex flex-column w-50">
                                            <label for="dob" class="text-nowrap label-title">Date Of Birth*</label>
                                            <input type="date" name = "dob">
                                        </div>
                                    </div>
                                    <div class="d-flex">
                                        <div class="d-flex flex-column">
                                            <label for="contactProfile" class="text-nowrap my-2 label-title">Upload Photo</label>
                                            <input type="file" name = "contactProfile">
                                        </div>
                                    </div>
                                    <div class="subTitle mt-3 mb-1">Contact Details</div>
                                    <div class="d-flex justify-content-between my-3">
                                        <div class="d-flex flex-column w-50 me-3">
                                            <label for="address" class="label-title">Address*</label>
                                            <input type="text" name="address" placeholder="Your address">
                                        </div>
                                        <div class="d-flex flex-column w-50">
                                            <label for="street" class="label-title">Street*</label>
                                            <input type="text" name="street" placeholder="Your Street Name">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between my-3">
                                        <div class="d-flex flex-column w-50 me-3">
                                            <label for="district" class="label-title">District*</label>
                                            <input type="text" name="district" placeholder="Your district">
                                        </div>
                                        <div class="d-flex flex-column w-50">
                                            <label for="state" class="label-title">State*</label>
                                            <input type="text" name="state" placeholder="Your state Name">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between my-3">
                                        <div class="d-flex flex-column w-50 me-3">
                                            <label for="country" class="label-title">Country*</label>
                                            <input type="text" name="country" placeholder="Your country">
                                        </div>
                                        <div class="d-flex flex-column w-50">
                                            <label for="pincode" class="label-title">Pincode*</label>
                                            <input type="tel" name="pincode" placeholder="Your pincode" maxlength="6">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between my-3">
                                        <div class="d-flex flex-column w-50 me-3">
                                            <label for="email" class="label-title">Email*</label>
                                            <input type="text" name="email" placeholder="Your email">
                                        </div>
                                        <div class="d-flex flex-column w-50">
                                            <label for="mobile" class="label-title">Mobile*</label>
                                            <input type="tel" name="mobile" placeholder="Your mobile" maxlength="10">
                                        </div>
                                    </div>
                                </div>
                                <cfif structKeyExists(form, "submit")>
                                    <cfset local.createResult = application.objFunction.createContact(
                                        form.title,form.firstName,form.lastName,form.gender,form.dob,
                                        form.contactProfile,form.address,form.street,form.district,form.state,
                                        form.country,form.pincode,form.email,form.mobile
                                    )>

                                    <cfloop collection="#local.createResult#" item="item">
                                        <div class = "my-3 text-center">
                                            <cfloop collection="#local.createResult#" item="item">
                                                <div class = "#item# fw-bold">#local.createResult[item]#</div>
                                            </cfloop>
                                        </div>
                                    </cfloop>
                                </cfif>
                                <div class="d-flex"> 
                                    <button class="rounded-pill mx-auto btn btn-success text-nowrap" type = "submit" name = "submit" onclick="return contactValidation()">Save Changes</button>
                                    <button class="rounded-pill w-25 mx-auto create-btn btn" data-bs-dismiss="modal">close</button>
                                </div>
                            </form>
                        </div>
                        <div class="flex-grow-1 d-flex justify-content-center mb-auto mt-5">
                            <img src="assets/designImages/profile.png" alt="profile" width="100">
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </cfoutput>
    <script src="js/script.js"></script>
    <script src="../bootstrap/js/bootstrap.min.js"></script>
    <script src="../jquery/jquery-3.7.1.min.js"></script>
</body>

</html>