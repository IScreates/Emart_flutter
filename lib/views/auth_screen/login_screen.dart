import 'package:get/get.dart';

import 'package:myapp/controller/auth_controller.dart';
import 'package:myapp/views/auth_screen/home_screen/home.dart';
import 'package:myapp/views/auth_screen/signup_screen.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/consts/lists.dart';
import 'package:myapp/widgets_common/applogo_widget.dart';
import 'package:myapp/widgets_common/bg_widget.dart';
import 'package:myapp/widgets_common/custom_textfield.dart';
import 'package:myapp/widgets_common/our_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Use Get.put once to register the controller
  final AuthController controller = Get.put(AuthController());

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
                "Log in to $appname".text
                    .fontFamily(bold)
                    .white
                    .size(22)
                    .make(),
                15.heightBox,

                // Login box
                Obx(
                  () =>
                      Column(
                            children: [
                              customTextField(
                                hint: emailHint,
                                title: email,
                                isPass: false,
                                controller: controller.emailController,
                              ),
                              customTextField(
                                hint: passwordHint,
                                title: password,
                                isPass: true,
                                controller: controller.passwordController,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // implement forgot password flow if needed
                                  },
                                  child: forgetPassword.text.make(),
                                ),
                              ),
                              5.heightBox,

                              // show spinner or button
                              controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                        redColor,
                                      ),
                                    )
                                  : ourButton(
                                      color: redColor,
                                      title: login,
                                      textColor: whiteColor,
                                      onPress: () async {
                                        // prevent duplicate taps
                                        controller.isLoading(true);

                                        try {
                                          // pass the current build context (safe)
                                          final user = await controller
                                              .loginMethod(context: context);

                                          // after async, ensure widget still mounted
                                          if (!mounted) return;

                                          if (user != null) {
                                            // controller.loginMethod already shows a toast,
                                            // but showing here is OK too
                                            VxToast.show(
                                              context,
                                              msg: loggedin,
                                            );
                                            Get.offAll(() => const Home());
                                          }
                                        } catch (e) {
                                          if (mounted) {
                                            VxToast.show(
                                              context,
                                              msg: e.toString(),
                                            );
                                          }
                                        } finally {
                                          if (mounted) {
                                            controller.isLoading(false);
                                          }
                                        }
                                      },
                                    ).box.width(context.screenWidth - 50).make(),

                              5.heightBox,
                              creatNewAccount.text.color(fontGrey).make(),
                              5.heightBox,
                              ourButton(
                                color: lightgolden,
                                title: signup,
                                textColor: redColor,
                                onPress: () {
                                  Get.to(() => const SignupScreen());
                                },
                              ).box.width(context.screenWidth - 50).make(),
                            ],
                          ).box.white.rounded
                          .padding(const EdgeInsets.all(16))
                          .width(context.screenWidth - 70)
                          .shadowSm
                          .make(),
                ),

                10.heightBox,
                loginWith.text.color(fontGrey).make(),
                5.heightBox,

                // Social icons row
                Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        socialIconList.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(
                              socialIconList[index],
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                    ).box.rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .color(Colors.white)
                    .make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
