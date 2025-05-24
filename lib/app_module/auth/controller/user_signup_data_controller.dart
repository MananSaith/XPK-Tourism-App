import 'dart:convert';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xpk/utils/imports/app_imports.dart';

import '../widget/dialogbox.dart';

class AuthController extends GetxController {
  RxString newPassword = "".obs;
  RxString userName = "".obs;
  RxString birthday = "Birthday".obs;
  RxString selectedGender = 'Male'.obs; // RxString to hold the selected gender
  RxString email = "".obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isPasswordConfirmVisible = false.obs;
  RxBool isRememberMe = false.obs;
  Rx<File?> image = Rx<File?>(null); // Initialize with null
  var profileImageUrl = ''.obs;
  //Rxn<Uint8List> byte = Rxn<Uint8List>();

  //%%%%%%%%%%%%%%%%%%%%%%%%%%% firebse functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var check = false.obs;


  void login() async {
    check(true);
    debugPrint(
        "Trying to login with Email: ${email.value}, Password: ${newPassword.value}");

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.value.trim(),
        password: newPassword.value.trim(),
      );

      User? user = userCredential.user;
      check(false);

      if (user != null) {
        //debugPrint("Login successful: UID = ${user.uid}");
        checkEmailVerification();
      } else {
        debugPrint("Login failed: No user returned.");
      }
    } catch (e) {
      check(false);
      debugPrint("Login error: $e");
      Get.snackbar("Error", "Invalid email or password.");
    }
  }

  Future<void> signup() async {
   if(!(await  requestMediaPermission())){
     return;
   }

  check(true);
  try {
    UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
      email: email.value.trim(),
      password: newPassword.value.trim(),
    );
    await userCredential.user?.sendEmailVerification();
print("111111111111111111111111111111111111");
    User user = userCredential.user!;
    print("22222222222222222222222222222222222");

    await UploadImage();
    print("333333333333333333333333333333333");

    await _saveUserToFirestore(user);
    print("4444444444444444444444444444444444444444444444");


    check(false);
    showEmailVerificationDialog(email.value.trim());
    Get.snackbar("Success", "Account created! Please verify your email.");
  } on FirebaseAuthException catch (e) {
    check(false);
    if (e.code == 'email-already-in-use') {

      User? currentUser = _auth.currentUser;
      if (currentUser != null && currentUser.email == email.value.trim()) {
  
        if (!currentUser.emailVerified) {
          await currentUser.sendEmailVerification();
          Get.snackbar("Verification Sent", "Please check your email for verification.");
        } else {
          Get.snackbar("Info", "Your email is already verified. Try logging in.");
        }
      } else {
        Get.snackbar("Error", "This email is already registered. Try logging in.");
      }
    } else {
      Get.snackbar("Error", e.message ?? "Signup failed. Please try again.");
    }
  } catch (e) {
    check(false);
    Get.snackbar("Error", "An unexpected error occurred.");
  }
  check(false);
}


  void checkEmailVerification() async {
    User? user = _auth.currentUser;
    await user?.reload();
    if (user != null && user.emailVerified) {
      Get.offAllNamed(AppRoutes.navigateScreen);
    } else {
      Get.snackbar("Error", "Email not verified yet.");
    }
  }

  Future<void> _saveUserToFirestore(User user) async {
    await _firestore.collection('users').doc(user.uid).set({
      'username': userName.value,
      'email': user.email,
      "password": newPassword.value,
      "birthday": birthday.value,
      "gender": selectedGender.value,
      "profileImageUrl": profileImageUrl.value,
      "uid": user.uid,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }
  Future<void> UploadImage() async {
    try {
      File? imageFile = image.value;
      Uint8List? bytes = await imageFile?.readAsBytes();
      String base64String = base64Encode(bytes!);
      String downloadUrl = base64String;

      profileImageUrl.value = downloadUrl;
    } catch (e) {
      print("Image upload failed: ${e.toString()}");
      throw Exception("Image upload failed: ${e.toString()}");
    }
  }
  void resetPassword() async {
    if (email.value.isEmpty) {
      Get.snackbar("Error", "Please enter your email address.");
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email.value);
      Get.snackbar(
        "Success",
        "Password reset email sent. Please check your inbox.",
      );
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  bool isLoggedIn() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.emailVerified; // Ensure email is verified
    }
    return false;
  }

  //%%%%%%%%%%%%%%%%%%%% supportive functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  // Use FilePickerHelper to pick an image
  Future<void> pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.isNotEmpty) {
      // Convert PlatformFile to File
      File selectedFile = File(result.files.single.path!);
      image.value = selectedFile; // Update Rx<File?>
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    // Simple email regex validation
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Enter a valid email';
    }

    return null;
  }

  String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != password) {
      return 'Passwords do not match';
    }
    return null; // Return null if the passwords match
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(
            r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(value)) {
      return 'Password must contain at least one letter, one number, and one special character';
    }
    return null; // Return null if the input is valid
  }

  Widget genderContainer(String text) {
    return Obx(() {
      return CustomContainer(
        child: TextWidget(
          overFlow: true,
          text: text,
          fSize: Responsive.fontSize(Get.context!, 16),
          textColor: selectedGender.value == text
              ? AppColors.primaryAppBar
              : Colors.white,
        ),
        onTap: () {
          selectGender(text);
        },
        borderRadius: BorderRadius.circular(50),
        borderColor: selectedGender.value == text
            ? AppColors.primaryAppBar
            : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      );
    });
  }

  String? validUserName(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return 'User Name cannot be empty';
    } else if (value.length < 5) {
      return 'User Name must be at least 8 characters long';
    }
    return null; // Return null if the passwords match
  }

  Future<void> selectBirthday(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime twelveYearsAgo = DateTime(today.year - 12, today.month, today.day);

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: twelveYearsAgo, // Default to the max valid date
      firstDate: DateTime(1900),
      lastDate: today, // Ensure no future dates are selectable
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primaryAppBar,
            hintColor: AppColors.primaryAppBar,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      // Check if selected date results in an age of 12 or above
      if (selectedDate.isAfter(twelveYearsAgo)) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Age must be 12 years or above."),
            backgroundColor: Colors.red,
          ),
        );
        return; // Prevent further execution
      }

      // If valid, set the birthday
      birthday.value =
          "${selectedDate.toLocal()}".split(' ')[0]; // Format as YYYY-MM-DD
    }
  }
}
