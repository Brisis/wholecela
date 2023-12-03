import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/data/models/category.dart';
import 'package:wholecela/data/repositories/category/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  CategoryBloc({
    required this.categoryRepository,
  }) : super(CategoryStateInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoryStateLoading());
      try {
        final categories = await categoryRepository.getCategories();

        emit(LoadedCategories(categories: categories));
      } on AppException catch (e) {
        emit(
          CategoryStateError(
            message: e,
          ),
        );
      }
    });
  }
}
