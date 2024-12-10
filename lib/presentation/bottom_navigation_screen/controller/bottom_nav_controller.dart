import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class BottomNavBarController extends ChangeNotifier {
  final PageController pageController = PageController(initialPage: 0);  // PageController
  final NotchBottomBarController notchController = NotchBottomBarController(index: 0);  // NotchBottomBarController

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
