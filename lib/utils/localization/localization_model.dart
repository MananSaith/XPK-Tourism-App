import 'package:get/get_navigation/src/root/internacionalization.dart';
class LocalizationModel extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'emailAddress': 'Email Address',
          'password': 'Password',
          'confirmPassword': 'Confirm Password',
          'login': 'Login',
          'signup': 'Signup',

          'forgotPassword': 'Forgot Password?',
          'doesNotHaveAccount': "Doesn't have an account?",
          'individual': 'Individual',
          'business': 'Business',
          'firstName': 'First Name',
          'lastName': 'Last Name',
          'alreadyHaveAccount': 'Already have an account?',
          'optVerification': 'OTP Verification',
          'optSend': 'We have send you a one time password on this Email.',
          'doNotReceiveCode': "Don't receive a code ? ",
          'sendOTP': 'Send OTP',
          'again': 'Again',
          'submit': 'Submit',
          //===================abdulmanan==================

          //sale agent regestration strings
          "titleReg":"Sales Agent Registration",
          "uploadProfilePhoto":"upload profile photo",
          "idCardNo":"ID Card Number",
          "idCardNohint":"abddefghij@gmail.com",
          "phoneNumber":"Phone Number",
          "phoneNumberhint":"031-313414334",
          "address":"Address",
          "addressHint":"13th Street. 47  New York,  USA. 20 Cooper Square.",
          "addBnakAcc":"Add bank account",
          "addAccountName":"Add Account Name",
          "addAccountNumber":"Add Account Number",
          "gallary":"Upload from gallery",
          "camera":"Take Photo",
          "register":"Register",

          // sale agent navigation screen
          "dashboard":"Dashboard",
          "message":"Meassage",
          "coupon":"Coupon",
          "search":"Search",
          "profile":"Profile",
          // sale agent dashboard
          "totalEarn":"Total Earned",
          "totalCommission":"Total Commission",

          //dashoard
          "searchScreen":"Search for products, brands, & categories",




          //===================abdulmanan==================
         
        },

        /// French or other Languages Strings
        'fr_FR': {
          'login': "login in French",
          'or': 'Or',
        }
      };
}
