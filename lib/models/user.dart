class User {
  String name;
  String email;
  String image;
  List<String> favoriteProducts;

  User({
    required this.name,
    required this.email,
    this.image = '',
    List<String>? favoriteProducts,
  }) : favoriteProducts = favoriteProducts ?? [];

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      name: json['name'].toString(),
      email: json['email'].toString(),
      image: json['image'] ?? '',
      favoriteProducts: json['favoriteProducts'] ?? [],
    );
  }
}
