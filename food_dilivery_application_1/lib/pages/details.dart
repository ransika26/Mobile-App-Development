import 'package:flutter/material.dart';

import 'package:food_dilivery_application_1/widget/widget_suppor.dart';
class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //following Gesture used to navigate again to home
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,)),
            Image.asset("images/salad2.png",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                fit: BoxFit.fill,
            ),


            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mediterranean", style: AppWidget.semiBoldTextFieldStyle(),),
                    Text("ChickPea Salad", style: AppWidget.HeadLineTextFieldStyle(),),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (a > 1) {
                      --a;

                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.remove, color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20.0,
                ),
                Text(a.toString(), style: AppWidget.semiBoldTextFieldStyle(),
                ),
                SizedBox(width: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    ++a;

                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.add, color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Text("csdcvsd feswjw nfjesjf n fw", style: AppWidget.semiBoldTextFieldStyle(),
            ),


               Row(
                children: [
                  Text("Delivery Time", style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                  SizedBox(width: 25.0,
                  ),
                  Icon(Icons.alarm, color: Colors.black54,
                  ),
                  SizedBox(width: 5.0,
                  ),
                  Text("30 min", style: AppWidget.semiBoldTextFieldStyle(),
                  )
                ],
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
                    Text("Total Price", style: AppWidget.semiBoldTextFieldStyle(),
                    ),
                    Text("\$250",style: AppWidget.HeadLineTextFieldStyle(),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(15)),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                      Text("Add to cart", style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: 'Poppins'),
                      ),
                      SizedBox(width:30.0),
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.shopping_cart_outlined, color: Colors.white,
                        ),
                      ),
                      SizedBox(width:10.0),
                    ],
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
