import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/product_controller.dart';
import 'package:myapp/services/firestore_services.dart';
import 'package:myapp/widgets_common/bg_widget.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/views/category_screen/item_details.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;

  const CategoryDetails({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
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
        body: StreamBuilder(
          stream: FirestoreServices.getProducts(title), builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return  Center(
                child: CircularProgressIndicator(),
              );
            }else if(snapshot.data!.docs.isEmpty){
              return Center(
                child: "No products Found!".text.color(darkFontGrey).make(),
              );
            }else{

              var data = snapshot.data!.docs;

              return Container(
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
                          controller.subcat.length,
                              (index) => "${controller.subcat[index]}".text
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
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // ✅ Navigate to ItemDetails screen
                              Get.to(() => ItemDetails(title: "${data[index]['p_name']}",data: data[index]));
                            },
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]['p_imgs'][0],
                                  width: 200,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                10.heightBox,
                                "${data[index]['p_name']}".text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                5.heightBox,
                                "${data[index]['p_price']}".numCurrency.text
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
              );
            }
        },
        ),
      ),
    );
  }
}
