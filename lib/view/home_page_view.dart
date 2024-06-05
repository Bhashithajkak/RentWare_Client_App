import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentware/components/item_card.dart';
import 'package:rentware/constants.dart';
import 'package:rentware/view/details_page_view.dart';
import 'package:rentware/view_model/home_page_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomePageViewModel(),
      child: Scaffold(
        body: Consumer<HomePageViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: viewModel.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search items...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                _categories(viewModel),
                _productGridView(viewModel),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _categories(HomePageViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Center(
        child: SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.categories.length,
            itemBuilder: (context, index) => _buildCategory(index, viewModel),
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(int index, HomePageViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.updateCategory(index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              viewModel.categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: viewModel.selectedIndex == index
                    ? kTextColor
                    : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4),
              height: 2,
              width: 30,
              color: viewModel.selectedIndex == index
                  ? Colors.black
                  : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  Widget _productGridView(HomePageViewModel viewModel) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: GridView.builder(
          itemCount: viewModel.searchedProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: kDefaultPaddin,
            crossAxisSpacing: kDefaultPaddin,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) => ItemCard(
            product: viewModel.searchedProducts[index],
            press: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreenView(
                  product: viewModel.searchedProducts[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
