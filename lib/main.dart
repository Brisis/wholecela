import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/auth_bloc/authentication_bloc.dart';
import 'package:wholecela/business_logic/cart_bloc/cart_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/presentation/app/app_blocs.dart';
import 'package:wholecela/presentation/app/app_repositories.dart';
import 'package:wholecela/presentation/app/welcome_screen.dart';
import 'package:wholecela/presentation/screens/auth/login_screen.dart';
import 'package:wholecela/presentation/screens/home_screen.dart';
import 'package:wholecela/presentation/utils/loaders/app_loader_screen.dart';

Future<void> main() async {
  var config = const AppRepositories(
    appBlocs: AppBlocs(
      child: MainApp(),
    ),
  );

  runApp(config);
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get _navigator => _navigatorKey.currentState;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      title: 'Wholecela',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationStateIsInSplashPage) {
              _navigator!.pushAndRemoveUntil(
                AppLoaderScreen.route(),
                (route) => false,
              );
            }

            if (state is AuthenticationStateUserLoggedIn) {
              BlocProvider.of<UserBloc>(context).add(
                LoadUser(user: state.user),
              );

              BlocProvider.of<CartBloc>(context).add(
                LoadCarts(
                  userId: state.user.id,
                ),
              );

              _navigator!.pushAndRemoveUntil(
                HomeScreen.route(),
                (route) => false,
              );
            }

            if (state is AuthenticationStateUserLoggedOut) {
              _navigator!.pushAndRemoveUntil(
                LoginScreen.route(),
                (route) => false,
              );
            }

            if (state is AuthenticationStateUserNotLoggedIn) {
              _navigator!.pushAndRemoveUntil(
                WelcomeScreen.route(),
                (route) => false,
              );
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => AppLoaderScreen.route(),
    );
  }
}
