import 'package:ecomapp/features/shop/screens/afterloginUIs/products/product.dart';
// import 'package:ecomapp/features/shop/screens/afterloginUIs/profileui/profile_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistUI extends StatelessWidget {
  const WishlistUI({Key? key}) : super(key: key);

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
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'WISHLIST',
              style: GoogleFonts.montserrat(
                  fontSize: 26, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('wishlist')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  !snapshot.data!.exists) {
                return Center(
                  child: Text('No items in wishlist'),
                );
              }
              var wishlistData = snapshot.data!;

              // Check if the 'liked' field exists in the document
              if (wishlistData.exists && wishlistData['liked'] != null) {
                List<dynamic> likedProducts = wishlistData['liked'];

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: likedProducts.length,
                  itemBuilder: (context, index) {
                    return wishlistItem(likedProducts[index], context);
                  },
                );
              } else {
                // Handle the case where 'liked' field does not exist or is null
                return Center(
                  child: Text('No items liked yet'),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget wishlistItem(String productId, BuildContext context) {
    // Assuming 'products' is your collection of products in Firestore
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return SizedBox
              .shrink(); // Return an empty SizedBox if product data not available
        }
        var productData = snapshot.data;
        String img = productData!['img'][0];
        String name = productData['name'];
        String price = productData['price'];
        String shop = productData['shop'];

        return GestureDetector(
          onTap: () {
            Get.to(() => ProductData(
                  product: productData,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: Colors.black)),
              height: 130,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 120,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(img), fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.montserrat(
                              color: Colors.black, fontSize: 16),
                        ),
                        Text(
                          'By ${shop}',
                          style: GoogleFonts.montserrat(
                              color: Colors.black, fontSize: 16),
                        ),
                        Text(
                          '₹${price}',
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
