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
   return firestore.collection(productsCollection).where('p_category',isEqualTo: category).snapshots();
  }

}
