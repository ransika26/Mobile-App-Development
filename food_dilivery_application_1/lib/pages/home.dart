import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dilivery_application_1/pages/details.dart';
import 'package:food_dilivery_application_1/services/shared_preferences.dart';
import 'package:food_dilivery_application_1/widget/widget_suppor.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Stream<QuerySnapshot> _foodItemsStream;
  late User? _currentUser;
  String name = 'User';
  @override
  void initState() {
    super.initState();
    _foodItemsStream = FirebaseFirestore.instance.collection('food_items').snapshots();
    _currentUser = FirebaseAuth.instance.currentUser;
    getthesharedpref();
  }

  //Dynimically Name Fetching

  Future<void> getthesharedpref() async {
    try {




      // Get the authenticated user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Get the user document from Firestore using the user's UID
        DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        // get name from the user document
        if (userDoc.exists) {
          name = userDoc['name'];

          setState(() {});
        } else {
          print('User document does not exist');

        }
      }
    } catch (e) {

      print("Error fetching user data: $e");

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color.fromRGBO(61, 108, 9, 1.0),
              height: 80.0,
              child: Row(
                children: [
                  SizedBox(width: 30.0),
                  Text(
                    "Hello, $name",
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  SizedBox(width: 170.0),
                  Container(
                    margin: const EdgeInsets.only(top: 25.0, left: 0.0, right: 10.0),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                    child: Icon(Icons.shopping_cart, color: Colors.black),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25.0, left: 0.0, right: 10.0),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                    child: Icon(Icons.search_off, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Text(
              "organic delights,",
              style: AppWidget.HeadLineTextFieldStyle(),
            ),
            Text(
              "Explore our selection of fresh, locally-sourced organic foods",
              style: AppWidget.LightTextFieldStyle(),
            ),
            SizedBox(height: 30.0),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('food_items').where('category', isEqualTo: 'vegetable').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No vegetable items available.'));
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data!.docs.map((document) {
                      var data = document.data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Details(
                              itemName: data['name'],
                              itemDescription: data['description'],
                              itemPrice: data['price'],
                              imageUrl: data['image_url'],
                            )),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              padding: EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    data['image_url'],
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    data['name'],
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    data['description'],
                                    style: AppWidget.LightTextFieldStyle(),
                                  ),
                                  Text(
                                    'Rs.${data['price']}',
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            SizedBox(height: 30.0),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('food_items').where('category', isEqualTo: 'fruit').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No fruit items available.'));
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data!.docs.map((document) {
                      var data = document.data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Details(
                              itemName: data['name'],
                              itemDescription: data['description'],
                              itemPrice: data['price'],
                              imageUrl: data['image_url'],
                            )),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              padding: EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    data['image_url'],
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    data['name'],
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    data['description'],
                                    style: AppWidget.LightTextFieldStyle(),
                                  ),
                                  Text(
                                    'Rs.${data['price']}',
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            SizedBox(height: 30.0),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('food_items').where('category', isEqualTo: 'other').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No other items available.'));
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data!.docs.map((document) {
                      var data = document.data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Details(
                              itemName: data['name'],
                              itemDescription: data['description'],
                              itemPrice: data['price'],
                              imageUrl: data['image_url'],
                            )),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              padding: EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    data['image_url'],
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    data['name'],
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    data['description'],
                                    style: AppWidget.LightTextFieldStyle(),
                                  ),
                                  Text(
                                    'Rs.${data['price']}',
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
