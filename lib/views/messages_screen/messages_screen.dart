import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/services/firestore_services.dart';
import 'package:myapp/views/chat_screen/chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No messages yet!".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Get.to(
                          () => const ChatScreen(),
                          arguments: [data[index]['friend_name'], data[index]['toId']],
                        );
                      },
                      leading: const CircleAvatar(
                        backgroundColor: redColor,
                        child: Icon(Icons.person, color: whiteColor),
                      ),
                      title: "${data[index]['friend_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                      subtitle: "${data[index]['last_msg']}".text.make(),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
