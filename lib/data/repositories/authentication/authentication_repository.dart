import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/data/repositories/authentication/authentication_provider.dart';

class AuthenticationRepository {
  final AuthenticationProvider authenticationProvider;
  const AuthenticationRepository({required this.authenticationProvider});

  Future<String> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await authenticationProvider.register(
      name: name,
      email: email,
      password: password,
    );

    return response["access_token"];
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await authenticationProvider.login(
      email: email,
      password: password,
    );

    return response["access_token"];
  }

  Future<User> authenticate({
    required String token,
  }) async {
    final response = await authenticationProvider.authenticate(
      token: token,
    );

    return User.fromJson(response);
  }
}
