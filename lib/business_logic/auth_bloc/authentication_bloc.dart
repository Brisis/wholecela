import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/core/config/storage.dart';
import 'package:wholecela/data/models/auth_error.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/data/repositories/authentication/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({
    required this.authenticationRepository,
  }) : super(AuthenticationStateUserNotLoggedIn()) {
    Future<void> waitThrow(String message) async {
      await Future.delayed(const Duration(seconds: 5));
      throw Exception(message);
    }

    on<AuthenticationEventLogoutUser>((event, emit) {
      deleteAuthToken();
      //UserData.deleteSavedUser();
      emit(const AuthenticationStateUserLoggedOut());
    });

    //initialize app
    on<AuthenticationEventInitialize>((event, emit) async {
      emit(AuthenticationStateIsInSplashPage());

      try {
        final token = await getAuthToken();

        if (token != null) {
          final loggedUser = await authenticationRepository
              .authenticate(
                token: token,
              )
              .timeout(const Duration(seconds: 10));

          emit(
            AuthenticationStateUserLoggedIn(
              user: loggedUser,
            ),
          );
        } else {
          emit(AuthenticationStateUserNotLoggedIn());
        }
      } on TimeoutException {
        deleteAuthToken();
        emit(
          AuthenticationStateUserLoggedOut(
            authError: AuthError.from(const AppException()),
          ),
        );
      } on AppException catch (e) {
        deleteAuthToken();
        emit(
          AuthenticationStateUserLoggedOut(
            authError: AuthError.from(e),
          ),
        );
      }
    });

    on<AuthenticationEventRegisterUser>((event, emit) async {
      emit(
        AuthenticationStateLoading(),
      );

      try {
        final authToken = await authenticationRepository.register(
          name: event.name,
          email: event.email,
          password: event.password,
        );

        saveAuthToken(authToken);

        final loggedUser = await authenticationRepository.authenticate(
          token: authToken,
        );
        // await UserData.saveUser(authResponse.user!);
        emit(
          AuthenticationStateUserLoggedIn(
            user: loggedUser,
          ),
        );
      } on AppException catch (e) {
        emit(
          AuthenticationStateError(
            authError: AuthError.from(e),
          ),
        );
      }
    });

    on<AuthenticationEventLoginUser>((event, emit) async {
      emit(
        AuthenticationStateLoading(),
      );

      final email = event.email;
      final password = event.password;

      try {
        final authToken = await authenticationRepository.login(
          email: email,
          password: password,
        );

        saveAuthToken(authToken);

        final loggedUser = await authenticationRepository.authenticate(
          token: authToken,
        );
        // await UserData.saveUser(authResponse.user!);
        emit(
          AuthenticationStateUserLoggedIn(
            user: loggedUser,
          ),
        );
      } on AppException catch (e) {
        emit(
          AuthenticationStateError(
            authError: AuthError.from(e),
          ),
        );
      }
    });
  }
}
