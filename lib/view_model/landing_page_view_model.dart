import 'package:flutter/material.dart';
import 'package:rentware/view/favourites_view.dart';
import 'package:rentware/view/home_page_view.dart';
import 'package:rentware/view/profile_view.dart';

class LandingPageViewModel extends ChangeNotifier {
  int _currentPage = 1;

  int get currentPage => _currentPage;

  final List<Widget> _pages = [
    FavouritsPage(),
    HomePage(),
    ProfilePage(),
  ];

  final List<String> _titles = const [
    'Favourite Items',
    'RentWare',
    'Profile',
  ];

  List<Widget> get pages => _pages;
  List<String> get titles => _titles;

  void navigateToPage(int index) {
    _currentPage = index;
    notifyListeners();
  }
}
