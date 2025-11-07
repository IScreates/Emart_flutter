import 'package:myapp/consts/consts.dart';
import 'package:myapp/consts/lists.dart';

// ignore: must_be_immutable
class ItemDetails extends StatelessWidget {
  String? title;

  final dynamic data;

  ItemDetails({super.key, this.title, this.data});

  get controller => null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, color: darkFontGrey),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline, color: darkFontGrey),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Swiper Section
                    VxSwiper.builder(
                      itemCount: data['p_imgs'].length,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      viewportFraction: 1.0,
                      enlargeCenterPage: true,
                      itemBuilder: (context, index) {
                        return Image.network(
                          data['p_imgs'][index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ).box.roundedSM.clip(Clip.antiAlias).make(),

                    10.heightBox,

                    // ✅ Title and Rating
                    title!.text
                        .size(16)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),

                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      maxRating: 5,
                    ),

                    10.heightBox,

                    "${data['p_price']}".numCurrency.text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),

                    10.heightBox,

                    // ✅ Seller Info Row
                    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Seller".text
                                    .fontFamily(semibold)
                                    .color(whiteColor)
                                    .make(),
                                5.heightBox,
                                "${data['p_seller']}".text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                              ],
                            ),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.message_rounded,
                                color: darkFontGrey,
                              ),
                            ),
                          ],
                        ).box
                        .height(60)
                        .color(textfieldGrey)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .make(),

                    10.heightBox,

                    // ✅ Color Section
                    Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Color:".text
                                      .color(textfieldGrey)
                                      .fontFamily(semibold)
                                      .make(),
                                ),
                                Row(
                                  children: List.generate(
                                    data['p_colors'].length,
                                    (index) => VxBox()
                                        .size(40, 40)
                                        .roundedFull
                                        .color(Color(data['p_colors'][index]).withOpacity(1.0))
                                        .margin(
                                          const EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                        )
                                        .make(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ).box.white.shadowSm
                        .padding(const EdgeInsets.all(8))
                        .make(),

                    10.heightBox,

                    // ✅ Quantity Section
                    Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity:".text
                                      .color(textfieldGrey)
                                      .fontFamily(semibold)
                                      .make(),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.remove),
                                    ),
                                    "0".text
                                        .fontFamily(bold)
                                        .size(16)
                                        .make()
                                        .box
                                        .width(40)
                                        .alignCenter
                                        .make(),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.add),
                                    ),
                                    "(0 available)".text
                                        .color(textfieldGrey)
                                        .make(),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total:".text
                                      .color(textfieldGrey)
                                      .fontFamily(semibold)
                                      .make(),
                                ),
                                "\$0.00".text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            ),
                          ],
                        ).box.white.shadowSm
                        .padding(const EdgeInsets.all(8))
                        .make(),

                    10.heightBox,

                    // ✅ Description Section
                    "Description".text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),

                    10.heightBox,
                    "This is a dummy item and dummy description here..".text
                        .color(darkFontGrey)
                        .make(),

                    10.heightBox,

                    // ✅ Buttons List Section (safe reference)
                    Column(
                      children: itemDetailButtonsList
                          .map(
                            (btnTitle) => ListTile(
                              title: btnTitle.text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              trailing: const Icon(Icons.arrow_forward),
                            ),
                          )
                          .toList(),
                    ),

                    // products may like section
                    productsyoumaylike.text
                        .fontFamily(bold)
                        .size(16)
                        .color(const Color.fromRGBO(62, 68, 71, 1))
                        .make(),
                    10.heightBox,

                    //widget from home screen
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
            ),
          ),

          // ✅ Bottom Add to Cart Button (RECTANGULAR)
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: redColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // rectangular shape
                ),
              ),
              onPressed: () {
                controller.addToCart(
                  color: data['p_colors'][controller.colorIndex.value],
                  context: context,
                  img: data['p_imgs'][0],
                  qty: controller.quantity.value,
                  sellername: data['p_seller'],
                  title: data['p_name'],
                  tprice: controller.totalPrice.value
                );
                VxToast.show(context, msg: "Added to cart");
              },
              child: Text(
                "Add to Cart",
                style: TextStyle(
                  color: whiteColor,
                  fontFamily: bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
