import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/controller/chats_controller.dart';
import 'package:myapp/services/firestore_services.dart';
import 'package:myapp/views/chat_screen/components/sender_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() => controller.chatDocId.value.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : StreamBuilder(
                      stream: FirestoreServices.getChatMessages(controller.chatDocId.value),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: "Send a message....".text.color(darkFontGrey).make(),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index];
                              return Align(
                                alignment: data['uid'] == auth.currentUser!.uid
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: senderBubble(data),
                              );
                            },
                          );
                        }
                      },
                    )),
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller.msgController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: textfieldGrey,
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: textfieldGrey,
                    )),
                    hintText: "Type a Message...",
                  ),
                )),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                    },
                    icon: const Icon(
                      Icons.send,
                      color: redColor,
                    ))
              ],
            ).box.height(80).padding(const EdgeInsets.all(12)).margin(const EdgeInsets.only(bottom: 8)).make()
          ],
        ),
      ),
    );
  }
}
