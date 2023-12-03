import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/data/models/location.dart';
import 'package:wholecela/data/repositories/location/location_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;
  LocationBloc({
    required this.locationRepository,
  }) : super(LocationStateInitial()) {
    on<LoadLocations>((event, emit) async {
      emit(LocationStateLoading());
      try {
        final locations = await locationRepository.getLocations();

        emit(LoadedLocations(locations: locations));
      } on AppException catch (e) {
        emit(
          LocationStateError(
            message: e,
          ),
        );
      }
    });
  }
}
