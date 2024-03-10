import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/common/widgets/customShapes/Container/TPrimaryHeaderContainer.dart';
import 'package:ecomapp/features/shop/screens/afterloginUIs/products/allProducts.dart';
import 'package:ecomapp/features/shop/screens/afterloginUIs/products/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HorizontalScrollBanner(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Top Products',
                            style: GoogleFonts.montserrat(
                                fontSize: 22, color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => allProducts());
                            },
                            child: Text(
                              'See all',
                              style: GoogleFonts.montserrat(
                                  fontSize: 22, color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('products')
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }
                          List<DocumentSnapshot> products = snapshot.data!.docs;
                          return GridView.builder(
                            shrinkWrap: true,
                            itemCount: products.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 1.0,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              var product = products[index];
                              var data = product;
                              var name = data['name'];
                              var imgUrl =
                                  data['img'] != null ? data['img'][0] : '';
                              var price = data['price'] ?? '';
                              return GestureDetector(
                                onTap: () {
                                  Get.to(()=>ProductData(product: product));
                                },
                                child: GridTile(
                                  child: _productItem(
                                    name,
                                    imgUrl,
                                    price,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, BuildContext context) {
    return Container(
      // width: 100,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _productItem(String name, String image, String price) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(
              image,
              height: 110,
              width: 250,
              fit: BoxFit.fill,
            ),
            Divider(
              height: 10,
              color: Colors.black87,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style:
                      GoogleFonts.montserrat(fontSize: 16, color: Colors.black),
                ),
                Text(
                  'Rs.' + price,
                  style:
                      GoogleFonts.montserrat(fontSize: 16, color: Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HorizontalScrollBanner extends StatelessWidget {
  const HorizontalScrollBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/onboarding_images/jewellery.png',
                        ),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/onboarding_images/decor.webp',
                        ),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(15)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
