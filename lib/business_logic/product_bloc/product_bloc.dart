import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/data/models/product.dart';
import 'package:wholecela/data/repositories/product/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc({
    required this.productRepository,
  }) : super(ProductStateInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductStateLoading());
      try {
        final products = await productRepository.getProducts();

        emit(LoadedProducts(products: products));
      } on AppException catch (e) {
        emit(
          ProductStateError(
            message: e,
          ),
        );
      }
    });

    on<LoadProduct>((event, emit) async {
      emit(ProductStateLoading());
      try {
        final product = await productRepository.getProduct(id: event.id);

        emit(LoadedProduct(product: product));
      } on AppException catch (e) {
        emit(
          ProductStateError(
            message: e,
          ),
        );
      }
    });
  }
}
