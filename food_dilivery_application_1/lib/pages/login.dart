import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:food_dilivery_application_1/pages/bottomnav.dart';
import 'package:food_dilivery_application_1/pages/forgotpassword.dart';
import 'package:food_dilivery_application_1/pages/signup.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email="", password="";

  final _formkey= GlobalKey<FormState>();

  TextEditingController useremailcontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNav()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      }else if(e.code=='wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
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
        decoration: BoxDecoration(
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
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeInUp(duration: Duration(milliseconds: 1300), child: Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ],
              ),
            ),

            //end of the words
            SizedBox(height: 20),


            Expanded(

              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60,),
                      FadeInUp(duration: Duration(milliseconds: 1400), child: Container(
                        decoration: BoxDecoration(

                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10)
                            )]
                        ),
                        child: Form(
                          key:_formkey ,
                          child: Column(

                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200)),

                                ),
                                child: TextFormField(
                                  controller: useremailcontroller,
                                  validator: (value){
                                    if(value==null|| value.isEmpty){
                                      return 'Please Enter Email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Email or Phone number",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      prefixIcon: Icon(Icons.email),
                                      border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextFormField(
                                  controller: userpasswordcontroller,
                                  validator: (value){
                                    if(value==null|| value.isEmpty){
                                      return 'Please Enter Password';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      prefixIcon: Icon(Icons.password),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      ),
                      SizedBox(height: 40,),
                      FadeInUp(duration: Duration(milliseconds: 1500),

                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPass()));
                            },
                            child: Text("Forgot Password?", style: TextStyle(color: Colors.grey),

                            ),
                          )
                      ),
                      SizedBox(height: 40,),
                      FadeInUp(duration: Duration(milliseconds: 1600),


                            child: MaterialButton(
                        onPressed: () async{
                          print("Login is clicked");
                          if(_formkey.currentState!.validate()){
                            setState(() {
                              email = useremailcontroller.text;
                              password = userpasswordcontroller.text;

                            });
                          }
                             userLogin();  //calling to userLogin.
                        },
                        height: 50,
                        // margin: EdgeInsets.symmetric(horizontal: 50),
                        color: Color.fromRGBO(197, 29, 29, 0.6588235294117647),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),

                        ),
                        // decoration: BoxDecoration(
                        // ),
                        child: Center(
                            child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                          ),
                      FadeInUp(duration: Duration(milliseconds: 1500), child: GestureDetector(
                          onTap:(){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                          } ,

                          child: Text("Don't have an account?Sign up", style: TextStyle(color: Colors.grey),))),
                      SizedBox(height: 50,),
                      FadeInUp(duration: Duration(milliseconds: 1700), child: Text("Continue with social media", style: TextStyle(color: Colors.grey),)),
                      SizedBox(height: 30,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FadeInUp(
                              duration: Duration(milliseconds: 1900),
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
                          SizedBox(width: 30,),
                          Expanded(
                            child: FadeInUp(duration: Duration(milliseconds: 1900), child: MaterialButton(
                              onPressed: () {},
                              height: 50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),

                              ),
                              color: Colors.black,
                              child: Center(
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
