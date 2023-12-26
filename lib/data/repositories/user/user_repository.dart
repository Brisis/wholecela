import 'dart:io';

import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/data/repositories/user/user_provider.dart';

class UserRepository {
  final UserProvider userProvider;
  const UserRepository({required this.userProvider});

  Future<User> updateUserDetails({
    required String token,
    required User user,
  }) async {
    final response = await userProvider.updateUserDetails(
      token: token,
      user: user,
    );

    return User.fromJson(response);
  }

  Future<User> updateUserImage({
    required String token,
    required String userId,
    required File image,
  }) async {
    final response = await userProvider.updateUserImage(
      token: token,
      userId: userId,
      image: image,
    );

    return User.fromJson(response);
  }
}
