import 'package:ecomapp/features/authentication/screens/signup/success_screen.dart';
import 'package:ecomapp/utils/constants/image_strings.dart';
import 'package:ecomapp/utils/constants/sizes.dart';
import 'package:ecomapp/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const Image(image: AssetImage(TImages.onboarding_image2)),

              // Title and subtitle
              Text(
                TTexts.VerifyEmailScreenTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Text(
                TTexts.VerifyEmailScreenEmail,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Text(
                TTexts.VerifyEmailScreenSubTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Buttons

              SizedBox(
                width:
                    double.infinity, // Set the width to match the TextFormField
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SuccessScreen(),
                      ),
                    );
                  },
                  child: const Text("Continue"),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Resend Email',
                    style: TextStyle(fontSize: 15),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
