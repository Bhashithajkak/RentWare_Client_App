import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentware/constants.dart';
import 'package:rentware/view_model/profile_view_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (context, viewModel, child) {
          final double deviceHeight = MediaQuery.of(context).size.height;
          final double deviceWidth = MediaQuery.of(context).size.width;

          return Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.05,
                vertical: deviceHeight * 0.02,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _profileImage(viewModel, deviceHeight),
                    _profileDetails(viewModel, deviceHeight),
                    _profileBody(deviceWidth),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _profileImage(ProfileViewModel viewModel, double deviceHeight) {
    return Container(
      margin: EdgeInsets.only(bottom: deviceHeight * 0.02),
      child: SizedBox(
        height: deviceHeight * 0.15,
        width: deviceHeight * 0.15,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(viewModel.profileImage),
            ),
            Positioned(
              right: -12,
              bottom: 0,
              child: SizedBox(
                height: 46,
                width: 46,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black)),
                  child: IconButton(
                    onPressed: () {
                      viewModel.changeProfilePicture();
                    },
                    icon: Icon(Icons.add_a_photo_outlined),
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _profileDetails(ProfileViewModel viewModel, double deviceHeight) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: deviceHeight * 0.02),
        child: Column(
          children: [
            Text(
              viewModel.name,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: deviceHeight * 0.005),
            Text(
              viewModel.email,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileBodyItem(
      {required double deviceWidth, required Icon icon, required String text}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: deviceWidth * 0.02),
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
      child: GestureDetector(
        onTap: () {
          // Define the action to be taken when the widget is tapped
        },
        child: Container(
          height: 60,
          padding: EdgeInsets.all(deviceWidth * 0.02),
          decoration: BoxDecoration(
            color: Color(0xFFD5D6D9),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon,
              SizedBox(
                width: deviceWidth * 0.02,
              ),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: kTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: kTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileBody(double deviceWidth) {
    return Container(
      child: Column(children: [
        _profileBodyItem(
          deviceWidth: deviceWidth,
          icon: Icon(Icons.account_circle_outlined),
          text: 'My Account',
        ),
        _profileBodyItem(
          deviceWidth: deviceWidth,
          icon: Icon(Icons.circle_notifications_outlined),
          text: 'Notifications',
        ),
        _profileBodyItem(
          deviceWidth: deviceWidth,
          icon: Icon(Icons.settings),
          text: 'Settings',
        ),
        _profileBodyItem(
          deviceWidth: deviceWidth,
          icon: Icon(Icons.help_sharp),
          text: 'Help Center',
        ),
      ]),
    );
  }
}
