import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomapp/features/shop/screens/afterloginUIs/products/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class allProducts extends StatelessWidget {
  const allProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        actions: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: EdgeInsets.only(right: 13),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ],
          )
        ],
        title: Text(
          'Top Products',
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 22),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('products').get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              List<DocumentSnapshot> products = snapshot.data!.docs;
              return GridView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  var product = products[index];
                  var data = product;
                  var name = data['name'];
                  var imgUrl = data['img'] != null ? data['img'][0] : '';
                  var price = data['price'] ?? '';
                  return GestureDetector(
                      onTap: () {
                        Get.to(() => ProductData(product: product));
                      },
                      child: GridTile(
                        child: _productItem(
                          name,
                          imgUrl,
                          price,
                        ),
                      ));
                },
              );
            },
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
              height: 140,
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
