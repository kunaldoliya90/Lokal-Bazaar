import 'package:ecomapp/utils/constants/image_strings.dart';
import 'package:ecomapp/utils/constants/sizes.dart';
import 'package:ecomapp/utils/constants/text_strings.dart';
import 'package:ecomapp/utils/helpers/helper_function.dart';
import 'package:ecomapp/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: const [
              OnBoardingPage(
                image: TImages.onboarding_image1,
                title: Texts.onBoardingTitle1,
                subTitle: Texts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onboarding_image2,
                title: Texts.onBoardingTitle2,
                subTitle: Texts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onboarding_image1,
                title: Texts.onBoardingTitle3,
                subTitle: Texts.onBoardingSubTitle3,
              )
            ],
          )
        ],
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
              width: THelperFunctions.screenWidth() * 0.8,
              height: THelperFunctions.screenHeight() * 0.6,
              image: AssetImage(image)),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
