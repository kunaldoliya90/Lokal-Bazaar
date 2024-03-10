import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BuyNow extends StatefulWidget {
  final DocumentSnapshot<Object?> product;
  BuyNow({super.key, required this.product});

  @override
  State<BuyNow> createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  late Razorpay _razorpay;

  void checkOutAmount(double amount) async {
    amount = amount * 100;

    // Use the provided razor key as a Strin
    Map<String, dynamic> options = {
      'key': 'rzp_test_p2g5OCNgvNbz6j', // Use the provided razor key
      'amount': amount,
      'name': 'Lokal Shop',
      'prefill': {
        'contact': '9818523384',
        'email': 'aditya.thakur2021@vitbhopal.ac.in'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options as Map<String, dynamic>);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // addData(widget.days);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => ThankYouPage()));
    Fluttertoast.showToast(
        msg: "Payment Succesful ", toastLength: Toast.LENGTH_SHORT);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    print("Payment Fail " + response.message.toString());
    Fluttertoast.showToast(
        msg: "Payment Fail " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    String img = widget.product!['img'][0];
    String name = widget.product['name'];
    String price = widget.product['price'];
    String shop = widget.product['shop'];
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Center(
          child: GestureDetector(
            onTap: () {
              Get.to(() => BuyNow(product: widget.product));
            },
            child: GestureDetector(
              onTap: () {
                checkOutAmount(
                    double.parse((26 + int.parse(price)).toString()));
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Pay ₹ ${(26 + int.parse(price))}'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.credit_card)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Checkout',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 31,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 120,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(31),
                      image: DecorationImage(image: NetworkImage(img)),
                    ),
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
                        'X 1',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      )
                      // Text(
                      //   '₹${price}',
                      //   style: TextStyle(color: Colors.black, fontSize: 22),
                      // )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black)),
                // height: MediaQuery.of(context).size.height / 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amount',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                          Text(
                            '₹ ${price}',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Charges',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                          Text(
                            'Free',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Taxes',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                          Text(
                            '₹ ${(26)}',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                        height: 5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                          Text(
                            '₹ ${(26 + int.parse(price))}',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      )
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
}
