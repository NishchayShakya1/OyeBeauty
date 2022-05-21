import 'package:assignment/views/Address/update_student_page.dart';
import 'package:assignment/views/Payment/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ListAddressPage extends StatefulWidget {
  ListAddressPage({Key key}) : super(key: key);

  @override
  _ListAddressPageState createState() => _ListAddressPageState();
}

class _ListAddressPageState extends State<ListAddressPage> {
  final Stream<QuerySnapshot> addressStream =
      FirebaseFirestore.instance.collection('Address').snapshots();

  // For Deleting User
  CollectionReference address =
      FirebaseFirestore.instance.collection('Address');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return address
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   body: SafeArea(
        //     child: Container(
        //       child:
        StreamBuilder<QuerySnapshot>(
            stream: addressStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print('Something went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final List storedocs = [];
              snapshot.data.docs.map((DocumentSnapshot document) {
                Map a = document.data() as Map<String, dynamic>;
                storedocs.add(a);
                a['id'] = document.id;
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //CatalogHeader(),
                  Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 0),
                          shrinkWrap: true,
                          itemCount: storedocs.length,
                          itemBuilder: (context, i) {
                            // Contest user = list[index];
                            // final catalog = CatalogModel.getbyPosition(index);
                            return VxBox(
                                    child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ButtonBar(
                                  alignment: MainAxisAlignment.spaceBetween,
                                  buttonPadding: Vx.m8,
                                  children: [
                                    // Hero(
                                    //   tag: Key("${data1[index]['id']}"
                                    //       .toString()),
                                    //   child: CatalogImage(
                                    //     image: "${data1[index]['image']}",
                                    //     key: null,
                                    //   ),
                                    // ),
                                    storedocs[i]['flat']
                                        .toString()
                                        .text
                                        .lg
                                        .xl
                                        .color(context.accentColor)
                                        .bold
                                        .make(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () => {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateStudentPage(
                                                          id: storedocs[i]
                                                              ['id']),
                                                ),
                                              )
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 0),
                                              child: Icon(
                                                Icons.edit,
                                                color: context.accentColor,
                                                size: 24.0,
                                                shadows: [
                                                  BoxShadow(
                                                    blurRadius: 42.0,
                                                    color: Colors.purpleAccent,
                                                  ),
                                                  BoxShadow(
                                                    blurRadius: 12.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => {
                                              deleteUser(storedocs[i]['id'])
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 0),
                                              child: Icon(
                                                Icons.delete_outlined,
                                                color: context.accentColor,
                                                size: 24.0,
                                                shadows: [
                                                  BoxShadow(
                                                    blurRadius: 42.0,
                                                    color: Colors.purpleAccent,
                                                  ),
                                                  BoxShadow(
                                                    blurRadius: 12.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ]),
                                  ],
                                ).pOnly(right: 3.0),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(padding: EdgeInsets.symmetric()),
                                    storedocs[i]['name']
                                        .toString()
                                        .text
                                        .lg
                                        .xl
                                        .color(context.accentColor)
                                        .bold
                                        .make()
                                        .px8()
                                        .py8(),
                                    storedocs[i]['phone']
                                        .toString()
                                        .text
                                        .textStyle(
                                          context.captionStyle,
                                        )
                                        .make()
                                        .px8()
                                        .py2(),
                                    storedocs[i]['address']
                                        .toString()
                                        .text
                                        .textStyle(
                                          context.captionStyle,
                                        )
                                        .make()
                                        .px8(),
                                  ],
                                ))
                              ],
                            ).p12())
                                .color(context.cardColor)
                                .roundedLg
                                .square(170)
                                .make()
                                .py8()
                                .px0();
                          })),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentScreen())),
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    ),
                  ),
                ],
              );
            });
    //     ),
    //   ),
    // );
  }
}
