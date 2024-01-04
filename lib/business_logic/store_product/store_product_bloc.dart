import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/data/models/product.dart';
import 'package:wholecela/data/repositories/product/product_repository.dart';

part 'store_product_event.dart';
part 'store_product_state.dart';

class StoreProductBloc extends Bloc<StoreProductEvent, StoreProductState> {
  final ProductRepository productRepository;
  StoreProductBloc({
    required this.productRepository,
  }) : super(StoreProductStateInitial()) {
    on<AddStoreProduct>((event, emit) async {
      emit(StoreProductStateLoading());
      try {
        await productRepository.addProduct(
          title: event.title,
          categoryId: event.categoryId,
          ownerId: event.ownerId,
          price: event.price,
          quantity: event.quantity,
        );

        emit(StoreProductStateAdded());

        emit(StoreProductStateInitial());
      } on AppException catch (e) {
        emit(
          StoreProductStateError(
            message: e,
          ),
        );
      }
    });

    on<LoadStoreProduct>((event, emit) async {
      emit(StoreProductStateLoading());
      try {
        final product = await productRepository.getProduct(id: event.id);

        emit(LoadedStoreProduct(product: product));
      } on AppException catch (e) {
        emit(
          StoreProductStateError(
            message: e,
          ),
        );
      }
    });

    on<StoreProductUpdateDetails>((event, emit) async {
      emit(
        StoreProductStateLoading(),
      );

      try {
        final productResponse = await productRepository.updateProductDetails(
          product: event.product,
        );

        emit(LoadedStoreProduct(product: productResponse));
      } on AppException catch (e) {
        emit(
          StoreProductStateError(
            message: e,
          ),
        );
      }
    });

    on<StoreProductUpdateImage>((event, emit) async {
      emit(
        StoreProductStateLoading(),
      );

      try {
        final productResponse = await productRepository.updateProductImage(
          productId: event.product.id,
          image: File(event.product.imageUrl!),
        );

        emit(LoadedStoreProduct(product: productResponse));
      } on AppException catch (e) {
        emit(
          StoreProductStateError(
            message: e,
          ),
        );
      }
    });

    on<StoreProductUpdateColors>((event, emit) async {
      emit(
        StoreProductStateLoading(),
      );

      try {
        final productResponse = await productRepository.updateProductColors(
          productId: event.productId,
          colors: event.colors,
        );

        emit(LoadedStoreProduct(product: productResponse));
      } on AppException catch (e) {
        emit(
          StoreProductStateError(
            message: e,
          ),
        );
      }
    });
  }
}
