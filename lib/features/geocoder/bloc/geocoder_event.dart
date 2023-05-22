part of 'geocoder_bloc.dart';

abstract class GeocoderEvent extends Equatable {
  const GeocoderEvent();

  @override
  List<Object> get props => [];
}

class GeocoderRequested extends GeocoderEvent {
  final String latlng;

  const GeocoderRequested(this.latlng);

  @override
  List<Object> get props => [latlng];
}
