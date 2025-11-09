import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/models/category_model.dart';

class ProductController extends GetxController {
  var subcat = [];

  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;

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

  addToCart(
      {title, img, sellername, color, qty, tprice, context}) async {
    if (qty > 0) {
      await firestore.collection(cartCollection).doc().set({
        'title': title,
        'img': img,
        'sellername': sellername,
        'color': color,
        'qty': qty,
        'tprice': tprice,
        'added_by': auth.currentUser!.uid,
      }).catchError((error) {
        VxToast.show(context, msg: error.toString());
      });
      VxToast.show(context, msg: "Added to cart");
    } else {
      VxToast.show(context, msg: "Quantity cannot be zero");
    }
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  // Corrected method name and implementation
  addToWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([auth.currentUser!.uid])
    }, SetOptions(merge: true));
    isFav.value = true;
    VxToast.show(context, msg: "Added to wishlist");
  }

  // Corrected method name and implementation
  removeFromWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([auth.currentUser!.uid])
    }, SetOptions(merge: true));
    isFav.value = false;
    VxToast.show(context, msg: "Removed from wishlist");
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(auth.currentUser!.uid)) {
      isFav.value = true;
    } else {
      isFav.value = false;
    }
  }
}
