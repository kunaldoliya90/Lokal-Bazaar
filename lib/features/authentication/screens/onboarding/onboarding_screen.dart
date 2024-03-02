import 'package:ecomapp/features/authentication/controllers/controller_onboarding/onboardingcontroller.dart';
import 'package:ecomapp/features/authentication/screens/onboarding/widgets/onboarding_navigation.dart';
import 'package:ecomapp/features/authentication/screens/onboarding/widgets/onboarding_next.dart';
import 'package:ecomapp/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:ecomapp/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:ecomapp/utils/constants/image_strings.dart';
import 'package:ecomapp/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageContoller,
            onPageChanged: controller.updatePageIndiacator,
            children: const [
              OnBoardingPage(
                image: TImages.onboarding_image1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onboarding_image2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onboarding_image1,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              )
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingNavigation(),
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
