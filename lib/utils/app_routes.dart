import 'package:FlutterTask/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/product_detail_screen.dart';


class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const productList = '/product-list';
  static const productDetail = '/product-detail';
  static const profile = '/profile';
  static const home = '/home';
  static const favorites = '/favorites';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    home: (context) => const HomeScreen(),
  };

  /// Handle named route with dynamic arguments for product detail
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case productDetail:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (context) => ProductDetailScreen(product: product),
        );
      default:
        return MaterialPageRoute(builder: (context) => LoginScreen());
    }
  }
}
