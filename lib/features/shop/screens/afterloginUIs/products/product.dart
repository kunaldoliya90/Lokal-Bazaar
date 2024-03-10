import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/features/shop/screens/afterloginUIs/products/buynow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductData extends StatefulWidget {
  final DocumentSnapshot<Object?> product;

  const ProductData({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDataState createState() => _ProductDataState();
}

class _ProductDataState extends State<ProductData> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    checkIfLiked();
  }

  Future<void> checkIfLiked() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email ?? '';
      DocumentSnapshot<Object?> userSnapshot = await FirebaseFirestore.instance
          .collection('wishlist')
          .doc(userEmail)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null && userData.containsKey('liked')) {
          List<dynamic> likedProducts = userData['liked'];
          setState(() {
            isLiked = likedProducts.contains(widget.product.id);
          });
        } else {
          // If the "liked" array doesn't exist, set isLiked to false or handle it accordingly
          setState(() {
            isLiked = false;
          });
        }
      } else {
        // Handle the case where the document doesn't exist
        setState(() {
          isLiked = false;
        });
      }
    }
  }

  Future<void> addToWishlist() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email ?? '';
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('wishlist').doc(userEmail);

      // Get the document snapshot
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await userRef.get() as DocumentSnapshot<Map<String, dynamic>>;

      // Get the current "liked" array or create a new empty one if it doesn't exist
      List<dynamic> likedProducts =
          (snapshot.data() != null && snapshot.data()!.containsKey('liked'))
              ? List.from(snapshot.data()!['liked'])
              : [];

      // Add or remove the product ID from the "liked" array based on the current state
      if (isLiked) {
        likedProducts.remove(widget.product.id);
      } else {
        likedProducts.add(widget.product.id);
      }

      // Set the updated "liked" array in the document
      await userRef.set({'liked': likedProducts}, SetOptions(merge: true));

      // Update the state to reflect the changes
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = List.from(widget.product['img']);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        color: Colors.purpleAccent,
        child: Center(
          child: GestureDetector(
            onTap: () {
              Get.to(() => BuyNow(product: widget.product));
            },
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Buy Now'),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.shopping_bag)
                ],
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 14),
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.heart,
                color: isLiked
                    ? Colors.red
                    : Colors.grey, // Change icon color based on like status
              ),
              onPressed: addToWishlist,
            ),
          )
        ],
        backgroundColor: Colors.white,
        title: Text(
          widget.product['name'],
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.network(images[index]);
                },
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(31),
                      topRight: Radius.circular(31))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.product['name'],
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white, fontSize: 24),
                                ),
                                Text(
                                  'By ${widget.product['shop']}',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ],
                            ),
                            Text(
                              '₹ ${widget.product['price']}',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 24),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'About the product:',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        SizedBox(height: 17),
                        Text(
                          widget.product['description'],
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
