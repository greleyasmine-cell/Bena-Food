import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/material.dart';

class MainScaffoldAdmin extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final Function(int)? onTap;

  final String? titlePage;
  const MainScaffoldAdmin({super.key,
  required this.child,
     this.onTap,

    this.titlePage,
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: titlePage != null
      ?AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          titlePage!,
          style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      )
      :null,

      body: child,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: AppColors.primary,
          type: BottomNavigationBarType.fixed,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.add_box_rounded),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: ''),
          ]),
    );
  }
}
