import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_dilivery_application_1/pages/update_item.dart';

class ViewItemsPage extends StatefulWidget {
  @override
  _ViewItemsPageState createState() => _ViewItemsPageState();
}

class _ViewItemsPageState extends State<ViewItemsPage> {
  late Stream<QuerySnapshot> _foodItemsStream;

  @override
  void initState() {
    super.initState();
    _foodItemsStream = FirebaseFirestore.instance.collection('food_items').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Items'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _foodItemsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No items available.'),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                subtitle: Text(data['description']),
                trailing: PopupMenuButton<String>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'update',
                      child: Text('Update'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'update') {
                      _handleUpdateItem(document.id, data);
                    } else if (value == 'delete') {
                      _handleDeleteItem(document.id);
                    }
                  },
                ),
                leading: _buildImageWidget(data['image_url']),
              );
            }).toList(),
          );

        },
      ),
    );
  }

  void _handleUpdateItem(String documentId, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateItemPage(documentId: documentId, itemData: data),
      ),
    );
  }

  void _handleDeleteItem(String documentId) {
    FirebaseFirestore.instance.collection('food_items').doc(documentId).delete()
        .then((value) {
      print('Item deleted successfully');
    })
        .catchError((error) {
      print('Failed to delete item: $error');
    });
  }


  Widget _buildImageWidget(String imageUrl) {
    if (imageUrl.isNotEmpty) {
      return CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      );
    } else {
      return CircleAvatar(
        child: Icon(Icons.image),
      );
    }
  }
}
