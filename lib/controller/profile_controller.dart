// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/consts/consts.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;
  var profileImgLink = ''.obs;
  var isLoading = false.obs;

  var storage;
  final nameController = TextEditingController();
  final oldpassController = TextEditingController();
  final newpassController = TextEditingController();

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

  Future<void> uploadProfileImage() async {
    if (profileImgPath.value.isEmpty) return;
    final filename = basename(profileImgPath.value);
    final destination = 'profile_images/${auth.currentUser!.uid}/$filename';

    try {
      Reference ref = storage.ref().child(destination);
      await ref.putFile(File(profileImgPath.value));
      profileImgLink.value = await ref.getDownloadURL();
    } catch (e) {
      debugPrint("Error uploading profile image: $e");
    }
  }

  Future<void> updateProfile({required String name, required String imgUrl}) async {
    var store = firestore.collection(usersCollection).doc(auth.currentUser!.uid);
    await store.set({
      'name': name,
      'imageUrl': imgUrl,
    }, SetOptions(merge: true));
  }

  // ✅ Returns true on success, false on failure
  Future<bool> changeAuthPassword(
      {required BuildContext context, required String email, required String oldPassword, required String newPassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: oldPassword);

    try {
      await auth.currentUser!.reauthenticateWithCredential(cred);
      await auth.currentUser!.updatePassword(newPassword);
      return true; // Return true on success
    } on FirebaseAuthException catch (e) {
      // On failure, show an error message and return false.
      String errorMessage;
      switch (e.code) {
        case 'wrong-password':
          errorMessage = 'The old password you entered is incorrect.';
          break;
        case 'weak-password':
          errorMessage = 'The new password is too weak.';
          break;
        default:
          errorMessage = e.message ?? "An error occurred.";
      }
      VxToast.show(context, msg: errorMessage);
      return false;
    } catch (e) {
      VxToast.show(context, msg: "An unexpected error occurred.");
      return false;
    }
  }
}
