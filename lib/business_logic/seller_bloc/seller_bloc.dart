import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/data/models/seller.dart';
import 'package:wholecela/data/repositories/seller/seller_repository.dart';

part 'seller_event.dart';
part 'seller_state.dart';

class SellerBloc extends Bloc<SellerEvent, SellerState> {
  final SellerRepository sellerRepository;
  SellerBloc({
    required this.sellerRepository,
  }) : super(SellerStateInitial()) {
    on<LoadSellers>((event, emit) async {
      emit(SellerStateLoading());
      try {
        final sellers = await sellerRepository.getSellers();

        emit(LoadedSellers(sellers: sellers));
      } on AppException catch (e) {
        emit(
          SellerStateError(
            message: e,
          ),
        );
      }
    });

    on<LoadSeller>((event, emit) async {
      emit(SellerStateLoading());
      try {
        final seller = await sellerRepository.getSeller(
          id: event.id,
        );

        emit(LoadedSeller(seller: seller));
      } on AppException catch (e) {
        emit(
          SellerStateError(
            message: e,
          ),
        );
      }
    });
  }
}
