// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/consts/consts.dart';
import 'package:path/path.dart'; // ✅ Ensure path: ^1.9.0 in pubspec.yaml

class ProfileController extends GetxController {
  // ✅ Observables
  var profileImgPath = ''.obs;
  var profileImgLink = ''.obs;
  var isLoading = false.obs;

  // ✅ Text controllers
  final nameController = TextEditingController();
  final passController = TextEditingController();

  // ✅ Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ✅ Pick image from gallery
  Future<void> changeImage(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final XFile? img = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (img == null) return;
      profileImgPath.value = img.path;

      if (context.mounted) {
        VxToast.show(context, msg: "Image selected successfully");
      }
    } on PlatformException catch (e) {
      if (context.mounted) {
        VxToast.show(context, msg: "Platform error: ${e.message}");
      }
    } catch (e) {
      if (context.mounted) {
        VxToast.show(context, msg: "Error: $e");
      }
    }
  }

  // ✅ Upload profile image to Firebase Storage
  Future<void> uploadProfileImage() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        debugPrint("⚠️ No user found to upload profile image.");
        return;
      }

      final filename = basename(profileImgPath.value);
      final destination = 'profile_images/${user.uid}/$filename';

      Reference ref = _storage.ref().child(destination);
      await ref.putFile(File(profileImgPath.value));

      final downloadUrl = await ref.getDownloadURL();
      profileImgLink.value = downloadUrl;
      debugPrint("✅ Profile image uploaded: $downloadUrl");
    } catch (e) {
      debugPrint("❌ Error uploading profile image: $e");
    }
  }

  // ✅ Update user info in Firestore
  Future<void> updateProfile({
    required BuildContext context,
    required String name,
    required String password,
  }) async {
    try {
      isLoading(true);

      final user = _auth.currentUser;
      if (user == null) {
        VxToast.show(context, msg: "No user logged in");
        return;
      }

      String imageUrl = profileImgLink.value;

      // If no new image uploaded, retain existing one
      if (imageUrl.isEmpty) {
        final doc = await _firestore
            .collection(usersCollection)
            .doc(user.uid)
            .get();
        imageUrl = doc.data()?['imageUrl'] ?? '';
      }

      await _firestore.collection(usersCollection).doc(user.uid).set({
        'name': name,
        'password': password,
        'imageUrl': imageUrl,
      }, SetOptions(merge: true));

      VxToast.show(context, msg: "Profile updated successfully");
    } catch (e) {
      VxToast.show(context, msg: "Error updating profile: $e");
      debugPrint("❌ Error updating profile: $e");
    } finally {
      isLoading(false);
    }
  }
}
