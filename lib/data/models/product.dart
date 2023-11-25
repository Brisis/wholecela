class Product {
  final String name;
  final String? imageUrl;
  final List<String> images;
  final double price;

  Product({
    required this.name,
    this.imageUrl,
    required this.images,
    required this.price,
  });
}
