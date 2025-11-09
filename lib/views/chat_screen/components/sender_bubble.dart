import 'package:myapp/consts/consts.dart';
Widget senderBubble(){
  return Container(
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
        color: redColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20)
        )

    ),
    child: Column(
      children: [
        "Message here...".text.white.size(16).make(),
        10.heightBox,
        "11:45 PM".text.color(whiteColor.withOpacity(0.5)).make(),
      ],
    ),
  );
}