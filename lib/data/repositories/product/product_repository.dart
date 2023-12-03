import 'package:wholecela/data/models/product.dart';
import 'package:wholecela/data/repositories/product/product_provider.dart';

class ProductRepository {
  final ProductProvider productProvider;
  const ProductRepository({required this.productProvider});

  Future<List<Product>> getProducts() async {
    final response = await productProvider.getProducts();

    return (response as List<dynamic>)
        .map(
          (i) => Product.fromJson(i),
        )
        .toList();
  }

  Future<Product> getProduct({
    required String id,
  }) async {
    final response = await productProvider.getProduct(
      id: id,
    );

    return Product.fromJson(response);
  }
}
