class Product {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  int bgColor;
  List<dynamic> availableSizes;
  String contactNumber;
  String category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.bgColor,
    required this.availableSizes,
    required this.contactNumber,
    required this.category,
  });

  // Factory constructor for creating a Product instance from a JSON-compatible map
  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
        id: json['id'].toString(),
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        imageUrl: json['imageUrl'] ?? '',
        bgColor: (json['backgroundColor']) ?? 4278255615,
        availableSizes: json['availableSizes'] ?? 0,
        contactNumber: json['contactNumber'].toString(),
        category: json['category'] ?? '');
  }
}
