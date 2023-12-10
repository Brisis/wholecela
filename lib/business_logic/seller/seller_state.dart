part of 'seller_bloc.dart';

abstract class SellerState extends Equatable {
  const SellerState();

  @override
  List<Object> get props => [];
}

final class SellerStateInitial extends SellerState {}

class SellerStateLoading extends SellerState {}

class LoadedSeller extends SellerState {
  final Seller seller;
  const LoadedSeller({
    required this.seller,
  });

  @override
  List<Object> get props => [seller];

  @override
  bool? get stringify => true;
}

class LoadedSellers extends SellerState {
  final List<Seller> sellers;
  const LoadedSellers({
    required this.sellers,
  });

  @override
  List<Object> get props => [sellers];

  @override
  bool? get stringify => true;
}

class SellerStateError extends SellerState {
  final AppException? message;
  const SellerStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}

extension GetSellers on SellerState {
  List<Seller>? get sellers {
    final cls = this;
    if (cls is LoadedSellers) {
      return cls.sellers;
    } else {
      return null;
    }
  }
}

extension GetSeller on SellerState {
  Seller? get seller {
    final cls = this;
    if (cls is LoadedSeller) {
      return cls.seller;
    } else {
      return null;
    }
  }
}
