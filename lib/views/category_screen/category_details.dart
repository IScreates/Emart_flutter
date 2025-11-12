import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/product_controller.dart';
import 'package:myapp/services/firestore_services.dart';
import 'package:myapp/widgets_common/bg_widget.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/views/category_screen/item_details.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;

  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  late ProductController controller;
  late Rx<Stream<QuerySnapshot>> productStream;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProductController());
    productStream = Rx<Stream<QuerySnapshot>>(FirestoreServices.getProducts(widget.title));
    controller.getSubCategories(widget.title);
  }

  void switchCategory(title) {
    productStream.value = controller.subcat.contains(title)
        ? FirestoreServices.getSubCategoryProducts(title)
        : FirestoreServices.getProducts(title);
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: redColor,
        elevation: 0,
        title: Text(
          widget.title ?? "Category",
          style: const TextStyle(color: whiteColor, fontFamily: bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubCategoryList(),
            20.heightBox,
            _buildProductGrid(),
          ],
        ),
      ),
    ));
  }

  Widget _buildSubCategoryList() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => Row(
          children: List.generate(
            controller.subcat.length,
            (index) => "${controller.subcat[index]}"
                .text
                .size(12)
                .fontFamily(semibold)
                .color(darkFontGrey)
                .makeCentered()
                .box
                .white
                .rounded
                .size(120, 60)
                .margin(const EdgeInsets.symmetric(horizontal: 4))
                .make()
                .onTap(() {
              switchCategory("${controller.subcat[index]}");
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return Obx(
      () => StreamBuilder(
        stream: productStream.value,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No products Found!"
                .text
                .color(darkFontGrey)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 250,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return _ProductGridItem(
                  data: data[index],
                  onTap: () {
                    controller.checkIfFav(data[index]);
                    Get.to(() => ItemDetails(
                        title: "${data[index]['p_name']}",
                        data: data[index]));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class _ProductGridItem extends StatelessWidget {
  final QueryDocumentSnapshot data;
  final VoidCallback onTap;

  const _ProductGridItem({Key? key, required this.data, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            data['p_imgs'][0],
            width: 200,
            height: 150,
            fit: BoxFit.cover,
          ),
          10.heightBox,
          "${data['p_name']}"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
          5.heightBox,
          "${data['p_price']}"
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
          .roundedSM
          .padding(const EdgeInsets.all(8))
          .outerShadowSm
          .make(),
    );
  }
}