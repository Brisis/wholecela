part of 'store_product_bloc.dart';

abstract class StoreProductEvent extends Equatable {
  const StoreProductEvent();

  @override
  List<Object> get props => [];
}

class LoadStoreProduct extends StoreProductEvent {
  final String id;

  const LoadStoreProduct({
    required this.id,
  });
}

class AddStoreProduct extends StoreProductEvent {
  final String title;
  final String categoryId;
  final String ownerId;
  final double price;
  final int quantity;

  const AddStoreProduct({
    required this.title,
    required this.categoryId,
    required this.ownerId,
    required this.price,
    required this.quantity,
  });
}

class StoreProductUpdateDetails implements StoreProductEvent {
  final Product product;

  const StoreProductUpdateDetails({
    required this.product,
  });

  @override
  List<Object> get props => [product];

  @override
  bool? get stringify => true;
}

class StoreProductUpdateImage implements StoreProductEvent {
  final Product product;

  const StoreProductUpdateImage({
    required this.product,
  });

  @override
  List<Object> get props => [product];

  @override
  bool? get stringify => true;
}

class StoreProductUpdateColors implements StoreProductEvent {
  final String productId;
  final List<String> colors;

  const StoreProductUpdateColors({
    required this.productId,
    required this.colors,
  });

  @override
  List<Object> get props => [productId, colors];

  @override
  bool? get stringify => true;
}

class DeleteProduct extends StoreProductEvent {
  final String id;

  const DeleteProduct({
    required this.id,
  });
}
