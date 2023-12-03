
import 'package:wholecela/data/models/seller.dart';
import 'package:wholecela/data/repositories/seller/seller_provider.dart';

class SellerRepository {
  final SellerProvider sellerProvider;
  const SellerRepository({required this.sellerProvider});

  Future<List<Seller>> getSellers() async {
    final response = await sellerProvider.getSellers();

    return (response as List<dynamic>)
        .map(
          (i) => Seller.fromJson(i),
        )
        .toList();
  }
}
