import 'package:wholecela/data/models/category.dart';
import 'package:wholecela/data/repositories/category/category_provider.dart';

class CategoryRepository {
  final CategoryProvider categoryProvider;
  const CategoryRepository({required this.categoryProvider});

  Future<List<Category>> getCategories() async {
    final response = await categoryProvider.getCategories();

    return (response as List<dynamic>)
        .map(
          (i) => Category.fromJson(i),
        )
        .toList();
  }
}
