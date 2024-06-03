import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentware/components/custom_app_bar.dart';
import 'package:rentware/components/custom_bottom_nav_bar.dart';
import 'package:rentware/view_model/landing_page_view_model.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LandingPageViewModel(),
      child: Consumer<LandingPageViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(
              iconColor: Colors.black,
              title: viewModel.titles[viewModel.currentPage],
            ),
            bottomNavigationBar: CustomBottomNavBar(
              onTap: (index) {
                viewModel.navigateToPage(index);
              },
            ),
            body: viewModel.pages[viewModel.currentPage],
          );
        },
      ),
    );
  }
}
