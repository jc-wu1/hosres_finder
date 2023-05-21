import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosres_finder/features/geolocator/data/repository/geolocator_repository_impl.dart';

import 'features/geolocator/bloc/geolocator_bloc.dart';
import 'features/home/display/home_page.dart';

class HosResApp extends StatelessWidget {
  const HosResApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => GeolocatorRepositoryImpl(),
      child: BlocProvider(
        create: (context) => GeolocatorBloc(
          repository: context.read<GeolocatorRepositoryImpl>(),
        )..add(GeolocatorLoaded()),
        child: MaterialApp(
          title: 'HosRes Finder App',
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          home: const Homepage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}
