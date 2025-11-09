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

  var chats = firestore.collection(chatCollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.find<HomeController>().username.value;
  var currentId = auth.currentUser!.uid;

  var msgController = TextEditingController();

  // Make chatDocId reactive
  var chatDocId = ''.obs;
  var isLoading = false.obs;

  // Create a unique and deterministic chat ID
  getChatId() async {
    isLoading(true);
    String newChatDocId;
    if (currentId.hashCode <= friendId.hashCode) {
      newChatDocId = '$currentId-$friendId';
    } else {
      newChatDocId = '$friendId-$currentId';
    }

    var doc = await chats.doc(newChatDocId).get();

    if (!doc.exists) {
      await chats.doc(newChatDocId).set({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': '',
        'users': {friendId: null, currentId: null},
        'friend_name': friendName,
        'sender_name': senderName,
      });
    }
    chatDocId.value = newChatDocId;
    isLoading(false);
  }

  // Send a message
  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId.value).update({
        'last_msg': msg,
        'created_on': FieldValue.serverTimestamp(),
        'toId': friendId,
        'fromId': currentId,
      });

      chats.doc(chatDocId.value).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });

      msgController.clear();
    }
  }
}
