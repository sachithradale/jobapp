import 'package:flutter/material.dart';

import '../views/screens/JobView/filter_view.dart';
import '../views/screens/JobView/job_detailed_view.dart';
import '../views/screens/JobView/home_screen.dart';
import '../views/screens/savedJobs.dart';

class NavigationController extends ChangeNotifier {
  int _selectedIndex = 0;
  List<Widget> _screens = [HomeScreen(), FilterPage(), JobDetailView(), Container(color: Colors.orange),SavedJobs()];

  int get selectedIndex => _selectedIndex;

  List<Widget> get screens => _screens;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
