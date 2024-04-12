import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:food_dilivery_application_1/pages/Admin.dart';
import 'package:food_dilivery_application_1/pages/home.dart';
import 'package:food_dilivery_application_1/pages/order.dart';
import 'package:food_dilivery_application_1/pages/profile.dart';
import 'package:food_dilivery_application_1/pages/wallet.dart';
import 'package:food_dilivery_application_1/services/cart_provider.dart';

class AdminBottomNav extends StatefulWidget {
  const AdminBottomNav({Key? key}) : super(key: key);

  @override
  State<AdminBottomNav> createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late Home homepage;
  late Profile profile;
  late CartPage cartpage;
  late Wallet wallet;

  @override
  void initState() {
    homepage = const Home();
    cartpage = CartPage();
    profile = const Profile();
    wallet = const Wallet();

    pages = [homepage, cartpage, wallet, profile, AdminPage()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.wallet_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
          Icon(
            Icons.add,
            color: Colors.white,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),

      ],
      child: MaterialApp(
        title: 'GreenEats',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AdminBottomNav(),
      ),
    );
  }
}
