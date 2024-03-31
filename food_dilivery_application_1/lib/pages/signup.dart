


import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:food_dilivery_application_1/pages/login.dart';
import 'package:food_dilivery_application_1/pages/bottomnav.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}



class _SignupPageState extends State<SignupPage> {


  String email="",password="",name="";
  TextEditingController namecontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  TextEditingController mailcontroller = TextEditingController();

  final _formKey=GlobalKey<FormState>();  //to find user inputting the correct inputs to the text fields

  registration() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword( email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar((const SnackBar(backgroundColor: Colors.redAccent,content: Text("Registered Successfully", style: TextStyle(fontSize: 20.0),)
          )
          )
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const BottomNav()));
    }on FirebaseException catch(e){
      if(e.code=='weak-password'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.orangeAccent,
            content: Text("Password Provided is too Weak", style: TextStyle(fontSize: 18.0),
            )));
      }
      else if(e.code=="email-already-in-use"){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.orangeAccent,
            content: Text("Account Already exsists", style: TextStyle(fontSize: 18.0),
            )));
      }
    }
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(       //blueprint of the login page like <html> tag
      body: //he body property is set to a Container widget.
      Container(     //It wraps the entire content of the page.
        width: double.infinity,    //width is set to double.infinity to take the full width of the screen.
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Color.fromRGBO(147, 44, 44, 1.0), // Light grey
                  Color.fromRGBO(86, 22, 107, 1.0), // Light grey
                  Color.fromRGBO(243, 225, 225, 1.0), // Light grey
                ]
            )
        ),

        // decoration is set to a BoxDecoration with a gradient background using LinearGradient.

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //crossAxisAlignment is set to CrossAxisAlignment.center
          // to align children to the center of the cross axis (center-aligned in this case)
          children: <Widget>[
            const SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey, //this is form of the global key
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(duration: const Duration(milliseconds: 1000), child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 40),)),
                    const SizedBox(height: 10,),
                    FadeInUp(duration: const Duration(milliseconds: 1300), child: const Text("Welcome To the GreenEats", style: TextStyle(color: Colors.white, fontSize: 18),)),
                  ],
                ),
              ),
            ),

            //end of the words
            const SizedBox(height: 20),


            Expanded(

              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 60,),
                      FadeInUp(duration: const Duration(milliseconds: 1400), child: Container(
                        decoration: BoxDecoration(

                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10)
                            )]
                        ),
                        child: Column(

                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),

                              ),
                              child: TextFormField(
                                controller: namecontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Name';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Name",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(Icons.face_2),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),

                              ),
                              child: TextFormField(
                                controller: mailcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Email';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Email or Phone number",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(Icons.email),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                              ),
                              child: TextFormField(
                                controller: passwordcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter password';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(Icons.password),
                                    border: InputBorder.none
                                ),
                              ),
                            ),

                          ],
                        ),
                      )
                      ),
                      const SizedBox(height: 40,),

                      const SizedBox(height: 40,),
                      FadeInUp(duration: const Duration(milliseconds: 1600),


                              child: MaterialButton(
                                onPressed: () async {
                                  print("Sign up button pressed");
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      email = mailcontroller.text;
                                      name = namecontroller.text;
                                      password = passwordcontroller.text;
                                    });
                                    print("Form validated. Calling registration()");
                                    registration();
                                  }
                                },
                        height: 50,
                        // margin: EdgeInsets.symmetric(horizontal: 50),
                        color: const Color.fromRGBO(197, 29, 29, 0.6588235294117647),
                        shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),

                        ),
                        // decoration: BoxDecoration(
                        // ),
                        child: const Center(
                              child: Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),

                          ),
                      FadeInUp(duration: const Duration(milliseconds: 1700), child: GestureDetector(
                          onTap:(){
Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));

                          } ,
                          child: const Text("Already have an account? Login", style: TextStyle(color: Colors.grey),))),
                      const SizedBox(height: 50,),
                      FadeInUp(duration: const Duration(milliseconds: 1700), child: const Text("Continue with social media", style: TextStyle(color: Colors.grey),)),
                      const SizedBox(height: 30,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 1900),
                              child: GestureDetector(
                                onTap: () async {
                                  const url = 'https://www.facebook.com';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Image.asset(
                                  'images/fb.jpeg',
                                  width: 100,
                                  height: 100,
                                  // You can apply other properties like color, alignment, etc. if needed
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30,),
                          Expanded(
                            child: FadeInUp(duration: const Duration(milliseconds: 1900), child: MaterialButton(
                              onPressed: () {},
                              height: 50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),

                              ),
                              color: Colors.black,
                              child: const Center(
                                child: Text("Github", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
