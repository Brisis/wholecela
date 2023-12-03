part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductStateInitial extends ProductState {}

class ProductStateLoading extends ProductState {}

class LoadedProduct extends ProductState {
  final Product product;
  const LoadedProduct({
    required this.product,
  });

  @override
  List<Object> get props => [product];

  @override
  bool? get stringify => true;
}

class LoadedProducts extends ProductState {
  final List<Product> products;
  const LoadedProducts({
    required this.products,
  });

  @override
  List<Object> get props => [products];

  @override
  bool? get stringify => true;
}

class ProductStateError extends ProductState {
  final AppException? message;
  const ProductStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}

// Extract user from UserState
extension GetProducts on ProductState {
  List<Product>? get products {
    final cls = this;
    if (cls is LoadedProducts) {
      return cls.products;
    } else {
      return null;
    }
  }
}

extension GetProduct on ProductState {
  Product? get product {
    final cls = this;
    if (cls is LoadedProduct) {
      return cls.product;
    } else {
      return null;
    }
  }
}
