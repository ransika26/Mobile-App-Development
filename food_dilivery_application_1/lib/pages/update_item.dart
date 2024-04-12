import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage; // Import firebase_storage namespace
import 'package:image_picker/image_picker.dart';

class UpdateItemPage extends StatefulWidget {
  final String documentId;
  final Map<String, dynamic> itemData;

  UpdateItemPage({required this.documentId, required this.itemData});

  @override
  _UpdateItemPageState createState() => _UpdateItemPageState();
}

class _UpdateItemPageState extends State<UpdateItemPage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  File? _image; // Initialize _image to null
  late TextEditingController _imageUrlController; // Controller for image URL

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.itemData['name']);
    _descriptionController = TextEditingController(text: widget.itemData['description']);
    _priceController = TextEditingController(text: widget.itemData['price'].toString());
    _imageUrlController = TextEditingController(text: widget.itemData['image_url']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateItem() async {
    try {
      String imageUrl = widget.itemData['image_url'];
      if (_image != null) {
        // If a new image was selected, upload it to Firebase Storage
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('images')
            .child('${DateTime.now()}.jpg');
        await ref.putFile(_image!);
        imageUrl = await ref.getDownloadURL();
      }

      // Update the item in Firestore with the new image URL
      FirebaseFirestore.instance.collection('food_items').doc(widget.documentId).update({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'price': double.parse(_priceController.text),
        'image_url': imageUrl,
      });

      Navigator.pop(context); // Pop the update page after updating
    } catch (error) {
      print('Error updating item: $error');
      // Handle error if necessary
    }
  }

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imageUrlController.text = ''; // Clear the image URL field if an image is selected
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Select Image'), 
            ),
            SizedBox(height: 20),
            _image != null
                ? Image.file(_image!, height: 200) // Display the selected image
                : _imageUrlController.text.isNotEmpty
                ? Image.network(_imageUrlController.text, height: 200) // Display existing image if available
                : SizedBox.shrink(), // Hide image widget if no image is selected or available
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateItem,
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
