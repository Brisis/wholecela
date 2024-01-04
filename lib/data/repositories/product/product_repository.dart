import 'dart:io';

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

  Future<Product> addProduct({
    required String title,
    required String categoryId,
    required String ownerId,
    required double price,
    required int quantity,
  }) async {
    final response = await productProvider.addProduct(
      title: title,
      categoryId: categoryId,
      ownerId: ownerId,
      price: price,
      quantity: quantity,
    );

    return Product.fromJson(response);
  }

  Future<Product> updateProductColors({
    required String productId,
    required List<String> colors,
  }) async {
    final response = await productProvider.updateProductColors(
      productId: productId,
      colors: colors,
    );

    return Product.fromJson(response);
  }

  Future<Product> updateProductDetails({
    required Product product,
  }) async {
    final response = await productProvider.updateUserDetails(
      product: product,
    );

    return Product.fromJson(response);
  }

  Future<Product> updateProductImage({
    required String productId,
    required File image,
  }) async {
    final response = await productProvider.updateProductImage(
      productId: productId,
      image: image,
    );

    return Product.fromJson(response);
  }
}
