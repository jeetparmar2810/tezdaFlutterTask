import 'package:FlutterTask/providers/auth_provider.dart';
import 'package:FlutterTask/screens/favorites_screen.dart';
import 'package:FlutterTask/screens/product_list_screen.dart';
import 'package:FlutterTask/screens/profile_screen.dart';
import 'package:FlutterTask/utils/app_routes.dart';
import 'package:FlutterTask/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String currentView = AppRoutes.productList;
  String currentTitle = AppStrings.productList;

  void switchView(String view, String title) {
    setState(() {
      currentView = view;
      currentTitle = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      drawer: _buildDrawer(authNotifier),
      appBar: AppBar(
        title: Text(currentTitle),
      ),
      body: _getCurrentView(),
    );
  }

  // Drawer menu
  Widget _buildDrawer(AuthNotifier authNotifier) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                AppStrings.appTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(AppStrings.productList),
            onTap: () {
              switchView(AppRoutes.productList, AppStrings.productList);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: Text(AppStrings.favorites),
            onTap: () {
              switchView(AppRoutes.favorites, AppStrings.favorites);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(AppStrings.profile),
            onTap: () {
              switchView(AppRoutes.profile, AppStrings.profile);
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(AppStrings.logout),
            onTap: () {
              Navigator.pop(context);
              authNotifier.logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  // Dynamically render the current view
  Widget _getCurrentView() {
    switch (currentView) {
      case AppRoutes.productList:
        return const ProductListScreen();
      case AppRoutes.favorites:
        return const FavoritesScreen();
      case AppRoutes.profile:
        return const ProfileScreen();
      default:
        return const ProductListScreen();
    }
  }
}