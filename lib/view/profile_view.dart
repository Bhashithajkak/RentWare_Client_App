import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentware/view_model/profile_view_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (context, viewModel, child) {
          final Size size = MediaQuery.of(context).size;
          final double deviceHeight = size.height;
          final double deviceWidth = size.width;

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
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: deviceHeight * 0.02),
        height: deviceHeight * 0.15,
        width: deviceHeight * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(viewModel.profileImage),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
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
            SizedBox(height: deviceHeight * 0.01),
            Text(
              viewModel.email,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
