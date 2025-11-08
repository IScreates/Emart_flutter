import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/models/category_model.dart';

class ProductController extends GetxController {
  var subcat = [];

  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s = decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart({
    title, img, sellername, color, qty, tprice, context
  }) async {
    // Prevent adding if quantity is zero
    if (qty > 0) {
      await firestore.collection(cartCollection).doc().set({
        'title': title,
        'img': img,
        'sellername': sellername,
        'color': color,
        'qty': qty,
        'tprice': tprice,
        // Correctly get the user ID from the auth instance
        'added_by': auth.currentUser!.uid,
      }).catchError((error) {
        VxToast.show(context, msg: error.toString());
      });
      VxToast.show(context, msg: "Added to cart");
    } else {
      VxToast.show(context, msg: "Quantity cannot be zero");
    }
  }
  
  resetValues(){
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }
}
