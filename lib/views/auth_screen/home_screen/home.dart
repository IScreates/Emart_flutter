import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/controller/home_controller.dart';
import 'package:myapp/views/auth_screen/home_screen/home_screen.dart';
import 'package:myapp/views/cart_screen/cart_screen.dart';
import 'package:myapp/views/category_screen/category_screen.dart';
import 'package:myapp/views/profile_screen/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize controller
    final HomeController homeController = Get.put(HomeController());

    // ✅ Bottom navigation items
    final navbarItems = [
      BottomNavigationBarItem(
        icon: Image.asset(icHome, width: 26),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icCategories, width: 26),
        label: "Categories",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icCart, width: 26),
        label: "Cart",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icProfile, width: 26),
        label: "Account",
      ),
    ];

    // ✅ Screens for each tab
    final navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: whiteColor,
      body: Obx(() => navBody[homeController.currentNavIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: homeController.currentNavIndex.value,
          selectedItemColor: redColor,
          unselectedItemColor: darkFontGrey,
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          items: navbarItems,
          onTap: (value) {
            homeController.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
