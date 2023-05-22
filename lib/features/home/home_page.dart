import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosres_finder/core/dependency_injector/dependency_injector.dart';
import 'package:hosres_finder/features/geocoder/bloc/geocoder_bloc.dart';
import 'package:hosres_finder/features/home/widgets/home_header.dart';

import '../geolocator/bloc/geolocator_bloc.dart';
import '../places/bloc/place_nearby__bloc.dart';
import '../places/data/model/place_nearby_model.dart';
import '../places/domain/usecase/get_place_nearby_usecase.dart';
import 'widgets/home_search_box.dart';
import 'widgets/section_title.dart';

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
          ),
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
                          PlaceNearbyParams(lat, lng, 'hospital'),
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
              title: 'Restaurants Nearby (Rad. 5km)',
            ),
            const SizedBox(
              height: 7,
            ),
            // BlocBuilder<PlaceNearbyBloc, PlaceNearbyState>(
            //   builder: (_, state) {
            //     if (state.restaurantStatus == Status.loading) {
            //       return SizedBox(
            //         height: 300,
            //         child: ListView.separated(
            //           itemCount: 5,
            //           scrollDirection: Axis.horizontal,
            //           separatorBuilder: (context, index) => const SizedBox(
            //             width: 8,
            //           ),
            //           itemBuilder: (BuildContext context, int index) {
            //             return Container(
            //               height: 300,
            //               width: MediaQuery.of(context).size.width / 1.5,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(12),
            //                 color: Colors.grey[400],
            //               ),
            //             );
            //           },
            //         ),
            //       );
            //     } else if (state.restaurantStatus == Status.complete) {
            //       return PlacesWidget(
            //         places: state.restaurants!,
            //       );
            //     } else {
            //       return SizedBox(
            //         height: 300,
            //         child: ListView.separated(
            //           itemCount: 5,
            //           scrollDirection: Axis.horizontal,
            //           separatorBuilder: (context, index) => const SizedBox(
            //             width: 8,
            //           ),
            //           itemBuilder: (BuildContext context, int index) {
            //             return Container(
            //               height: 300,
            //               width: MediaQuery.of(context).size.width / 1.5,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(12),
            //                 color: Colors.grey[400],
            //               ),
            //             );
            //           },
            //         ),
            //       );
            //     }
            //   },
            // ),
            // const SizedBox(
            //   height: 7,
            // ),
            const SectionTitle(
              title: 'Hospitals Nearby (Rad. 5km)',
            ),
            const SizedBox(
              height: 7,
            ),
            BlocBuilder<PlaceNearbyBloc, PlaceNearbyState>(
              builder: (_, state) {
                if (state.hospitalStatus == Status.loading) {
                  return SizedBox(
                    height: 300,
                    child: ListView.separated(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 8,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width / 1.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                  );
                } else if (state.hospitalStatus == Status.complete) {
                  print(state.hospitals.length);
                  // return PlacesWidget(
                  //   places: state.hospitals,
                  // );
                  return const SizedBox(
                    child: Text('Complete'),
                  );
                } else {
                  return SizedBox(
                    height: 300,
                    child: ListView.separated(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 8,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width / 1.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
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

class PlacesWidget extends StatelessWidget {
  const PlacesWidget({super.key, required this.places});

  final PlaceNearbyModel places;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(
          width: 8,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: InkWell(
              onTap: () {
                print('OK');
              },
              child: SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width / 1.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        'https://lh3.googleusercontent.com/p/AF1QipMFzhcswGnLdgLP5B1llZ8rqShueF24zs5jkXnx=s680-w680-h510',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                places.result![index].name!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Text(
                                'askdhasjdksalh djslkah djksalh d',
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.abc,
                                ),
                                Icon(
                                  Icons.abc,
                                ),
                                Icon(
                                  Icons.abc,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
