import 'package:myapp/consts/consts.dart';

Widget homeButtons({width, height, icon, String? title, onPress}) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, width: 26),
          10.heightBox,
          title!.text.fontFamily(semibold).color(darkFontGrey).make(),
        ],
      )
          .box
          .rounded
          .white
          .size(width, height)
          .shadowSm
          .padding(const EdgeInsets.all(4))
          .make(),
    ),
  );
}
