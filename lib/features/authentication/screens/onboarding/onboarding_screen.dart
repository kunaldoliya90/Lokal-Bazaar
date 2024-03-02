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
          ),
          const OnBoardingSkip(),
          const OnBoardingNavigation(),
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
