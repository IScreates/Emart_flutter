import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/consts/lists.dart';
import 'package:myapp/controller/auth_controller.dart';
import 'package:myapp/views/auth_screen/home_screen/home.dart';
import 'package:myapp/widgets_common/applogo_widget.dart';
import 'package:myapp/widgets_common/custom_textfield.dart';
import 'package:myapp/widgets_common/our_button.dart';
import '../../widgets_common/bg_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isChecked = false;
  final controller = Get.put(AuthController());
  final nameController = TextEditingController();
  final retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                10.heightBox,
                "Join the $appname".text.fontFamily(bold).white.size(22).make(),
                15.heightBox,

                Obx(
                  () => Column(
                        children: [
                          customTextField(
                            hint: nameHint,
                            title: name,
                            controller: nameController,
                            isPass: false,
                          ),
                          customTextField(
                            hint: emailHint,
                            title: email,
                            controller: controller.emailController,
                            isPass: false,
                          ),
                          customTextField(
                            hint: passwordHint,
                            title: password,
                            controller: controller.passwordController,
                            isPass: true,
                          ),
                          customTextField(
                            hint: passwordHint,
                            title: retypePassword,
                            controller: retypePasswordController,
                            isPass: true,
                          ),
                          5.heightBox,

                          Row(
                            children: [
                              Checkbox(
                                checkColor: whiteColor,
                                activeColor: redColor,
                                value: isChecked,
                                onChanged: (newValue) {
                                  setState(() {
                                    isChecked = newValue!;
                                  });
                                },
                              ),
                              10.widthBox,
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "I agree to the ",
                                        style: TextStyle(
                                          fontFamily: regular,
                                          color: fontGrey,
                                        ),
                                      ),
                                      TextSpan(
                                        text: termsAndConditions,
                                        style: TextStyle(
                                          fontFamily: regular,
                                          color: redColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " & ",
                                        style: TextStyle(
                                          fontFamily: regular,
                                          color: fontGrey,
                                        ),
                                      ),
                                      TextSpan(
                                        text: privacyPolicy,
                                        style: TextStyle(
                                          fontFamily: regular,
                                          color: redColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          10.heightBox,
                          controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                    redColor,
                                  ),
                                )
                              : ourButton(
                                  color: isChecked ? redColor : lightGrey,
                                  title: signup,
                                  textColor: whiteColor,
                                  onPress: () async {
                                    // ✅ Validate before any async work
                                    if (!isChecked) {
                                      VxToast.show(
                                        context,
                                        msg:
                                            "Please agree to Terms & Conditions",
                                      );
                                      return;
                                    }

                                    if (controller.passwordController.text
                                            .trim() !=
                                        retypePasswordController.text
                                            .trim()) {
                                      VxToast.show(
                                        context,
                                        msg: "Passwords do not match",
                                      );
                                      return;
                                    }

                                    controller.isLoading(true);

                                    try {
                                      final user = await controller.signupMethod(
                                        context: context,);

                                      if (mounted && user != null) {
                                        await controller.storeUserData(
                                          email: controller.emailController.text
                                              .trim(),
                                          password: controller
                                              .passwordController.text
                                              .trim(),
                                          name: nameController.text.trim(),
                                        );

                                        // ✅ Safe after async gap
                                        VxToast.show(
                                          context,
                                          msg: loggedin,
                                        );
                                        Get.offAll(() => const Home());
                                      }
                                    } catch (e) {
                                      auth.signOut();
                                      if (mounted) {
                                        VxToast.show(
                                          context,
                                          msg: e.toString(),
                                        );
                                      }
                                    } finally {
                                      controller.isLoading(false);
                                    }
                                  },
                                ).box.width(context.screenWidth - 50).make(),

                          10.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              alreadyHaveAccount.text.color(fontGrey).make(),
                              login.text.color(redColor).make().onTap(() {
                                Get.back();
                              }),
                            ],
                          ),
                        ],
                      )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
