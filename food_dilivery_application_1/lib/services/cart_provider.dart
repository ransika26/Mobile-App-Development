import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_dilivery_application_1/services/CartItemModel.dart';


class CartProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<CartItemModel> _cartItems = [];

  Future<void> addToCart(CartItemModel item) async {
    try {
      await _firestore.collection('cart').add(item.toMap());
      notifyListeners();
    } catch (error) {
      print('Error adding item to cart: $error');
    }
  }

  Future<void> removeFromCart(String itemId) async {
    try {
      await _firestore.collection('cart').doc(itemId).delete();
      notifyListeners();
    } catch (error) {
      print('Error removing item from cart: $error');
    }
  }

  // Getter to retrieve cart items
  List<CartItemModel> get cartItems => _cartItems;
}
