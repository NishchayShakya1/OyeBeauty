import 'dart:convert';
import 'package:assignment/models/homemodel.dart';
import 'package:assignment/views/Login/register_screen.dart';
import 'package:assignment/widgets/catalog_list.dart';
import 'package:assignment/widgets/home_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    // var response2 = await http.get(Uri.parse(urlfaq));
    var HomeJson = await rootBundle.loadString("assets/files/image.json");
    var decodedData = jsonDecode(HomeJson);
    var productsData = decodedData["image"];
    HomeModel.items = List.from(productsData)
        .map<Home>((item) => Home.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: Vx.m20,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            HomeHeader(),
            if (HomeModel.items != null && HomeModel.items.isNotEmpty)
              CatalogList().py8().expand()
            else
              CircularProgressIndicator().centered().py16().expand(),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _auth.signOut();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Register()),
              (Route<dynamic> route) => false);
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
