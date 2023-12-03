part of 'seller_bloc.dart';

abstract class SellerState extends Equatable {
  const SellerState();

  @override
  List<Object> get props => [];
}

final class SellerStateInitial extends SellerState {}

class SellerStateLoading extends SellerState {}

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

// Extract user from UserState
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
