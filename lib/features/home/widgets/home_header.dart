import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hosres_finder/features/fav_places/display/bloc/fav_places_bloc.dart';
import 'package:hosres_finder/features/fav_places/display/fav_places_page.dart';
import 'package:hosres_finder/features/geocoder/bloc/geocoder_bloc.dart';
import 'package:hosres_finder/features/geolocator/bloc/geolocator_bloc.dart';
import 'package:hosres_finder/features/map/map_page.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: const [
                    Text(
                      'Your location ',
                      style: TextStyle(fontSize: 13),
                    ),
                    Icon(
                      Icons.arrow_downward,
                      size: 13,
                    )
                  ],
                ),
              ),
              BlocBuilder<GeocoderBloc, GeocoderState>(
                builder: (context, state) {
                  if (state is GeocoderLoadInProgress) {
                    return Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(25),
                      ),
                    );
                  } else if (state is GeocoderLoadComplete) {
                    return TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        var state = context.read<GeolocatorBloc>().state;
                        double lat = state.position!.latitude;
                        double long = state.position!.longitude;

                        Navigator.of(context)
                            .push(
                          MaterialPageRoute<LatLng>(
                            builder: (context) => MapPage(
                              position: LatLng(lat, long),
                            ),
                          ),
                        )
                            .then((value) {
                          if (value != null) {
                            context.read<GeolocatorBloc>().add(
                                  GeolocatorUpdated(
                                    Position(
                                      longitude: value.longitude,
                                      latitude: value.latitude,
                                      timestamp: DateTime.now(),
                                      accuracy: 0,
                                      altitude: 0,
                                      heading: 0,
                                      speed: 0,
                                      speedAccuracy: 0,
                                    ),
                                  ),
                                );
                          }
                        });
                      },
                      child: Text(
                        state.geocoder.results!.first.formattedAddress!,
                      ),
                    );
                  } else {
                    return Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(25),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => const FavPlacesPage(),
              ),
            )
                .then((value) {
              context.read<FavPlacesBloc>().add(FavPlacesRequested());
            });
          },
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
