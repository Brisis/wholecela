part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryStateInitial extends CategoryState {}

class CategoryStateLoading extends CategoryState {}

class LoadedCategories extends CategoryState {
  final List<Category> categories;
  const LoadedCategories({
    required this.categories,
  });

  @override
  List<Object> get props => [categories];

  @override
  bool? get stringify => true;
}

class CategoryStateError extends CategoryState {
  final AppException? message;
  const CategoryStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}

// Extract user from UserState
extension GetCategories on CategoryState {
  List<Category>? get categories {
    final cls = this;
    if (cls is LoadedCategories) {
      return cls.categories;
    } else {
      return null;
    }
  }
}
