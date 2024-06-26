import 'package:ecomapp/common/styles/spacing_styles.dart';
import 'package:ecomapp/features/authentication/screens/forgotPass/pass_reset_scree.dart';
import 'package:ecomapp/features/authentication/screens/signup/signup_screen.dart';
import 'package:ecomapp/navigation_menu.dart';
import 'package:ecomapp/utils/constants/colors.dart';
import 'package:ecomapp/utils/constants/image_strings.dart';
import 'package:ecomapp/utils/constants/sizes.dart';
import 'package:ecomapp/utils/constants/text_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Navigate to NavigationMenu after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationMenu()),
      );
    } catch (e) {
      print('Error signing in: $e');
      // Handle sign-in errors here
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image:
                        AssetImage('assets/images/onboarding_images/logo.png'),
                    height: MediaQuery.of(context).size.width/3.5,
                    width: MediaQuery.of(context).size.width/2,
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                    TTexts.loginTitle,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/25,
                  ),
                  Text(
                    TTexts.loginSubTitle,
                    style: Theme.of(context).textTheme.headlineSmall!,
                  )
                ],
              ),
              SizedBox(
                    height: MediaQuery.of(context).size.width/20,
                  ),
              Form(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: TSizes.spaceBtwSections),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: "Enter your email.",
                      ),
                      style: TextStyle(
                          fontSize: 15), // Adjust the font size as needed
                    ),
                    SizedBox(height: TSizes.spaceBtwInputFields),
                    SizedBox(
                      height: 60, // Adjust the height as needed
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.password_check),
                          labelText: "Enter your password.",
                          suffixIcon: Icon(Iconsax.eye_slash),
                        ),
                        style: TextStyle(
                            fontSize: 15), // Adjust the font size as needed
                      ),
                    ),

                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields / 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value!;
                                });
                              },
                            ),
                            const Text(
                              "Remember me",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        TextButton(
                            onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const PasswordResetScreen()),
                                ),
                            child: const Text(
                              'Forget Password',
                              style: TextStyle(fontSize: 15),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                    // Sign In button
                    SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => TColors.primary)),
                          onPressed: signIn,
                          child: isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  'Sign In',
                                  style: TextStyle(color: Colors.white),
                                ),
                        )),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                              );
                            },
                            child: const Text("Create Account")))
                  ],
                ),
              )),
              // Divider

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Divider(
                      color: TColors.grey,
                      thickness: 0.5,
                      indent: 60,
                      endIndent: 5,
                    ),
                  ),
                  Text("Or Sign in With",
                      style: Theme.of(context).textTheme.labelMedium),
                  const Flexible(
                    child: Divider(
                      color: TColors.grey,
                      thickness: 0.5,
                      indent: 5,
                      endIndent: 60,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              // Footer

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: TColors.grey),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Image(
                        height: TSizes.iconMd,
                        width: TSizes.iconMd,
                        image: AssetImage(TImages.google),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwSections,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: TColors.grey),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Image(
                        height: TSizes.iconMd,
                        width: TSizes.iconMd,
                        image: AssetImage(TImages.facebook),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
