import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/features/shop/screens/afterloginUIs/products/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreUI extends StatelessWidget {
  const StoreUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 13),
            child: Icon(
              Icons.search,
              color: Colors.black,
              size: 35,
            ),
          )
        ],
        title: Image.asset(
          'assets/images/onboarding_images/logo.png',
          height: 50,
          fit: BoxFit.fill,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'CATEGORIES',
                  style: GoogleFonts.montserrat(
                      fontSize: 26, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('category').get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  final List<DocumentSnapshot> categories = snapshot.data!.docs;

                  return GridView.builder(
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.0,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final category = categories[index];
                      final categoryName = category['name'];
                      final categoryImage = category['img'];

                      return GridTile(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => CategoriesPage(
                                cat: categoryName.toString()));
                          },
                          child: _categoriesItem(
                              categoryName, categoryImage, context),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoriesItem(String name, String image, context) {
    return Container(
      child: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 7,
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.fill))),
          // Image.network(
          //   image,
          //   height: 130,
          //   width: 180,
          //   fit: BoxFit.fill,
          // ),
          SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: GoogleFonts.abel(fontSize: 22, color: Colors.black),
          )
        ],
      ),
    );
  }
}
