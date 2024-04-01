import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Admin_Login extends StatefulWidget {
  const Admin_Login({super.key});

  @override
  State<Admin_Login> createState() => _Admin_LoginState();
}

class _Admin_LoginState extends State<Admin_Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(224, 224, 146, 0.5019607843137255),
      body: Container(

        child: Stack(
          children: [


            Container(

              margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
              //height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.transparent,

                  image: DecorationImage(
                      image: AssetImage('images/admin.jpg'), // Replace 'path/to/your/image.jpg' with the actual path to your image asset
                      fit: BoxFit.fitHeight, // Adjust the image fit as needed

                    ),

                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 110.0))
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
              child: Form(
        //          key: _formkey,
                  child: Column(
                    children: [
                      Text(
                        "Let's start with\nAdmin!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20.0, top: 5.0, bottom: 5.0),
                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                        Color.fromARGB(255, 160, 160, 147)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: TextFormField(
            //                        controller: usernamecontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Username';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Username",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 160, 160, 147))),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20.0, top: 5.0, bottom: 5.0),
                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                        Color.fromARGB(255, 160, 160, 147)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: TextFormField(
      //                              controller: userpasswordcontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Password';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 160, 160, 147))),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                              GestureDetector(
                                onTap: (){
             //                     LoginAdmin();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.0),
                                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "LogIn",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

}


