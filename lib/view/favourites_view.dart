import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentware/models/Product.dart';
import 'package:rentware/view/details_page_view.dart';
import 'package:rentware/view_model/favourites_view_model.dart';

class FavouritsPage extends StatelessWidget {
  const FavouritsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_) => FavoritesViewModel(),
      child: Scaffold(
        body: Consumer<FavoritesViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                Expanded(child: _productListView(viewModel, deviceWidth)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _productListView(FavoritesViewModel viewModel, double deviceWidth) {
    return ListView.builder(
      itemCount: viewModel.filteredItems.length,
      itemBuilder: (context, index) {
        Product product = viewModel.filteredItems[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreenView(
                product: product,
              ),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: deviceWidth * 0.01, horizontal: deviceWidth * 0.01),
            padding: const EdgeInsets.all(10.0),
            height: deviceWidth * 0.4,
            decoration: BoxDecoration(
              color: Color(product.bgColor),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.white, width: 2.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    product.imageUrl,
                    width: deviceWidth * 0.3,
                    height: deviceWidth * 0.3,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        "\$${product.price.toString()}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    viewModel.removeFavoriteItem(product.id);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
