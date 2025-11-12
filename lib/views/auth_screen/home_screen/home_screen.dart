import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/consts/lists.dart';
import 'package:myapp/controller/home_controller.dart';
import 'package:myapp/services/firestore_services.dart';
import 'package:myapp/views/auth_screen/home_screen/components/featured_button.dart';
import 'package:myapp/views/auth_screen/home_screen/components/search_screen.dart';
import 'package:myapp/views/category_screen/item_details.dart';
import 'package:myapp/widgets_common/home_button.dart';

class HomeScreen extends StatelessWidget {

   const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
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
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: const Icon(Icons.search).onTap((){
                        if(controller.searchController.text.isNotEmptyAndNotNull){
                          Get.to(()=>SearchScreen(title: controller.searchController.text));
                        }

                      }),
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
                        child: FutureBuilder(future: FirestoreServices.getFeaturedProducts(), builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData){
                            return Center(
                              child: loadingIndicator(),
                            );
                          }else if (snapshot.data!.docs.isEmpty){
                            return "No Featured Products Found".text.white.makeCentered();
                          }else {
                            var featuredData = snapshot.data!.docs;
                            return Row(
                              children: List.generate(
                                featuredData.length,
                                    (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          featuredData[index]['p_imgs'][0],
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        const Spacer(),
                                        "${featuredData[index]['p_name']}"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "${featuredData[index]['p_price']}"
                                            .numCurrency
                                            .text
                                            .color(redColor)
                                            .fontFamily(bold)
                                            .size(16)
                                            .make(),
                                      ],
                                    )
                                        .box
                                        .white
                                        .size(180, 250)
                                        .roundedSM
                                        .padding(const EdgeInsets.all(8))
                                        .margin(
                                          const EdgeInsets.symmetric(
                                              horizontal: 4),
                                        )
                                        .make()
                                        .onTap(() {
                                      Get.to(() => ItemDetails(
                                            title:
                                                "${featuredData[index]['p_name']}",
                                            data: featuredData[index],
                                          ));
                                    }),
                              ),
                            );
                          }
                        }),
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
                StreamBuilder(stream: FirestoreServices.allProducts(), builder: (BuildContext context, AsyncSnapshot <QuerySnapshot>snapshot) {
                  if (!snapshot.hasData) {
                    return loadingIndicator();
                  }
                  else {
                    var allproductsdata = snapshot.data!.docs;
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allproductsdata.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 300,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              allproductsdata[index]['p_imgs'][0],
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            const Spacer(),
                            "${allproductsdata[index]['p_name']}".text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "${allproductsdata[index]['p_price']}".numCurrency.text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(16)
                                .make(),
                          ],
                        ).box.white.roundedSM
                            .padding(const EdgeInsets.all(12))
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .make().onTap((){
                             Get.to(()=> ItemDetails(title: "${allproductsdata[index]['p_name']}",data: allproductsdata[index]));
                        });
                      },
                    );
                  }
                }
          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
