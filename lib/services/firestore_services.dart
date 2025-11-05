import 'package:myapp/consts/firebase_const.dart';

class FirestoreServices {
  //get users data
  static getUser(id) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: id)
        .snapshots();
  }
}
