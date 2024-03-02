import 'package:ecomapp/features/authentication/screens/onboarding/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // Variables
  final pageContoller = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndiacator(index) => currentPageIndex.value = index;
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageContoller.jumpTo(index);
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      Get.to(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageContoller.jumpToPage(page);
    }
  }

  void skipPage() {
    currentPageIndex.value = 2;
    pageContoller.jumpTo(2);
  }
}
