import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosres_finder/core/dependency_injector/dependency_injector.dart';

import '../../../core/constant.dart';
import '../../home/widgets/empty_widget.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Favorite Places'),
      ),
      body: BlocBuilder<FavPlacesBloc, FavPlacesState>(
        builder: (_, state) {
          if (state.status == Status.loading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state.status == Status.complete) {
            if (state.favPlaces.isEmpty) {
              return const EmptyWidget();
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              itemCount: state.favPlaces.length,
              separatorBuilder: (context, index) => const SizedBox(
                width: 8,
              ),
              itemBuilder: (_, int index) {
                String imgUrl = '';
                if (state.favPlaces[index].photos!.isNotEmpty) {
                  imgUrl = getPhotoUrl(
                    state.favPlaces[index].photos!.first.photoReference!,
                  );
                } else {
                  imgUrl = noImage;
                }
                return Card(
                  child: InkWell(
                    onTap: () {},
                    child: SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Stack(
                        children: [
                          Column(
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
                                  imgUrl,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              state.favPlaces[index].name!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              context.read<FavPlacesBloc>().add(
                                                    FavPlacesRemoved(
                                                      state.favPlaces[index],
                                                    ),
                                                  );
                                              context
                                                  .read<FavPlacesBloc>()
                                                  .add(FavPlacesRequested());
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                            ),
                                          )
                                        ],
                                      ),
                                      Expanded(
                                        child: Text(
                                          state.favPlaces[index].vicinity!,
                                          style: const TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          state.favPlaces[index].priceLevel !=
                                                  null
                                              ? Row(
                                                  children: [
                                                    const Text(
                                                      'Price: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      '\$' *
                                                          state.favPlaces[index]
                                                              .priceLevel!
                                                              .toInt(),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox.shrink(),
                                          const Text(
                                            ' • ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.alarm,
                                                size: 14,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                state.favPlaces[index]
                                                        .openingHours!.openNow!
                                                    ? 'Open'
                                                    : 'Closed',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Card(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 4,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 14,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      state.favPlaces[index].rating.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      '(${state.favPlaces[index].userRatingsTotal.toString()})',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
