// views/details_screen_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentware/components/custom_app_bar.dart';
import 'package:rentware/components/custom_bottom_nav_bar.dart';
import 'package:rentware/components/picture_title_with_image.dart';
import 'package:rentware/components/size_selecter.dart';
import 'package:rentware/constants.dart';
import 'package:rentware/models/Product.dart';
import 'package:rentware/view_model/detailed_page_view_model.dart';
import 'package:rentware/components/add_to_favourites.dart';

class DetailsScreenView extends StatelessWidget {
  final Product product;

  const DetailsScreenView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailsScreenViewModel(product: product),
      child: Consumer<DetailsScreenViewModel>(
        builder: (context, viewModel, child) {
          final Size size = MediaQuery.of(context).size;
          return Scaffold(
            backgroundColor: Color(viewModel.product.bgColor),
            appBar: CustomAppBar(
              iconColor: Colors.white,
              isDetailPage: true,
            ),
            bottomNavigationBar: CustomBottomNavBar(
              onTap: (index) {
                Navigator.pop(context);
              },
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: size.height * 0.3),
                            padding: EdgeInsets.only(
                              top: size.height * 0.12,
                              left: kDefaultPaddin,
                              right: kDefaultPaddin,
                            ),
                            constraints: BoxConstraints(
                              minHeight:
                                  constraints.maxHeight - size.height * 0.3,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizeSelector(viewModel: viewModel),
                                const SizedBox(height: kDefaultPaddin / 2),
                                _description(viewModel),
                                const SizedBox(height: kDefaultPaddin / 2),
                                AddToCart(product: viewModel.product),
                              ],
                            ),
                          ),
                          ProductTitleWithImage(viewModel: viewModel),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _description(DetailsScreenViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(
        viewModel.product.description,
        style: TextStyle(height: 1.5),
      ),
    );
  }
}
