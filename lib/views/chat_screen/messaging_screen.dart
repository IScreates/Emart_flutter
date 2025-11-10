import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/services/firestore_services.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(stream: FirestoreServices.getAllMessages(), builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),),) ;
        }else if(snapshot.data!.docs.isEmpty){
          return "No Messages Yet!".text.color(darkFontGrey).makeCentered();
        }else{
          return Container();
        }
      },
      ),
    );
  }
}
