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

  //delete document
  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  static getCart(id) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: id)
        .snapshots();
  }

  //get all chat msg
  static getChatMessages(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: true)
        .snapshots();
  }

  //get all messages
  static getAllMessages() {
    return firestore
        .collection(chatCollection)
        .where('fromId', isEqualTo: auth.currentUser!.uid)
        .snapshots();
  }
}
