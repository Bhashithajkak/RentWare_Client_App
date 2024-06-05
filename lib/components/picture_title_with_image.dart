import 'package:flutter/material.dart';
import 'package:rentware/constants.dart';
import 'package:rentware/view_model/detailed_page_view_model.dart';

class ProductTitleWithImage extends StatelessWidget {
  final DetailsScreenViewModel viewModel;

  const ProductTitleWithImage({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            viewModel.product.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: kDefaultPaddin / 8),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "\$${viewModel.product.price}",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPaddin),
              Expanded(
                child: Hero(
                  tag: "${viewModel.product.id}",
                  child: Image.network(
                    viewModel.product.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
