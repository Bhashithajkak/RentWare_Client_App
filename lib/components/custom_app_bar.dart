import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rentware/constants.dart';
import 'package:rentware/models/firebase_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color iconColor;
  final bool isDetailPage;
  final String title;
  final FirebaseService _firebaseService = GetIt.instance<FirebaseService>();

  CustomAppBar({
    Key? key,
    required this.iconColor,
    this.isDetailPage = false,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: iconColor,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.logout),
          color: iconColor,
          onPressed: () async {
            await _firebaseService.logout();
            Navigator.popAndPushNamed(context, 'login');
          },
        ),
        if (isDetailPage) const SizedBox(width: kDefaultPaddin / 2),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
