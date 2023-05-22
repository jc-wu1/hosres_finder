import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosres_finder/features/geocoder/data/model/geocoder_model.dart';
import 'package:hosres_finder/features/geocoder/domain/usecase/get_location_name_usecase.dart';

part 'geocoder_event.dart';
part 'geocoder_state.dart';

class GeocoderBloc extends Bloc<GeocoderEvent, GeocoderState> {
  GeocoderBloc(this.getLocationName) : super(GeocoderInitial()) {
    on<GeocoderRequested>(_onGeocoderRequested);
  }

  final GetLocationNameUsecase getLocationName;

  Future<void> _onGeocoderRequested(
    GeocoderRequested event,
    Emitter<GeocoderState> emit,
  ) async {
    emit(GeocoderLoadInProgress());
    try {
      final result = await getLocationName(event.latlng);
      result.fold(
        (l) => emit(GeocoderLoadFailure()),
        (r) => emit(GeocoderLoadComplete(r)),
      );
    } catch (e) {
      return emit(GeocoderLoadFailure());
    }
  }
}
