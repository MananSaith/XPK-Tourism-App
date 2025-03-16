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

  runApp(MyApp());
}
