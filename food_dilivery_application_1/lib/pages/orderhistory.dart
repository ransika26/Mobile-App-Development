import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class ViewOrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order History',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(61, 108, 9, 1.0),
        centerTitle: true,
      ),
      body: OrderHistoryList(),
    );
  }
}

class OrderHistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collectionGroup('orders').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No order history available'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final order = snapshot.data!.docs[index];
            final orderId = order.id;

            final userId = order['userId'];
            final userName = order['userName'];
            final totalAmount = order['totalAmount'];
            final createdAtTimestamp = order['createdAt'] as Timestamp;
            final createdAt = DateFormat.yMMMd().add_jm().format(createdAtTimestamp.toDate());
            final items = order['items'] as List<dynamic>;

            // Construct a string representing the items in the order
            String itemsString = '';
            for (var item in items) {
              itemsString += '${item['name']} (${item['quantity']}), ';
            }
            itemsString = itemsString.substring(0, itemsString.length - 2);

            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(
                  'Order ID: $orderId',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),

                    Text('User Name: $userName'),
                    Text('Total Amount: $totalAmount'),
                    Text('Created At: $createdAt'),
                    Text('Items: $itemsString'),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}