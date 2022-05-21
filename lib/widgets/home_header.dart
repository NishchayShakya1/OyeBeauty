import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ignore: deprecated_member_use
        "OyeBeauty".text.xl5.bold.make(),
        // ignore: deprecated_member_use
        "Available Services".text.xl2.make().px4()
      ],
    );
  }
}
