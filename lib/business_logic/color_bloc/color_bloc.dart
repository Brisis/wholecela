import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/data/models/color.dart';
import 'package:wholecela/data/repositories/color/color_repository.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  final ColorRepository colorRepository;
  ColorBloc({
    required this.colorRepository,
  }) : super(ColorStateInitial()) {
    on<LoadColors>((event, emit) async {
      emit(ColorStateLoading());
      try {
        final colors = await colorRepository.getColors();

        emit(LoadedColors(colors: colors));
      } on AppException catch (e) {
        emit(
          ColorStateError(
            message: e,
          ),
        );
      }
    });
  }
}
