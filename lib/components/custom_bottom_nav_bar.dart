import 'package:flutter/material.dart';
import 'package:rentware/constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 1,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          label: 'favourites',
          icon: Icon(
            Icons.favorite,
            color: kTextColor,
          ),
        ),
        BottomNavigationBarItem(
          label: 'home',
          icon: Icon(
            Icons.home,
            color: kTextColor,
          ),
        ),
        BottomNavigationBarItem(
          label: 'profile',
          icon: Icon(
            Icons.account_box,
            color: kTextColor,
          ),
        ),
      ],
    );
  }
}
