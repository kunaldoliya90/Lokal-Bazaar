import 'package:ecomapp/features/authentication/screens/onboarding/login/login.dart';
import 'package:ecomapp/navigation_menu.dart';
import 'package:ecomapp/utils/constants/image_strings.dart';
import 'package:ecomapp/utils/constants/sizes.dart';
import 'package:ecomapp/utils/constants/text_strings.dart';
import 'package:ecomapp/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all((TSizes.defaultSpace)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image
              Image(
                image: const AssetImage(TImages.onboarding_image2),
                width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwSections * 2),
              // Title & Subtitle
              Text(
                TTexts.SuccessScreenTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems * 2),
              Text(
                'Congratulations! Start Shopping and Experience a World of Unrivaled Deals & Personalised offers.',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections * 3),
              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NavigationMenu()),
                  ),
                  child: const Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
