// ignore_for_file: deprecated_member_use

import 'package:assignment/models/homemodel.dart';
import 'package:assignment/views/Address/add_student_page.dart';
import 'package:assignment/widgets/catalog_image.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
        shrinkWrap: true,
        itemCount: HomeModel.items.length,
        itemBuilder: (context, index) {
          final catalog = HomeModel.items[index];
          // final catalog = CatalogModel.getbyPosition(index);
          return InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Address())),
              child: CatalogItem(catalog: catalog));
        });
  }
}

class CatalogItem extends StatelessWidget {
  final Home catalog;

  const CatalogItem({Key key, this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Hero(
      tag: Key(catalog.id.toString()),
      child: CatalogImage(
        image: catalog.path,
        key: null,
      ),
    )).color(context.cardColor).roundedLg.make().py2().px0();
  }
}
