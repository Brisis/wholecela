part of 'color_bloc.dart';

abstract class ColorState extends Equatable {
  const ColorState();

  @override
  List<Object> get props => [];
}

final class ColorStateInitial extends ColorState {}

class ColorStateLoading extends ColorState {}

class LoadedColors extends ColorState {
  final List<ColorModel> colors;
  const LoadedColors({
    required this.colors,
  });

  @override
  List<Object> get props => [colors];

  @override
  bool? get stringify => true;
}

class ColorStateError extends ColorState {
  final AppException? message;
  const ColorStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}

// Extract user from UserState
extension GetColors on ColorState {
  List<ColorModel>? get colors {
    final cls = this;
    if (cls is LoadedColors) {
      return cls.colors;
    } else {
      return null;
    }
  }
}
