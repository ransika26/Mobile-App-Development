import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:food_dilivery_application_1/services/cart_provider.dart';
import 'package:food_dilivery_application_1/services/create_order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the current user ID
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Green Cart',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(61, 108, 9, 1.0),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey,
        child: StreamBuilder(
          // Use the user's cart collection
          stream: FirebaseFirestore.instance.collection('users').doc(userId).collection('cart').snapshots(),
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
                        userId: userId, // Pass userId to CartItem
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
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        '\Rs.$totalAmount',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20), // space between total amount and checkout button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Proceed to PayPal payment
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => UsePaypal(
                              sandboxMode: true,
                              clientId: "AaT8FlEwVbc5LEPdtYZCpGlrl5uNI-l_UQgBmhgp9u91xManFNPGowGAb-qjKcYcrSXRcAezS5jL8StJ",
                              secretKey: "EHyPFZdkaSgDA6vJ32yMyPE5_rf3mLIVI1oIXeBNOUZU-BksiNt7_Zn68xeSWqEQQw972rRoii_qDpsW",
                              returnURL: "https://example.com/return",
                              cancelURL: "https://example.com/cancel",
                              transactions: [
                                {
                                  "amount": {
                                    "total": totalAmount.toStringAsFixed(2),
                                    "currency": "USD",
                                    "details": {
                                      "subtotal": totalAmount.toStringAsFixed(2),
                                      "shipping": '0',
                                      "shipping_discount": 0
                                    }
                                  },
                                  "description": "Payment for items in the cart",
                                  "item_list": {
                                    "items": snapshot.data!.docs.map((doc) {
                                      final itemName = doc['itemName'];
                                      final itemPrice = doc['itemPrice'];
                                      final quantity = doc['quantity'];
                                      return {
                                        "name": itemName,
                                        "quantity": quantity,
                                        "price": itemPrice.toStringAsFixed(2),
                                        "currency": "USD"
                                      };
                                    }).toList(),
                                    "shipping_address": {
                                      "line1": "123 Main St", //street address
                                      "city": "New York", // city name
                                      "country_code": "US", // country code
                                      "postal_code": "12345", //postal code
                                    }
                                  }
                                }
                              ],
                              note: "Payment for items in the cart.", // Shortened note
                              onSuccess: (params) {
                                // Handle successful payment
                                print("Payment successful");

                                // Retrieve the user ID of the current user
                                final User? user = FirebaseAuth.instance.currentUser;
                                if (user != null) {
                                  String userId = user.uid;

                                  // Fetch user document from Firestore
                                  FirebaseFirestore.instance.collection('users').doc(userId).get().then((userData) {
                                    if (userData.exists) {
                                      // Retrieve user's name from Firestore
                                      String userName = userData.data()!['name'];
                                      String useremail = userData.data()!['email'];
                                      print('User Name: $userName');
                                      print('User Email: $useremail');

                                      // Create orders object and store it in Firebase
                                      List<Map<String, dynamic>> itemsList = snapshot.data!.docs.map((doc) {
                                        final itemName = doc['itemName'];
                                        final itemPrice = doc['itemPrice'];
                                        final quantity = doc['quantity'];
                                        return {
                                          "name": itemName,
                                          "quantity": quantity,
                                          "price": itemPrice.toDouble(), // Convert to double
                                          "currency": "USD"
                                        };
                                      }).toList();

                                      Orders orders = Orders(
                                        userId: userId,
                                        userName: userName,
                                        totalAmount: totalAmount, // Pass totalAmount directly
                                        items: itemsList,
                                        createdAt: Timestamp.now().toDate(), // Convert Timestamp to DateTime
                                      );

                                      // Store the order with a unique ID based on Firestore's auto-generated ID
                                      FirebaseFirestore.instance.collection('users').doc(userId).collection('orders').add(orders.toMap());

                                      // Send email to the user
                                      sendEmail(useremail);
                                    } else {
                                      print('User data not found');
                                    }
                                  }).catchError((error) {
                                    print('Error fetching user data: $error');
                                  });
                                } else {
                                  print("User not signed in");
                                }
                              },

                              onError: (error) {
                                print("Payment error: $error");
                              },
                              onCancel: (params) {
                                print("Payment cancelled");
                              },
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
                SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

//this is the card for each item in the cart

class CartItem extends StatelessWidget {
  final String itemName;
  final double itemPrice;
  final int quantity;
  final String imageUrl;
  final String cartItemId;
  final String userId; // Add userId as a parameter

  const CartItem({
    required this.itemName,
    required this.itemPrice,
    required this.quantity,
    required this.imageUrl,
    required this.cartItemId,
    required this.userId, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.black),
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
            '\Rs.$itemPrice x $quantity',
            style: TextStyle(fontSize: 16, color: Colors.green),
          ),
          trailing: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () {
                // Delete the item from the cart using CartProvider
                Provider.of<CartProvider>(context, listen: false).removeFromCart(userId, cartItemId);
              },
              child: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> sendEmail(String userEmail) async {
  final smtpServer = gmail('greenmartnsbm@gmail.com', 'green@123');

  final message = Message()
    ..from = Address('greenmartnsbm@gmail.com', 'GreenEats')
    ..recipients.add(userEmail) // Add recipient's email address
    ..subject = 'Payment Confirmation'
    ..text = 'Your payment was successful. Thank you for your purchase!';

  try {
    await send(message, smtpServer);
    print('Email sent successfully');
  } catch (error) {
    print('Error sending email: $error');
  }
}
