import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosres_finder/core/dependency_injector/dependency_injector.dart';
import 'package:hosres_finder/features/places/display/bloc/place_bloc.dart';

import 'features/geolocator/bloc/geolocator_bloc.dart';
import 'features/home/display/home_page.dart';

class HosResApp extends StatelessWidget {
  const HosResApp({super.key});

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
          create: (context) => PlaceBloc(
            sl(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'HosRes Finder App',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const Homepage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
