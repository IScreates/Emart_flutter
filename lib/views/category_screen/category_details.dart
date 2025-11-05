import 'package:get/get.dart';
import 'package:myapp/widgets_common/bg_widget.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/views/category_screen/item_details.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;

  const CategoryDetails({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: redColor,
          elevation: 0,
          title: Text(
            title ?? "Category",
            style: const TextStyle(color: whiteColor, fontFamily: bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Horizontal subcategory scroll
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    6,
                    (index) => "Baby Clothing".text
                        .size(12)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .makeCentered()
                        .box
                        .white
                        .rounded
                        .size(120, 60)
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .make(),
                  ),
                ),
              ),

              10.heightBox,

              // ✅ Item grid
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 250,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // ✅ Navigate to ItemDetails screen
                        Get.to(() => ItemDetails(title: "Dummy Item"));
                      },
                      child:
                          Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    imgP5,
                                    width: 200,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  10.heightBox,
                                  "Laptop 4GB/64GB ${index + 1}".text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  5.heightBox,
                                  "\$${600 + index * 10}".text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make(),
                                ],
                              ).box.white.roundedSM
                              .padding(const EdgeInsets.all(8))
                              .outerShadowSm
                              .make(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
