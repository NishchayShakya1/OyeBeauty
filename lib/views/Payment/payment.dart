import 'package:assignment/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    super.initState();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_Nvm6Wtc5p2RHZB",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "Sample App",
      "description": "Payment for the some random product",
      "prefill": {
        "contact": "+919755205861",
        "email": "shakyanischay420@gmail.com"
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment Success");
    Toast.show("Payment Success", context);
    await Duration(seconds: 2);
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  Future<void> handlePaymentError(PaymentFailureResponse response) async {
    print("Payment error");
    Toast.show("Payment error", context);
    await Duration(seconds: 2);
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  Future<void> handleExternalWallet(ExternalWalletResponse response) async {
    print("External Wallet");
    Toast.show("External Wallet", context);
    await Duration(seconds: 2);
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Gateway"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: "Amount to pay"),
            ),
            SizedBox(
              height: 12,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              color: Colors.blue,
              child: Text(
                "Pay Now",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (textEditingController.text != "") {
                  openCheckout();
                } else {
                  Toast.show("Enter Amount", context);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    razorpay.clear();
    super.dispose();
  }
}
