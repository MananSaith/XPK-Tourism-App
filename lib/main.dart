import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:xpk/app/my_app.dart';
import 'package:xpk/config/binding_routing/app_bindings.dart';
import 'package:xpk/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AuthBinding().dependencies();
  initAppCheck();
  runApp(MyApp());
}

void initAppCheck() async {
  await FirebaseAppCheck.instance.activate(
    androidProvider:
        AndroidProvider.debug, 
    webProvider: ReCaptchaV3Provider(''), 
  );
}

/*

git commit -m "feat: Add city and type filters, setup time-based model

- Added city filter for more precise search results.
- Implemented type filter to refine place categories.
- Set up initial model structure for time-based filtering."


start ::::
login error pending
home ma time duration tab ko set karna hai time duration sara para hai 

*/
