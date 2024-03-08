import 'package:ecomapp/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:ecomapp/navigation_menu.dart';
import 'package:ecomapp/utils/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool login = false;
  checkLogin() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        if (mounted) {
          setState(() {
            login = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            login = true;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //Here Continue---------------
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: login ? NavigationMenu() : OnBoardingScreen(),
    );
  }
}
