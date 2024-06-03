import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rentware/models/firebase_service.dart';
import 'package:rentware/models/Product.dart';

class HomePageViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService =
      GetIt.instance.get<FirebaseService>();
  List<Product> _filteredProducts = [];
  List<Product> _searchedProducts = [];
  List<String> categories = ["All", "Men", "Women", "Kids"];
  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();

  List<Product> get filteredProducts => _filteredProducts;
  List<Product> get searchedProducts => _searchedProducts;

  HomePageViewModel() {
    searchController.addListener(() {
      _searchProducts(searchController.text);
    });

    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    var productSnapshot = await _firebaseService.getProducts().first;
    List<Product> products = productSnapshot.docs
        .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    _filteredProducts = products;
    _searchProducts(searchController.text);
    notifyListeners();
  }

  void updateCategory(int index) {
    selectedIndex = index;
    _filterProducts();
    _searchProducts(searchController.text);
    notifyListeners();
  }

  void _filterProducts() {
    if (selectedIndex == 0) {
      _filteredProducts = _filteredProducts;
    } else {
      _filteredProducts = _filteredProducts
          .where((product) => product.category == categories[selectedIndex])
          .toList();
    }
    notifyListeners();
  }

  void _searchProducts(String query) {
    _searchedProducts = _filteredProducts
        .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
