import 'package:flutter/material.dart';
import 'package:rentware/models/Product.dart';

class DetailsScreenViewModel extends ChangeNotifier {
  final Product product;
  bool _isFavorite = false;

  DetailsScreenViewModel({required this.product});

  bool get isFavorite => _isFavorite;

  void toggleFavoriteStatus() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}
