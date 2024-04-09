import 'package:flutter/material.dart';

class CartItemModel {
  final String itemName;
  final double itemPrice;
  final int quantity;
  final String imageUrl;

  CartItemModel({
    required this.itemName,
    required this.itemPrice,
    required this.quantity,
    required this.imageUrl,
  });

  // Convert CartItemModel object to a Map
  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'itemPrice': itemPrice,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  // Create CartItemModel object from a Map
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      itemName: map['itemName'],
      itemPrice: map['itemPrice'],
      quantity: map['quantity'],
      imageUrl: map['imageUrl'],
    );
  }
}
