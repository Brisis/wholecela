import 'package:wholecela/data/models/location.dart';
import 'package:wholecela/data/repositories/location/location_provider.dart';

class LocationRepository {
  final LocationProvider locationProvider;
  const LocationRepository({required this.locationProvider});

  Future<List<Location>> getLocations() async {
    final response = await locationProvider.getLocations();

    return (response as List<dynamic>)
        .map(
          (i) => Location.fromJson(i),
        )
        .toList();
  }
}
