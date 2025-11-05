import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';

class HomeController extends GetxController {
  // Firebase references
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Navigation
  var currentNavIndex = 0.obs; // ✅ Added for BottomNavigationBar control

  // Observables
  var username = ''.obs;
  var email = ''.obs;
  var imageUrl = ''.obs;
  var cartCount = '00'.obs;
  var wishlistCount = '00'.obs;
  var orderCount = '00'.obs;
  var isLoading = false.obs;

  // Get current user ID
  String get currentUserId => _auth.currentUser?.uid ?? '';

  @override
  void onInit() {
    super.onInit();
    fetchUserData();

    // ✅ Auto-refresh when switching to Profile tab (index = 3)
    ever(currentNavIndex, (index) {
      if (index == 3) {
        fetchUserData();
      }
    });
  }

  // ✅ Fetch user data from Firestore
  Future<void> fetchUserData() async {
    if (currentUserId.isEmpty) {
      debugPrint("⚠️ No user signed in");
      return;
    }

    try {
      isLoading(true);
      final DocumentSnapshot snapshot = await _firestore
          .collection(usersCollection)
          .doc(currentUserId)
          .get(const GetOptions(source: Source.serverAndCache));

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        username.value = data['name'] ?? '';
        email.value = data['email'] ?? '';
        imageUrl.value = data['imageUrl'] ?? '';
        cartCount.value = data['cart_count']?.toString() ?? '00';
        wishlistCount.value = data['wishlist_count']?.toString() ?? '00';
        orderCount.value = data['order_count']?.toString() ?? '00';
      } else {
        debugPrint("⚠️ User document not found for $currentUserId");
      }
    } catch (e) {
      debugPrint("❌ Error fetching user data: $e");
    } finally {
      isLoading(false);
    }
  }

  // ✅ Refresh user data manually (after updates)
  Future<void> refreshUserData() async {
    await fetchUserData();
  }

  // ✅ Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      username.value = '';
      email.value = '';
      imageUrl.value = '';
      cartCount.value = '00';
      wishlistCount.value = '00';
      orderCount.value = '00';
      debugPrint("✅ User signed out successfully");
    } catch (e) {
      debugPrint("❌ Error signing out: $e");
    }
  }
}
