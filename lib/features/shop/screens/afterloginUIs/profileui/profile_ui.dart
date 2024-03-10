import 'package:ecomapp/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileUI extends StatelessWidget {
  const ProfileUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/onboarding_images/logo.png',
          height: 50,
          fit: BoxFit.fill,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: MediaQuery.of(context).size.width / 5.3,
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/lokalshop-24d55.appspot.com/o/avatarinsideacircle_122011.png?alt=media&token=44e8878f-471b-445f-af8c-540149898b5a'),
                ),
                SizedBox(
                  height: 20,
                ),
                profileItem('Name',
                    FirebaseAuth.instance.currentUser!.displayName.toString()),
                SizedBox(
                  height: 10,
                ),
                profileItem('Email',
                    FirebaseAuth.instance.currentUser!.email.toString()),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Selected Language',
                          style: GoogleFonts.montserrat(
                              color: Colors.black, fontSize: 26),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          size: 35,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Get.to(() => OnBoardingScreen());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Log out',
                            style: GoogleFonts.montserrat(
                                color: Colors.black, fontSize: 26),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.login,
                            size: 35,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileItem(String title, String ans) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black)),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.montserrat(color: Colors.black, fontSize: 26),
            ),
            Text(
              '-',
              style: GoogleFonts.montserrat(color: Colors.black, fontSize: 26),
            ),
            Text(
              ans,
              style: GoogleFonts.montserrat(color: Colors.black, fontSize: 26),
            )
          ],
        ),
      ),
    );
  }
}
