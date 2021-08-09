//
//  AppMessage.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import Foundation

let _appName        = "Gradex"

// MARK: Web Operation
let kInternetDown  = "No Internet Connection"
let kConnecting    = "connecting..."
let kHostDown      = "your host seems to be down"
let kTimeOut       = "the request timed out"
let kInternalError      = "internal server error"
let kTokenExpire        = "token expire please login again"


// MARK: Login Registration and OTP
let kSelectLang             = "Select Language"



// MARK: Login Registration and OTP
let kEnterName              = "Enter your name"
let kInvalidName            = "Enter a valid name"
let kEnterEmail             = "Enter your email"
let kEnterUserName             = "Enter username"
let kInvalidEmail           = "Enter valid email address"
let kEnterPassword          = "please enter a password"
let kInvalidPassword        = "Enter valid password"
let kEnterOTP               = "Enter OTP"
let KUserLocation           = "Please select location"


// MARK: Permission
let kCameraAccessTitle   = "no camera access"
let kCameraAccessMsg     = "please go to settings and switch on your Camera. settings -> \(_appName) -> switch on camera"
let kPhotosAccessTitle   = "no photos access"
let kPhotosAccessMsg     = "please go to settings and switch on your photos. settings -> \(_appName) -> switch on photos"
let kCameraNotAvailable  = "this device does not have a camera"
let kUnknowedErrorFound  = "an unknown error occurred"


// MARK: Login
let kLoginHeader            = "Hello there,\n Sign in to continue!"
let kEmailPlaceHolder        = "Email Address"
let kPasswordPlaceHolder     = "Password"
let kStayConnected          = "Stay Connected"
let kForgotPassword         = "Forgot Password?"
let kSignIn                 = "SIGN IN"
let kSignUp                 = "Sign Up"
let kDonthaveanaccount      = "Don’t have an account?"

// MARK: OTP
let kOTPHeader            = "Please enter verification code sent to your Email address."
let kdidntreceivecode      = "If you didn't receive a code !"
let kResend              = "Resend Code"

// MARK: ForgotPass
let kForgotHeader            = "Enter the register email address associated with your account."
let kSendEmail              = "SEND EMAIL"

// MARK: ResetPass
let kResetHeader                 = "Create Your New Password"
let kCnfrmPasswordPlaceHolder     = "Confirm Password"
let kSavePassword                = "SAVE NEW PASSWORD"

// MARK: ChangePass
let kChangeHeader                 = "Modify Your Current Password"
let kCurrPassPlaceHolder            = "Current Password"
let kChangePassword                = "CHANGE PASSWORD"

// MARK: Register - 1
let kBasicInfoHeader            =  "Basic Information Company"
let kAddCompLogo                = "Add Your Company Logo"
let kAccountingDate            = "Accounting Date"
let kTaxable                   = "Taxable"
let kEnterCompanyName           = "Company Name"
let kVatId                      = "VAT ID No."
let kRegistrationNumber        = "Registration number"
let kLegalForm                 = "Legal form"
let kNoOfEmployees               = "Number of Employees"

// MARK: Register - 2
let kBasicEntreHeader      =  "Basic information Entrepreneur"
let kAddProfile           = "Add Your Profile Picture"
let kEnterFirstName        = "First name"
let kEnterLastName         = "Last name"
let kEnterAddress         = "Enter Address"
let kEnterAddress2         = "Address 2"
let kCountry              = "Country"
let kPostcode             = "Postcode"
let kMobile               = "Phone"

// MARK: Register - 3 //Add Bank
let kAddBankHeader         =  "Basic Bank Information"
let kBankName              = "Bank Name"
let kBCNumber              = "BC Number"
let kBIC                   = "BIC / Swift Code"
let kAccountNo             = "Account number"
let kIBAN                  = "IBAN"
let kCurrency              = "Currency"
let kCash                  = "Cash"
let kSelectACBalance        = "Select Account Balance"
let kAddBank               = "ADD BANK"
let kEditBank               = "EDIT BANK"

// MARK: Register - 4 // Add Kasa
let kAddkasaHeader         =  "Basic Kassa Information"
let kAddKasa               = "ADD KASSA"
let kEditKasa               = "EDIT KASSA"

// MARK: SlideMenu
let kAboutPresenta         = "About Presenta"
let kTeam                 = "Team"
let kNewsBlog             = "News/Blogs"
let kEvent                = "Events"
let kContactUs            = "Contact Us"
let kMore                 = "More"
let kProfile              = "Profile"
let kNotification          = "Notification"
let kPrivacyPolicy         = "Privacy Policy"
let kTermsCondition        = "Terms & Condition"
let kMoreChangePassword    = "Change Password"
let kLogout               = "Logout"

// MARK: Task
let kPending                = "Pending"
let kInProgress             = "In Progress"
let kCompleted              = "Completed"

// MARK: TaskDetail
let kAgent                  = "Agent"
let kDocument               = "Documents"
let kStatement              = "Statements"

// MARK: Document
let kDocStatement           = "Document Statements"
let kSelectService          = "Select Service"
let kInvoiceDate            = "Invoice Date"
let kAccountingCat          = "Select Accounting Category"
let kAccountingSubCat       = "Select Accounting Sub-Category"

// MARK: Team
let kPortfolio              = "Portfolio"
let kReview                 = "Review"

// MARK: DropDown Type
let kSelectCountry         = "Select Country"
let kSelectCurrency        = "Select Currency"
let kSelectlegalForm       = "Select Legal Form"

// MARK: Other
let kCancel                = "Cancel"
let kYes                   = "Yes"
let kDelete                = "Delete"
let kEdit                  = "Edit"

// MARK: Registration Validation
let kEnterNoOfEmployees     = "Enter Number of Employees"
let kEnterRegistrationNumber = "Enter Registration number"
let kEnterVatId             = "Enter VAT ID No."
let kEnterFullName          = "Enter full name"
let kEnterMobile            = "Please enter mobile number"
let kMobileInvalid          = "Enter valid mobile number"
let kVerificationCodeSent   = "verification code sent"
let kUsernameSmaller        = "username must contain at lease three characters"
let kUsernameBigger         = "15 characters max"
let kPasswordSmall          = "6 characters min"
let kEnterSubject           = "Enter subject"
let kEnterMessage           = "Enter message"
let kEnterCompName          = "Enter Company Name"
let kInvalidUsername        = "Enter valid username"
let kEnterDob              = "Enter your Date"
let kEnterPrice             = "Enter your Price"
let kEnterCity             = "Enter your City"
let kEnterQty             = "Enter your Quantity"
let kPasswordBig            = "15 characters max"
let kSelectOffer           = "please select offers on email"
let kSelectTerms           = "please select privacy policy & terms"
let kPasswordNotMatch       = "password not same"
let kAppId                  = "1525174514"
let kShareAppURL            = "https://itunes.apple.com/us/app/\(_appName)/\(kAppId)?ls=1&mt=8"

// MARK: Profile
let kEnterMFax              = "Enter fax number"
let kEnterPostCode           = "Enter Post Code"

let kAppURL            = "https://apps.apple.com/us/app/id1525174514"


// MARK:- Menu updation

let kUpdateLanguage = "Language updated successfully."
let kUpdateFailedLanguage = "Something went wrong while updation.Please try again later."
