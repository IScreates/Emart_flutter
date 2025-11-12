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
  static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
  }
  
  static getCart(id){
    return firestore.collection(cartCollection).where('added_by', isEqualTo: id).snapshots();
  }

  //get all chat msg
static getChatMessages(docId){
    return firestore.collection(chatCollection).doc(docId).collection(messagesCollection).orderBy('created_on', descending: false).snapshots();
}

  static getAllMessages() {
    return firestore
        .collection(chatCollection)
        .where('fromId', isEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  static getAllOrders(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo: auth.currentUser!.uid).snapshots();
  }
  
  static getWishList(){
    return firestore.collection(productsCollection).where('p_wishlist',arrayContains:  auth.currentUser!.uid).snapshots();
  }

  static allProducts(){
    return firestore
        .collection(productsCollection)
        .snapshots();
  }

  // get featuredproduct
static getFeaturedProducts() {
    return firestore.collection(productsCollection).where('is_Featured',isEqualTo: true).get();
}

static searchProducts(title){
    return firestore.collection(productsCollection).get();
}


}
