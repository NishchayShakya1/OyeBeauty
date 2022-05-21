import 'package:assignment/views/Address/future.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  Address({Key key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _formKey = GlobalKey<FormState>();

  var address = "";
  var flat = "";
  var name = "";
  var phone = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final addressController = TextEditingController();
  final flatController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  clearText() {
    addressController.clear();
    flatController.clear();
    nameController.clear();
    phoneController.clear();
  }

  // Adding Student
  CollectionReference students =
      FirebaseFirestore.instance.collection('Address');

  Future<void> addUser() {
    return students
        .add({'address': address, 'flat': flat, 'name': name, 'phone': phone})
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Address"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Address: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Address';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  // obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Flat/Building/Street',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: flatController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Flat/Building/Street';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Name: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Phone Number';
                    } else if (value.length != 10) {
                      return 'Incorrect Number';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            address = addressController.text;
                            flat = flatController.text;
                            name = nameController.text;
                            phone = phoneController.text;
                            addUser();

                            clearText();
                          });
                          await Duration(seconds: 1);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FirebaseFuture(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {clearText()},
                      child: Text(
                        'Reset',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FirebaseFuture(),
                    ),
                  )
                },
                child: Text(
                  'Select Address',
                  style: TextStyle(fontSize: 18.0),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    addressController.dispose();
    flatController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
