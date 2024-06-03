import 'package:flutter/material.dart';
import 'package:rentware/models/firebase_service.dart';
import 'package:rentware/models/Product.dart';
import 'package:get_it/get_it.dart';

class FavoritesViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService =
      GetIt.instance.get<FirebaseService>();

  List<Product> _items = [];
  List<Product> _filteredItems = [];

  TextEditingController searchController = TextEditingController();

  List<Product> get items => _items;
  List<Product> get filteredItems => _filteredItems;

  FavoritesViewModel() {
    _loadItems();
    searchController.addListener(_searchItems);
  }

  Future<void> _loadItems() async {
    List<Product> items = await _firebaseService.getFavoriteItems().first;
    _items = items;
    _filteredItems = items;
    notifyListeners();
  }

  void _searchItems() {
    String query = searchController.text.toLowerCase();
    _filteredItems = _items
        .where((item) => item.title.toLowerCase().contains(query))
        .toList();
    notifyListeners();
  }

  void removeFavoriteItem(String productId) async {
    await _firebaseService.removeFavoriteItem(productId);
    _loadItems();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
