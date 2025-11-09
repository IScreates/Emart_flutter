import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/consts/lists.dart';
import 'package:myapp/controller/auth_controller.dart';
import 'package:myapp/controller/profile_controller.dart';
import 'package:myapp/services/firestore_services.dart';
import 'package:myapp/views/auth_screen/login_screen.dart';
import 'package:myapp/views/messages_screen/messages_screen.dart';
import 'package:myapp/views/profile_screen/components/details_cart.dart';
import 'package:myapp/views/profile_screen/edit_profile.dart';
import 'package:myapp/widgets_common/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
          stream: FirestoreServices.getUser(auth.currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // ✏️ Edit icon
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: const Icon(
                            Icons.edit,
                            color: whiteColor,
                          ),
                        ).onTap(() {
                          controller.nameController.text = data['name'];

                          Get.to(() => EditProfile(data: data));
                        }),
                      ),
                      10.heightBox,

                      // 👤 Profile row
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Row(
                          children: [
                            data['imageUrl'] == ''
                                ? Image.asset(
                                    imgProfile2,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make()
                                : Image.network(data['imageUrl'], width: 100, fit: BoxFit.cover)
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make(),
                            10.widthBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (data['name'] ?? 'User Name').toString().text.fontFamily(semibold).white.make(),
                                  (data['email'] ?? 'example@gmail.com').toString().text.white.make(),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () async {
                                await Get.put(
                                  AuthController(),
                                ).signoutMethod(context: context);
                                Get.offAll(() => const LoginScreen());
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: whiteColor),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: "Logout".text.fontFamily(semibold).white.make(),
                            ),
                          ],
                        ),
                      ),

                      20.heightBox,

                      // 📋 Profile options list
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const Divider(color: lightGrey),
                        itemCount: profileButtonsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              switch (index) {
                                case 1:
                                  Get.to(() => const MessagesScreen());
                                  break;
                              }
                            },
                            leading: Image.asset(
                              profileButtonsIcon[index],
                              width: 22,
                            ),
                            title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                          );
                        },
                      ).box.white.rounded.margin(const EdgeInsets.all(12)).padding(
                            const EdgeInsets.symmetric(horizontal: 16),
                          ).shadowSm.make(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
