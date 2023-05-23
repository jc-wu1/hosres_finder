import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant.dart';
import '../../fav_places/display/bloc/fav_places_bloc.dart';
import '../../places/data/model/place_nearby_model.dart';

class PlacesWidget extends StatelessWidget {
  const PlacesWidget({super.key, required this.places});

  final List<Result> places;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        itemCount: places.length,
        separatorBuilder: (context, index) => const SizedBox(
          width: 8,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index) {
          String imgUrl = '';
          if (places[index].photos!.isNotEmpty) {
            imgUrl = getPhotoUrl(
              places[index].photos!.first.photoReference!,
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
                            height: 155,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        places[index].name!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    BlocBuilder<FavPlacesBloc, FavPlacesState>(
                                      builder: (_, state) {
                                        return IconButton(
                                          onPressed: () {
                                            _onFavouriteButtonPressed(
                                              state,
                                              index,
                                              context,
                                            );
                                          },
                                          icon: !state.favPlaces
                                                  .contains(places[index])
                                              ? const Icon(
                                                  Icons.favorite_outline,
                                                  color: Colors.red,
                                                )
                                              : const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Text(
                                    places[index].vicinity!,
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    places[index].priceLevel != null
                                        ? Row(
                                            children: [
                                              const Text(
                                                'Price: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                '\$' *
                                                    places[index]
                                                        .priceLevel!
                                                        .toInt(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
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
                                          places[index].openingHours!.openNow!
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
                                places[index].rating.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                '(${places[index].userRatingsTotal.toString()})',
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
      ),
    );
  }

  void _onFavouriteButtonPressed(
    FavPlacesState state,
    int index,
    BuildContext context,
  ) {
    if (state.favPlaces.contains(places[index])) {
      context.read<FavPlacesBloc>().add(
            FavPlacesRemoved(
              places[index],
            ),
          );
    }

    if (!state.favPlaces.contains(places[index])) {
      context.read<FavPlacesBloc>().add(
            FavPlacesSaved(
              places[index],
            ),
          );
    }

    context.read<FavPlacesBloc>().add(FavPlacesRequested());
  }
}
