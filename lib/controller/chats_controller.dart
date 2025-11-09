import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/controller/home_controller.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getChatId();
  }

  var isLoading = false.obs;

  var chats = firestore.collection(chatCollection);
  
  // Get arguments from the previous screen
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  // Get sender details from HomeController
  var senderName = Get.find<HomeController>().username.value;
  var currentId = auth.currentUser!.uid;

  var msgController = TextEditingController();
  dynamic chatDocId;

  // Create a unique and deterministic chat ID
  getChatId() async {

    isLoading(true);
    if (currentId.hashCode <= friendId.hashCode) {
      chatDocId = '$currentId-$friendId';
    } else {
      chatDocId = '$friendId-$currentId';
    }

    var doc = await chats.doc(chatDocId).get();

    // If the chat document doesn't exist, create it
    if (!doc.exists) {
      await chats.doc(chatDocId).set({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': '',
        'users': {friendId: null, currentId: null},
        'friend_name': friendName,
        'sender_name': senderName,
      });
    }
    isLoading(false);
  }

  // Send a message
  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      // Update the main chat document with the last message details
      chats.doc(chatDocId).update({
        'last_msg': msg,
        'created_on': FieldValue.serverTimestamp(),
        'toId': friendId,
        'fromId': currentId,
      });

      // Add the new message to the 'messages' subcollection
      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });

      // Clear the text field after sending
      msgController.clear();
    }
  }
}
