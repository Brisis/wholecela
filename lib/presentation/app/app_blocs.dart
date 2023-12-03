import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/auth_bloc/authentication_bloc.dart';
import 'package:wholecela/business_logic/category_bloc/category_bloc.dart';
import 'package:wholecela/business_logic/color_bloc/color_bloc.dart';
import 'package:wholecela/business_logic/location_bloc/location_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/data/repositories/authentication/authentication_repository.dart';
import 'package:wholecela/data/repositories/category/category_repository.dart';
import 'package:wholecela/data/repositories/color/color_repository.dart';
import 'package:wholecela/data/repositories/location/location_repository.dart';
import 'package:wholecela/data/repositories/user/user_repository.dart';

class AppBlocs extends StatelessWidget {
  final Widget child;
  const AppBlocs({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          )..add(AuthenticationEventInitialize()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => UserBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => LocationBloc(
            locationRepository:
                RepositoryProvider.of<LocationRepository>(context),
          )..add(LoadLocations()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            categoryRepository:
                RepositoryProvider.of<CategoryRepository>(context),
          )..add(LoadCategories()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => ColorBloc(
            colorRepository: RepositoryProvider.of<ColorRepository>(context),
          )..add(LoadColors()),
          lazy: false,
        ),
      ],
      child: child,
    );
  }
}
