import 'package:get/get.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class UserSignupDataController extends GetxController {
  RxString newPassword = "".obs;
  RxString userName = "".obs;
  RxString birthday = "Birthday".obs;
  RxString selectedGender = 'Male'.obs; // RxString to hold the selected gender
  RxString email = "".obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isPasswordConfirmVisible = false.obs;
  RxBool isRememberMe = false.obs;
  var imagePath = "".obs;
  Rxn<Uint8List> byte = Rxn<Uint8List>();




  

  //%%%%%%%%%%%%%%%%%%%%%%%%%%% firebse functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  final FirebaseAuth _auth = FirebaseAuth.instance;
var check = false.obs;

 void login() async {
    check(true);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.value,
        password: newPassword.value,
      );

      // Check if email is verified
      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        check(false);
       // Get.offNamed(Routes.home);
      } else {
        check(false);
        await _auth.signOut(); // Sign out the user if not verified
        Get.offAllNamed(AppRoutes.login);
        Get.snackbar("Error", "Email not verified. Please verify your email.");
      }
    } catch (e) {
      check(false);
      Get.snackbar("Error", e.toString());
    }
  }













  //%%%%%%%%%%%%%%%%%%%% supportive functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  // Use FilePickerHelper to pick an image
  Future<void> pickImage() async {
    PlatformFile? image = await FilePickerHelper.pickImage();
    if (image != null) {
      // Read the file bytes manually if image.bytes is null
      if (image.bytes == null && image.path != null) {
        byte.value = await File(image.path!).readAsBytes();
      } else {
        byte.value = image.bytes;
      }
      imagePath.value = image.path!;
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
    } else if (value.length < 8) {
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
