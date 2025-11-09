
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
        title: "Title".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),

      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(()=>
               controller.isLoading.value ? Center(
                 child: loadingIndicator(),
               ) :Expanded(
              child: StreamBuilder(stream: FirestoreServices.getChatMessages(controller.chatDocId.toString()), builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: loadingIndicator(),
                  );
                }else if(snapshot.data!.docs.isEmpty){
                  return Center(
                    child: "Send a  message....".text.color(darkFontGrey).make(),
                  );
                }else{
                  return ListView(
                    children: [
                      senderBubble(),
                      senderBubble(),
                    ],
                  );
                }
    },
              ),
            ),
            ),

            10.heightBox,
            Row(
              children: [
                Expanded(child: TextFormField(
                  controller: controller.msgController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfieldGrey,
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,
                        )
                    ),
                    hintText: "Type a Message...",
                  ),
                )),
                IconButton(onPressed: (){
                  controller.sendMsg(controller.msgController.text);
                  controller.msgController.clear();
                }, icon: Icon(Icons.send, color: redColor,))
              ],
            ).box.height(80).padding(EdgeInsets.all(12)).margin(EdgeInsets.only(bottom: 8)).make()
          ],
        ),
      )
    );
  }
}

Widget? loadingIndicator() {
}
