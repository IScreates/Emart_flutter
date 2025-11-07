import 'dart:io';

import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/controller/profile_controller.dart';
import 'package:myapp/widgets_common/bg_widget.dart';
import 'package:myapp/widgets_common/custom_textfield.dart';
import 'package:myapp/widgets_common/our_button.dart';

class EditProfile extends StatelessWidget {
  final dynamic data;
  const EditProfile({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    controller.nameController.text = data['name'];

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Profile image selection
                Obx(() {
                  if (controller.profileImgPath.isNotEmpty) {
                    return Image.file(
                      File(controller.profileImgPath.value),
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make();
                  } else if (data['imageUrl'] != null && data['imageUrl'].isNotEmpty) {
                    return Image.network(
                      data['imageUrl'],
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make();
                  } else {
                    return Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make();
                  }
                }),
                10.heightBox,
                ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change",
                ),
                const Divider(),
                20.heightBox,
                customTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  isPass: false,
                ),
                10.heightBox,
                customTextField(
                  controller: controller.oldpassController,
                  hint: passwordHint,
                  title: oldpass,
                  isPass: true,
                ),
                10.heightBox,
                customTextField(
                  controller: controller.newpassController, // Corrected controller
                  hint: passwordHint,
                  title: newpass,
                  isPass: true,
                ),
                20.heightBox,
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: ourButton(
                          onPress: () async {
                            controller.isLoading(true);

                            // Step 1: Attempt to change password if fields are not empty.
                            if (controller.oldpassController.text.isNotEmpty &&
                                controller.newpassController.text.isNotEmpty) {
                              bool passwordChanged = await controller.changeAuthPassword(
                                context: context,
                                email: data['email'],
                                oldPassword: controller.oldpassController.text,
                                newPassword: controller.newpassController.text,
                              );

                              // Step 2: If password change fails, stop everything.
                              if (!passwordChanged) {
                                controller.isLoading(false);
                                return; // Exit the function immediately
                              }
                            }

                            // Step 3: If password change was successful (or not attempted), proceed.
                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImgLink.value = data['imageUrl'];
                            }

                            await controller.updateProfile(
                              name: controller.nameController.text,
                              imgUrl: controller.profileImgLink.value,
                            );
                            
                            VxToast.show(context, msg: "Profile updated successfully");
                            controller.isLoading(false);
                            Get.back();
                          },
                          color: redColor,
                          textColor: whiteColor,
                          title: "Save",
                        ),
                      ),
              ],
            )
                .box
                .white
                .shadowSm
                .padding(const EdgeInsets.all(16))
                .margin(
                  const EdgeInsets.only(top: 50, left: 12, right: 12),
                )
                .rounded
                .make(),
          ),
        ),
      ),
    );
  }
}
