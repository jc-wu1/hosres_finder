import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosres_finder/core/dependency_injector/dependency_injector.dart';
import 'package:hosres_finder/features/home/widgets/empty_widget.dart';

import '../../../core/constant.dart';
import 'bloc/search_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(sl()),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {},
                ),
                hintText: 'Search...',
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                context.read<SearchBloc>().add(SearchRequested(value));
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is SearchLoadComplete) {
            final candidates = state.candidate.candidates;
            if (candidates!.isEmpty) {
              return const EmptyWidget();
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              itemCount: candidates.length,
              separatorBuilder: (context, index) => const SizedBox(
                width: 8,
              ),
              itemBuilder: (_, int index) {
                String imgUrl = '';
                if (candidates[index].photos!.isNotEmpty) {
                  imgUrl = getPhotoUrl(
                    candidates[index].photos!.first.photoReference!,
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
                                      Expanded(
                                        child: Text(
                                          candidates[index].name!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          candidates[index].formattedAddress!,
                                          style: const TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
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
                                                candidates[index]
                                                        .openingHours!
                                                        .openNow!
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
                                      candidates[index].rating.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      '(${candidates[index].userRatingsTotal.toString()})',
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
          }
          if (state is SearchLoadFailure) {
            return const EmptyWidget();
          }
          return Center(
            child: Image.asset('assets/images/illustration.png'),
          );
        },
      ),
    );
  }
}
