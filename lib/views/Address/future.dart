import 'package:assignment/views/Address/list_student_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';

class FirebaseFuture extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // CHeck for Errors
        if (snapshot.hasError) {
          print("Something went Wrong");
          Toast.show("No Internet", context);
        }
        // once Completed, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Address"),
              centerTitle: true,
            ),
            body: SafeArea(
                child: Container(padding: Vx.m12,
                 child: ListAddressPage())),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
