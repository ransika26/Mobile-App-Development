import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_dilivery_application_1/pages/details.dart';
import 'package:food_dilivery_application_1/widget/widget_suppor.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Stream<QuerySnapshot> _foodItemsStream;
  bool icecream = false, pizza = false, salad = false, burger = false;

  @override
  void initState() {
    super.initState();
    _foodItemsStream = FirebaseFirestore.instance.collection('food_items').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color.fromRGBO(159, 10, 10, 1.0),
              height: 80.0,
              child: Row(
                children: [
                  SizedBox(width: 30.0),
                  Text(
                    "Hello, suresh",
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  SizedBox(width: 120.0),
                  Container(
                    margin: const EdgeInsets.only(top: 25.0, left: 0.0, right: 10.0),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                    child: Icon(Icons.shopping_cart, color: Colors.red),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25.0, left: 0.0, right: 10.0),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                    child: Icon(Icons.account_balance, color: Colors.red),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25.0, left: 0.0, right: 10.0),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                    child: Icon(Icons.search_off, color: Colors.red),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Text(
              "Delicious Food",
              style: AppWidget.HeadLineTextFieldStyle(),
            ),
            Text(
              "Discover and Get Great Food",
              style: AppWidget.LightTextFieldStyle(),
            ),
            showItem(),
            SizedBox(height: 30.0),

            //using this we are dynamically adding our data from Firebase
            StreamBuilder<QuerySnapshot>(
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
                              itemName: data['name'], // Pass the item name
                              itemDescription: data['description'], // Pass the item description
                              itemPrice: data['price'], // Pass the item price
                              imageUrl: data['image_url'], // Pass the item image URL
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

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              icecream = true;
              pizza = false;
              salad = false;
              burger = false;
            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: icecream ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/Ice-cream-sundae-hero-11.jpg',
                height: 60.0,
                width: 60.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              icecream = false;
              pizza = true;
              salad = false;
              burger = false;
            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: pizza ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/pizza-youtubers-cooking.jpg',
                height: 60.0,
                width: 60.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              icecream = false;
              pizza = false;
              salad = true;
              burger = false;
            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: salad ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/fried-rice-recipe-card.jpg',
                height: 60.0,
                width: 60.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              icecream = false;
              pizza = false;
              salad = false;
              burger = true;
            });
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: burger ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/images.jpeg',
                height: 60.0,
                width: 60.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
