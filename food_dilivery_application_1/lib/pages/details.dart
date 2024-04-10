import 'package:flutter/material.dart';
import 'package:food_dilivery_application_1/services/CartItemModel.dart';
import 'package:food_dilivery_application_1/services/cart_provider.dart';
import 'package:food_dilivery_application_1/widget/widget_suppor.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final String itemName;
  final String itemDescription;
  final double itemPrice;
  final String imageUrl;

  const Details({
    required this.itemName,
    required this.itemDescription,
    required this.itemPrice,
    required this.imageUrl,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
            Image.network(
              widget.imageUrl,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.fill,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.itemName,
                      style: AppWidget.semiBoldTextFieldStyle(),
                    ),
                    Text(
                      widget.itemDescription,
                      style: AppWidget.HeadLineTextFieldStyle(),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                Text(
                  quantity.toString(),
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
                SizedBox(width: 20.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Text(
              "Delivery Time: 30 min",
              style: AppWidget.semiBoldTextFieldStyle(),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price",
                        style: AppWidget.semiBoldTextFieldStyle(),
                      ),
                      Text(
                        '\$${(widget.itemPrice * quantity).toStringAsFixed(2)}',
                        style: AppWidget.HeadLineTextFieldStyle(),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // Create a CartItemModel object with the details of the item
                      CartItemModel cartItem = CartItemModel(
                        itemName: widget.itemName,
                        itemPrice: widget.itemPrice,
                        quantity: quantity,
                        imageUrl: widget.imageUrl,
                      );
                      // Add the item to the cart using CartProvider
                      context.read<CartProvider>().addToCart(cartItem);
                      // Show a snackbar ,item was added to the cart
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Item added to cart'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Add to cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(width: 30.0),
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10.0),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
