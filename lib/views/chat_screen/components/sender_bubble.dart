import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data) {
  var t = data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  // Determine if the message was sent by the current user
  bool isSentByMe = data['uid'] == auth.currentUser!.uid;

  return Container(
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
        // Change bubble color based on the sender
        color: isSentByMe ? redColor : darkFontGrey,
        // Adjust border radius to create the bubble tail effect
        borderRadius: isSentByMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "${data['msg']}".text.white.size(16).make(),
        10.heightBox,
        time.text.color(whiteColor.withOpacity(0.5)).make(),
      ],
    ),
  );
}
