import 'package:ecomapp/app.dart';
// import 'package:ecomapp/utils/constants/colors.dart';
// import 'package:ecomapp/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

void main() async {
//adding comments
//adding comments WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}
