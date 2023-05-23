import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosres_finder/core/dependency_injector/dependency_injector.dart';

import '../../places/bloc/place_nearby_bloc.dart';
import 'bloc/fav_places_bloc.dart';

class FavPlacesPage extends StatelessWidget {
  const FavPlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavPlacesBloc(
        sl(),
        sl(),
        sl(),
      )..add(FavPlacesRequested()),
      child: const FavPlacesView(),
    );
  }
}

class FavPlacesView extends StatelessWidget {
  const FavPlacesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fav Places'),
      ),
      body: BlocBuilder<FavPlacesBloc, FavPlacesState>(
        builder: (_, state) {
          if (state.status == Status.loading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state.status == Status.complete) {
            return Center(
              child: Text('${state.favPlaces.length}'),
            );
          } else if (state.status == Status.failure) {
            return const Center(
              child: Text('Failed'),
            );
          } else {
            return const Center(
              child: Text('Unknown Error'),
            );
          }
        },
      ),
    );
  }
}
