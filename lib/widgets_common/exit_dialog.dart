import 'package:flutter/services.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/widgets_common/our_button.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are you sure you want to exit?".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(color: redColor,onPress: (){
              SystemNavigator.pop();
            },textColor: whiteColor,title: "Yes"),
            ourButton(onPress: (){
              Navigator.pop(context);
            }, color: redColor, textColor: whiteColor, title: "No"),
          ],
        )
      ],
    ).box
    .color(lightGrey).padding(EdgeInsets.all(12)).roundedSM
        .make(),
  );
}