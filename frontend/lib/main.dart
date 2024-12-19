import 'package:flutter/material.dart';
import 'package:frontend/screens/charts_screen.dart';
import 'package:frontend/screens/my_listings_screen.dart';
import 'package:frontend/screens/product_search_screen.dart';
import 'package:frontend/screens/sell_item_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/chat_list_screen.dart';

void main() {
  runApp(const SecondHandMarketApp());
}

class SecondHandMarketApp extends StatelessWidget {
  const SecondHandMarketApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecondHand Market',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/product-detail': (context) => const ProductDetailScreen(),
        '/sell-item': (context) => const SellItemScreen(),
        '/search': (context) => const ProductSearchScreen(),
        '/cart': (context) => const CartScreen(),
        '/my-listings': (context) => const MyListingsScreen(),
        '/analytics': (context) => const ChartsScreen(),
        '/messages': (context) => ChatListScreen(),
      },
    );
  }
}
