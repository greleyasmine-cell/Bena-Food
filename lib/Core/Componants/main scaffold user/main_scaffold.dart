import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final Function(int) onTap;
  const MainScaffold({super.key,
  required this.child,
  this.currentIndex = 0,
  required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
          selectedItemColor: AppColors.primary,
          type: BottomNavigationBarType.fixed,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.inventory_2),label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
          ]),
    );
  }
}
