import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/models/category_model.dart';

class ProductController extends GetXController{

  var subcat = [];

  var  quantity  = 0.obs;

  getSubCategories(title) async{
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s = decoded.categories.where((element)=> element.name  == title).toList();

    for(var e in s[0].subcategory){
      subcat.add(e);
    }
  }

  addToCart({
    title, img, sellername, color, qty, tprice,context
}) async{
    var currentUser;
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'tprice': tprice,
      'added_by': currentUser!.uid,
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }
}

class GetXController {
}