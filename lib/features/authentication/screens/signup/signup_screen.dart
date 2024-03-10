import 'package:ecomapp/common/styles/spacing_styles.dart';
import 'package:ecomapp/features/authentication/screens/signup/success_screen.dart';
import 'package:ecomapp/utils/constants/colors.dart';
import 'package:ecomapp/utils/constants/image_strings.dart';
import 'package:ecomapp/utils/constants/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool rememberMe = false;
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signUp() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Update user profile with first name and last name
        await user.updateDisplayName('${fname.text} ${lname.text}');
        // await user.updatePhoneNumber(PhoneAuthProvider.PHONE_SIGN_IN_METHOD as PhoneAuthCredential);
        // You can also update other user information here

        // Navigate to success screen after successful sign-up
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SuccessScreen()),
        );
      }
    } catch (e) {
      print('Error signing up: $e');
      // Handle sign-up errors here
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.defaultSpace,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's create your account",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          // vertical: TSizes.spaceBtwInputFields,
                          // horizontal: TSizes.spaceBtwInputFields,
                          ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 60, // Adjust the height as needed
                                  child: TextFormField(
                                    controller: fname,
                                    style: const TextStyle(
                                        fontSize: TSizes.fontSizeMd),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Iconsax.user),
                                      labelText: "First Name",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: TSizes.spaceBtwItems),
                              Expanded(
                                child: SizedBox(
                                  height: 60, // Adjust the height as needed
                                  child: TextFormField(
                                    controller: lname,
                                    style: const TextStyle(
                                        fontSize: TSizes.fontSizeMd),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Iconsax.user),
                                      labelText: "Last Name",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(height: TSizes.spaceBtwSections),
                          // SizedBox(
                          //   height: 60, // Adjust the height as needed
                          //   child: TextFormField(
                          //     style:
                          //         const TextStyle(fontSize: TSizes.fontSizeMd),
                          //     decoration: const InputDecoration(
                          //       prefixIcon: Icon(Iconsax.user),
                          //       labelText: "Username",
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: TSizes.spaceBtwSections),
                          SizedBox(
                            height: 60, // Adjust the height as needed
                            child: TextFormField(
                              controller: email,
                              style:
                                  const TextStyle(fontSize: TSizes.fontSizeMd),
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.direct_right),
                                labelText: "Email",
                              ),
                            ),
                          ),
                          SizedBox(height: TSizes.spaceBtwSections),
                          SizedBox(
                            height: 60, // Adjust the height as needed
                            child: TextFormField(
                              controller: phone,
                              style:
                                  const TextStyle(fontSize: TSizes.fontSizeMd),
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.mobile),
                                labelText: "Phone Number",
                              ),
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwSections),
                          SizedBox(
                            height: 60, // Adjust the height as needed
                            child: TextFormField(
                              controller: password,
                              style:
                                  const TextStyle(fontSize: TSizes.fontSizeMd),
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.password_check),
                                labelText: "Password",
                              ),
                            ),
                          ),
                          SizedBox(height: TSizes.spaceBtwSections),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value!;
                                  });
                                },
                              ),
                              const Text.rich(
                                TextSpan(
                                  text: "I Agree to ",
                                  style: TextStyle(
                                      fontSize:
                                          13), // Adjust the font size as needed
                                  children: [
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                    ),
                                    TextSpan(text: " and "),
                                    TextSpan(
                                      text: "Terms of Use",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: TSizes.spaceBtwSections),
                          SizedBox(
                            width: double
                                .infinity, // Set the width to match the TextFormField
                            child: ElevatedButton(
                              onPressed: signUp,
                              child: isLoading
                                  ? CircularProgressIndicator(color: Colors.white,)
                                  : Text('Create Account'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
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
                      SizedBox(width: TSizes.spaceBtwSections),
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
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
