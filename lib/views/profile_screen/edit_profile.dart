import 'dart:io';

import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/controller/profile_controller.dart';
import 'package:myapp/widgets_common/bg_widget.dart';
import 'package:myapp/widgets_common/custom_textfield.dart';
import 'package:myapp/widgets_common/our_button.dart';
// ✅ required for .heightBox, .box etc.

class EditProfile extends StatelessWidget {
  final dynamic data;
  const EditProfile({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var controller = Get.find<ProfileController>();
    controller.nameController.text = data['name'];
    controller.passController.text = data['password'];
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(
          () =>
              Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      controller.profileImgPath.isEmpty
                          ? Image.asset(
                              imgProfile2,
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.file(
                              File(controller.profileImgPath.value),
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),

                      10.heightBox,
                      ourButton(
                        color: redColor,
                        onPress: () {
                          controller.changeImage(context);
                        },
                        textColor: whiteColor,
                        title: "Change",
                      ),
                      const Divider(), // ✅ needs const
                      20.heightBox,
                      customTextField(
                        controller: controller.nameController,
                        hint: nameHint,
                        title: name,
                        isPass: false,
                      ),
                      customTextField(
                        controller: controller.passController,
                        hint: passwordHint,
                        title: password,
                        isPass: true,
                      ),
                      20.heightBox,
                      SizedBox(
                        width: context.screenWidth - 60,
                        child: ourButton(
                          onPress: () {},
                          color: redColor,
                          textColor: whiteColor,
                          title: "Save",
                        ),
                      ),
                    ],
                  ).box.white.shadowSm
                  .padding(const EdgeInsets.all(16)) // ✅ needs const
                  .margin(
                    const EdgeInsets.only(top: 50, left: 12, right: 12),
                  ) // ✅ const
                  .rounded
                  .make(),
        ),
      ),
    );
  }
}
