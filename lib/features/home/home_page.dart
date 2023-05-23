import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosres_finder/core/dependency_injector/dependency_injector.dart';
import 'package:hosres_finder/features/fav_places/display/bloc/fav_places_bloc.dart';
import 'package:hosres_finder/features/geocoder/bloc/geocoder_bloc.dart';

import '../geolocator/bloc/geolocator_bloc.dart';
import '../places/bloc/place_nearby_bloc.dart';
import '../places/domain/usecase/get_place_nearby_usecase.dart';
import 'widgets/home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GeolocatorBloc(
            repository: sl(),
          )..add(GeolocatorLoaded()),
        ),
        BlocProvider(
          create: (context) => GeocoderBloc(
            sl(),
          ),
        ),
        BlocProvider(
          create: (context) => PlaceNearbyBloc(
            sl(),
            sl(),
            sl(),
          ),
        ),
        BlocProvider(
          create: (context) => FavPlacesBloc(
            sl(),
            sl(),
            sl(),
          )..add(FavPlacesRequested()),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 14,
          ),
          children: [
            BlocListener<GeolocatorBloc, GeolocatorState>(
              listener: (_, state) {
                if (state.status == GeolocatorStatus.complete) {
                  double lat = state.position!.latitude;
                  double lng = state.position!.longitude;

                  context.read<GeocoderBloc>().add(
                        GeocoderRequested(
                          '$lat,$lng',
                        ),
                      );

                  context.read<PlaceNearbyBloc>().add(
                        PlaceNearbyRequested(
                          PlaceNearbyParams(
                            lat,
                            lng,
                            'hospital',
                            'rumah sakit',
                          ),
                        ),
                      );

                  context.read<PlaceNearbyBloc>().add(
                        PlaceNearbyRequested(
                          PlaceNearbyParams(
                            lat,
                            lng,
                            'restaurant',
                            'restoran',
                          ),
                        ),
                      );
                }
              },
              child: const HomeHeader(),
            ),
            const SizedBox(
              height: 14,
            ),
            const SearchBox(),
            const SizedBox(
              height: 7,
            ),
            const SectionTitle(
              title: 'Hospitals Nearby (5km)',
            ),
            const SizedBox(
              height: 7,
            ),
            BlocBuilder<PlaceNearbyBloc, PlaceNearbyState>(
              builder: (_, state) {
                if (state.hospitalStatus == Status.loading) {
                  return const PlacesLoading();
                } else if (state.hospitalStatus == Status.complete) {
                  return PlacesWidget(
                    places: state.hospitals,
                  );
                } else if (state.hospitalStatus == Status.failure) {
                  return const EmptyWidget();
                } else if (state.hospitalStatus == Status.initial) {
                  return const PlacesLoading();
                } else {
                  return const Center(
                    child: Text('Unknown Error'),
                  );
                }
              },
            ),
            const SizedBox(
              height: 7,
            ),
            const SectionTitle(
              title: 'Restaurants Nearby (5km)',
            ),
            const SizedBox(
              height: 7,
            ),
            BlocBuilder<PlaceNearbyBloc, PlaceNearbyState>(
              builder: (_, state) {
                if (state.restaurantStatus == Status.loading) {
                  return const PlacesLoading();
                } else if (state.restaurantStatus == Status.complete) {
                  return PlacesWidget(
                    places: state.restaurants,
                  );
                } else if (state.restaurantStatus == Status.failure) {
                  return const EmptyWidget();
                } else if (state.restaurantStatus == Status.initial) {
                  return const PlacesLoading();
                } else {
                  return const Center(
                    child: Text('Unknown Error'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
