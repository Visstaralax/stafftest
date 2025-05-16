class ShopItem{
  final String id;
  final String name;
  final String description;
  final int stock;
  final String imagePath;
  final double price;
  bool isFavorite = false;

  ShopItem({required this.id,
    required this.name,
    required this.description,
    required this.stock,
    required this.imagePath,
    required this.price
  });

  factory ShopItem.decodeJson(Map<String, dynamic> json) {
    return ShopItem(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        stock: json['stock'] as int,
        imagePath: json['image'],
        price: json['price'] as double
    );
  }
}