import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/data/repositories/authentication/authentication_provider.dart';
import 'package:wholecela/data/repositories/authentication/authentication_repository.dart';
import 'package:wholecela/data/repositories/category/category_provider.dart';
import 'package:wholecela/data/repositories/category/category_repository.dart';
import 'package:wholecela/data/repositories/color/color_provider.dart';
import 'package:wholecela/data/repositories/color/color_repository.dart';
import 'package:wholecela/data/repositories/location/location_provider.dart';
import 'package:wholecela/data/repositories/location/location_repository.dart';
import 'package:wholecela/data/repositories/product/product_provider.dart';
import 'package:wholecela/data/repositories/product/product_repository.dart';
import 'package:wholecela/data/repositories/seller/seller_provider.dart';
import 'package:wholecela/data/repositories/seller/seller_repository.dart';
import 'package:wholecela/data/repositories/user/user_provider.dart';
import 'package:wholecela/data/repositories/user/user_repository.dart';

class AppRepositories extends StatelessWidget {
  final Widget appBlocs;
  const AppRepositories({
    Key? key,
    required this.appBlocs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthenticationRepository(
            authenticationProvider: AuthenticationProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(
            userProvider: UserProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => LocationRepository(
            locationProvider: LocationProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => CategoryRepository(
            categoryProvider: CategoryProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => ColorRepository(
            colorProvider: ColorProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SellerRepository(
            sellerProvider: SellerProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => ProductRepository(
            productProvider: ProductProvider(),
          ),
        ),
      ],
      child: appBlocs,
    );
  }
}
