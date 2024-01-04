part of 'store_product_bloc.dart';

abstract class StoreProductState extends Equatable {
  const StoreProductState();

  @override
  List<Object> get props => [];
}

final class StoreProductStateInitial extends StoreProductState {}

class StoreProductStateLoading extends StoreProductState {}

class StoreProductStateAdded extends StoreProductState {}

class LoadedStoreProduct extends StoreProductState {
  final Product product;
  const LoadedStoreProduct({
    required this.product,
  });

  @override
  List<Object> get props => [product];

  @override
  bool? get stringify => true;
}

class StoreProductStateError extends StoreProductState {
  final AppException? message;
  const StoreProductStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}
