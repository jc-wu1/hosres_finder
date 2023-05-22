part of 'geocoder_bloc.dart';

abstract class GeocoderState extends Equatable {
  const GeocoderState();

  @override
  List<Object> get props => [];
}

class GeocoderInitial extends GeocoderState {}

class GeocoderLoadInProgress extends GeocoderState {}

class GeocoderLoadComplete extends GeocoderState {
  final GeocoderModel geocoder;

  const GeocoderLoadComplete(this.geocoder);

  @override
  List<Object> get props => [geocoder];
}

class GeocoderLoadFailure extends GeocoderState {}
