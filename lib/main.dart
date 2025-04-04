//import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:xpk/app/my_app.dart';
import 'package:xpk/config/binding_routing/app_bindings.dart';
import 'package:xpk/utils/fireBase_option/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AuthBinding().dependencies();
 // initAppCheck();
  runApp(MyApp());
}
// void initAppCheck() async {
//   await FirebaseAppCheck.instance.activate(
//     androidProvider:
//         AndroidProvider.debug, 
//     webProvider: ReCaptchaV3Provider(''), 
//   );
// }
