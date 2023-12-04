part of 'seller_bloc.dart';

abstract class SellerEvent extends Equatable {
  const SellerEvent();

  @override
  List<Object> get props => [];
}

class LoadSeller extends SellerEvent {
  final String id;

  const LoadSeller({
    required this.id,
  });
}

class LoadSellers extends SellerEvent {}
