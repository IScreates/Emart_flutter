import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
const usersCollection = "users";

const productsCollection = "products";
const cartCollection = "cart";
const ordersCollection = "orders";
const addressesCollection = "addresses";
const categoriesCollection = "categories";