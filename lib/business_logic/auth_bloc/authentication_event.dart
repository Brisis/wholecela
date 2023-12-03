part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationEventInitialize extends AuthenticationEvent {}

class AuthenticationEventRegisterUser implements AuthenticationEvent {
  final String name;
  final String email;
  final String password;

  const AuthenticationEventRegisterUser({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];

  @override
  bool? get stringify => true;
}

class AuthenticationEventLoginUser extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationEventLoginUser({
    required this.email,
    required this.password,
  });
}

class AuthenticationEventLogoutUser extends AuthenticationEvent {}
