//import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpk/app/my_app.dart';
import 'package:xpk/config/binding_routing/app_bindings.dart';
import 'package:xpk/utils/constant/storage_constant.dart';
import 'package:xpk/utils/fireBase_option/firebase_options.dart';

final googleSaveBox = GetStorage(StorageConst.googleSave);
//final postSaveBox = GetStorage(StorageConst.postSave);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  AuthBinding().dependencies();
  runApp(MyApp());
}

