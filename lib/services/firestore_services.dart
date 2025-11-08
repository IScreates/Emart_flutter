import 'package:myapp/consts/firebase_const.dart';

class FirestoreServices {
  //get users data
  static getUser(id) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: id)
        .snapshots();
  }

  //get product according to category
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  //get product according to subcategory
  static getSubCategoryProducts(title) {
    return firestore
        .collection(productsCollection)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }
  
  static getCart(id){
    return firestore.collection(cartCollection).where('added_by', isEqualTo: id).snapshots();
  }
}
