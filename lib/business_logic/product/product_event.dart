part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProduct extends ProductEvent {
  final String id;

  const LoadProduct({
    required this.id,
  });
}

class LoadProducts extends ProductEvent {}
