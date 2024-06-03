import 'package:flutter/material.dart';
import 'package:rentware/view_model/detailed_page_view_model.dart';

class SizeSelector extends StatelessWidget {
  final DetailsScreenViewModel viewModel;

  const SizeSelector({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> sizes = ["S", "M", "L", "XL", "XXL"];

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Sizes"),
              Row(
                children: sizes.map((size) {
                  bool isSelected =
                      viewModel.product.availableSizes.contains(size);
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizeDot(
                      size: size,
                      isSelected: isSelected,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SizeDot extends StatelessWidget {
  final String size;
  final bool isSelected;

  const SizeDot({Key? key, required this.size, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
