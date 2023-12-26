import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/core/config/storage.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/data/repositories/user/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({
    required this.userRepository,
  }) : super(UserStateLoading()) {
    on<LoadUser>((event, emit) async {
      emit(LoadedUser(user: event.user));
    });

    on<UserEventUpdateDetails>((event, emit) async {
      emit(
        UserStateLoading(),
      );

      try {
        final token = await getAuthToken();

        final userResponse = await userRepository.updateUserImage(
          token: token!,
          userId: event.user.id,
          image: File(event.user.imageUrl!),
        );

        emit(LoadedUser(user: userResponse));
      } on AppException catch (e) {
        emit(
          UserStateError(
            message: e,
          ),
        );
      }
    });
  }
}
