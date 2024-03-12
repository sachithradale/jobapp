import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/job_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NavigationController>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: controller.selectedIndex,
        onTap: (index) => controller.setSelectedIndex(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.blue,), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search,color: Colors.blue), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark,color: Colors.blue), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.blue), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.save_alt,color: Colors.blue), label: 'Saved Jobs')
        ],
      ),
      body: controller.screens[controller.selectedIndex],
    );
  }
}
