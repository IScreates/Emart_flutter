import 'package:myapp/consts/consts.dart';
import 'package:myapp/consts/lists.dart';
import 'package:myapp/views/auth_screen/home_screen/components/featured_button.dart';
import 'package:myapp/widgets_common/home_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
          radius: const Radius.circular(10),
          thickness: 6,
          interactive: true,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // 🔍 Search Bar
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  color: lightGrey,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: whiteColor,
                      hintText: searchanything,
                      hintStyle: const TextStyle(color: textfieldGrey),
                    ),
                  ),
                ),

                10.heightBox,

                // 🌀 First Swiper (autoplay)
                VxSwiper.builder(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  height: 150,
                  enlargeCenterPage: true,
                  itemCount: sliderList.length,
                  itemBuilder: (context, index) {
                    return Image.asset(sliderList[index], fit: BoxFit.cover).box
                        .margin(const EdgeInsets.symmetric(horizontal: 8))
                        .roundedSM
                        .clip(Clip.antiAlias)
                        .make();
                  },
                ),

                10.heightBox,

                // ⚡ Deals Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    2,
                    (index) => homeButtons(
                      height: context.screenHeight * 0.15,
                      width: context.screenWidth / 2.5,
                      icon: index == 0 ? icTodaysDeal : icFlashDeal,
                      title: index == 0 ? todayDeal : flashsale,
                    ),
                  ),
                ),

                20.heightBox,

                // 🌀 Second Swiper (autoplay)
                VxSwiper.builder(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  height: 150,
                  enlargeCenterPage: true,
                  itemCount: secondSliderList.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.cover,
                        ).box
                        .margin(const EdgeInsets.symmetric(horizontal: 8))
                        .roundedSM
                        .clip(Clip.antiAlias)
                        .make();
                  },
                ),

                10.heightBox,

                // 🏷️ Category Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    3,
                    (index) => homeButtons(
                      height: context.screenHeight * 0.15,
                      width: context.screenWidth / 3.5,
                      icon: index == 0
                          ? icTopCategories
                          : index == 1
                          ? icBrands
                          : icTopSeller,
                      title: index == 0
                          ? topCategories
                          : index == 1
                          ? brand
                          : topSellers,
                    ),
                  ),
                ),

                20.heightBox,

                // 🏷️ Featured Categories Title
                Align(
                  alignment: Alignment.centerLeft,
                  child: featuredCategories.text
                      .color(darkFontGrey)
                      .size(18)
                      .fontFamily(semibold)
                      .make(),
                ),

                20.heightBox,

                // 🖼️ Featured Buttons Row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      3,
                      (index) => Column(
                        children: [
                          featuredButton(
                            icon: featuredImages1[index],
                            title: featuredTitles1[index],
                          ),
                          10.heightBox,
                          featuredButton(
                            icon: featuredImages2[index],
                            title: featuredTitles2[index],
                          ),
                        ],
                      ),
                    ).toList(),
                  ),
                ),

                // 🛍️ Featured Product Section
                20.heightBox,
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: const BoxDecoration(color: redColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      featuredProduct.text.white
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            6,
                            (index) =>
                                Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          imgP1,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        10.heightBox,
                                        "Laptop 4GB/64GB".text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "600\$".text
                                            .color(redColor)
                                            .fontFamily(bold)
                                            .size(16)
                                            .make(),
                                      ],
                                    ).box.white.roundedSM
                                    .padding(const EdgeInsets.all(8))
                                    .margin(
                                      const EdgeInsets.symmetric(horizontal: 4),
                                    )
                                    .make(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 🌀 Third Swiper
                20.heightBox,
                VxSwiper.builder(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  height: 150,
                  enlargeCenterPage: true,
                  itemCount: secondSliderList.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.cover,
                        ).box
                        .margin(const EdgeInsets.symmetric(horizontal: 8))
                        .roundedSM
                        .clip(Clip.antiAlias)
                        .make();
                  },
                ),

                // 🛒 All Products Section
                20.heightBox,
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 300,
                  ),
                  itemBuilder: (context, index) {
                    // ✅ FIXED: Added 'return' keyword
                    return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              imgP5,
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            Spacer(),
                            "Laptop 4GB/64GB".text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "600\$".text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(16)
                                .make(),
                          ],
                        ).box.white.roundedSM
                        .padding(const EdgeInsets.all(12))
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .make();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
