import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:food_dilivery_application_1/services/cart_provider.dart';
import 'package:food_dilivery_application_1/services/create_order_model.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('cart').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No items in cart'));
          }

          // Calculate total amount
          double totalAmount = snapshot.data!.docs.fold(0, (total, doc) {
            final itemPrice = doc['itemPrice'] as double;
            final quantity = doc['quantity'] as int;
            return total + (itemPrice * quantity);
          });

          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: snapshot.data!.docs.map((doc) {
                    final itemName = doc['itemName'];
                    final itemPrice = doc['itemPrice'];
                    final quantity = doc['quantity'];
                    final imageUrl = doc['imageUrl'];
                    final cartItemId = doc.id;

                    return CartItem(
                      itemName: itemName,
                      itemPrice: itemPrice,
                      quantity: quantity,
                      imageUrl: imageUrl,
                      cartItemId: cartItemId,
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$$totalAmount',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // space between total amount and checkout button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('Checkout', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

//this the card for the each item in the cart

class CartItem extends StatelessWidget {
  final String itemName;
  final double itemPrice;
  final int quantity;
  final String imageUrl;
  final String cartItemId;

  const CartItem({
    required this.itemName,
    required this.itemPrice,
    required this.quantity,
    required this.imageUrl,
    required this.cartItemId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.red[300]!),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 4)],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              itemName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Text(
            '\$$itemPrice x $quantity',
            style: TextStyle(fontSize: 16, color: Colors.green),
          ),
          trailing: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () {
                // Delete the item from the cart using CartProvider
                Provider.of<CartProvider>(context, listen: false).removeFromCart(cartItemId);
              },
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
