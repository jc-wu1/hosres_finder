import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosres_finder/core/dependency_injector/dependency_injector.dart';

import '../geolocator/bloc/geolocator_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GeolocatorBloc(
        repository: sl(),
      )..add(GeolocatorLoaded()),
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
            Row(
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
                      BlocBuilder<GeolocatorBloc, GeolocatorState>(
                        builder: (context, state) {
                          if (state.status == GeolocatorStatus.loading) {
                            return Container(
                              height: 20,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(25),
                              ),
                            );
                          } else if (state.status ==
                              GeolocatorStatus.complete) {
                            return TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'RQ7H+4H2 Kebon Jeruk, West Jakarta City, Jakarta, Indonesia',
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.greenAccent,
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 36,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.search,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Find Places',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Restaurants Nearby',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.greenAccent[400],
                  ),
                  onPressed: () {},
                  child: const Text(
                    'See all',
                  ),
                ),
              ],
            ),
            SizedBox(
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
                                'https://lh3.googleusercontent.com/p/AF1QipO0bZMvr61GApJhs750Tu7dK2Qy_Ot4mLlZT8WM=s680-w680-h510',
                                height: 150,
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
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Darrius co-working space the fox quick brown jump',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Text(
                                        'Jl. Arjuna Sel. No.75, RT.2/RW.12, Kb. Jeruk, Kec. Kb. Jeruk, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11530, Indonesia',
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
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hospitals Nearby',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.greenAccent[400],
                  ),
                  onPressed: () {},
                  child: const Text(
                    'See all',
                  ),
                ),
              ],
            ),
            SizedBox(
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Darrius co-working space the fox quick brown jump',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Text(
                                        'Jl. Arjuna Sel. No.75, RT.2/RW.12, Kb. Jeruk, Kec. Kb. Jeruk, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11530, Indonesia',
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
            ),
          ],
        ),
      ),
    );
  }
}
