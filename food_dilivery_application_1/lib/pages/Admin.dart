import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_dilivery_application_1/pages/viewitem.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  String _imageUrl = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _uploadImage(File file) async {
    try {
      // Check if the user is authenticated
      if (FirebaseAuth.instance.currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please sign in to upload an image!'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      // Check if the current user's email is "sureshgayan2001@gmail.com"
      final currentUserEmail = FirebaseAuth.instance.currentUser!.email;
      if (currentUserEmail != "sureshgayan2001@gmail.com") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('You are not authorized to upload images!'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      // If the user is authorized, proceed with the upload
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images')
          .child('${DateTime.now()}.jpg');
      await ref.putFile(file);
      String downloadUrl = await ref.getDownloadURL();
      setState(() {
        _imageUrl = downloadUrl;
      });
      print('Image uploaded successfully: $_imageUrl'); // Add this line
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  void _addFoodItem() async {
    try {
      if (_imageUrl.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please upload an image!'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      await FirebaseFirestore.instance.collection('food_items').add({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'price': double.parse(_priceController.text),
        'image_url': _imageUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Food item added successfully!'),
        backgroundColor: Colors.green,
      ));
      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      setState(() {
        _imageUrl = '';
      });
    } catch (e) {
      print('Error adding food item: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error adding food item! Please try again.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Container(

        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      File file = File(pickedFile.path);
                      _uploadImage(file);
                    }
                  },
                  child: Text('Upload Image'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                  ),
                ),
                SizedBox(height: 20),
                _imageUrl.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    _imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                    : SizedBox(height: 0),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addFoodItem();
                    }
                  },
                  child: Text('Add Food Item'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.green, // Text color
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewItemsPage()),
                    );
                  },
                  child: Text('View Items'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.orange, // Text color
                  ),
                ),
                SizedBox(height: 20),
                // Add a SizedBox to create space between the buttons and the image
                SizedBox(height: 20),
                // Add your image widget here
                Image.asset(
                  'images/84FpIkbEsTspn.png',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
