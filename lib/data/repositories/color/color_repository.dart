import 'package:wholecela/data/models/color.dart';
import 'package:wholecela/data/repositories/color/color_provider.dart';

class ColorRepository {
  final ColorProvider colorProvider;
  const ColorRepository({required this.colorProvider});

  Future<List<ColorModel>> getColors() async {
    final response = await colorProvider.getColors();

    return (response as List<dynamic>)
        .map(
          (i) => ColorModel.fromJson(i),
        )
        .toList();
  }
}
