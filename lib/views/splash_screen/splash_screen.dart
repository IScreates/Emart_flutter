// splash_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/views/auth_screen/home_screen/home.dart';
import 'package:myapp/views/auth_screen/login_screen.dart';
import 'package:myapp/widgets_common/applogo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // method to change screen
  void changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.to(() => const LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => LoginScreen());
        } else {
          Get.to(() => Home());
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg, width: 300),
            ),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
