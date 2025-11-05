import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ✅ Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ✅ Login Method
  Future<UserCredential?> loginMethod({required BuildContext context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = userCredential.user;
      if (user != null) {
        // ensure Firestore user doc exists
        await _firestore.collection(usersCollection).doc(user.uid).set({
          'cart_count': "00",
          'wishlist_count': "00",
          'order_count': "00",
        }, SetOptions(merge: true));
      }

      // ✅ show success toast
      VxToast.show(context, msg: "Login successful");
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? "Login failed");
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // ✅ Signup Method
  Future<UserCredential?> signupMethod({required BuildContext context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = userCredential.user;
      if (user != null) {
        await _firestore.collection(usersCollection).doc(user.uid).set({
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
          'name': '',
          'imageUrl': '',
          'id': user.uid,
          'cart_count': "00",
          'wishlist_count': "00",
          'order_count': "00",
        });
      }

      VxToast.show(context, msg: "Signup successful");
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? "Signup failed");
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // ✅ Store User Data (after signup)
  Future<void> storeUserData({
    required String name,
    required String password,
    required String email,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      debugPrint("⚠️ No current user found while storing data.");
      return;
    }

    await _firestore.collection(usersCollection).doc(user.uid).set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': user.uid,
      'cart_count': "00",
      'wishlist_count': "00",
      'order_count': "00",
    }, SetOptions(merge: true));
  }

  // ✅ Signout Method
  Future<void> signoutMethod({required BuildContext context}) async {
    try {
      await _auth.signOut();
      emailController.clear();
      passwordController.clear();
      VxToast.show(context, msg: "Signed out successfully");
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
