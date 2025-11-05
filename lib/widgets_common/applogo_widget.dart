// ignore_for_file: unused_import

import 'package:myapp/consts/consts.dart';

Widget applogoWidget() {
  return Image.asset(
    icAppLogo,              // Make sure this constant points to the correct file
    fit: BoxFit.contain,    // Ensures the image scales correctly
  )
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .shadowSm              // Optional: adds a nice subtle shadow
      .make();
}
