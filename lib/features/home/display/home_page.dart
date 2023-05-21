import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../geolocator/bloc/geolocator_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.title});

  final String title;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  GoogleMapController? googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<GeolocatorBloc, GeolocatorState>(
              builder: (context, state) {
                if (state is GeolocatorLoadInProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GeolocatorLoadComplete) {
                  return SizedBox(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          state.position.latitude,
                          state.position.longitude,
                        ),
                        zoom: 15,
                      ),
                      onTap: (LatLng pos) {
                        print(pos);
                      },
                      onMapCreated: (controller) {
                        googleMapController = controller;
                      },
                      markers: {
                        Marker(
                          markerId: const MarkerId('MyLocation'),
                          draggable: true,
                          position: LatLng(
                            state.position.latitude,
                            state.position.longitude,
                          ),
                          icon: BitmapDescriptor.defaultMarker,
                          onDragEnd: (newPosition) {
                            googleMapController?.animateCamera(
                              CameraUpdate.newLatLng(newPosition),
                            );
                          },
                        ),
                      },
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const CustomHeader(),
            DraggableScrollableSheet(
              initialChildSize: 0.2,
              minChildSize: 0.2,
              maxChildSize: 1,
              snapSizes: const [0.2, 1],
              snap: true,
              builder: (_, scrollSheetController) {
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    physics: const ClampingScrollPhysics(),
                    controller: scrollSheetController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: const [
                            SizedBox(
                              width: 50,
                              child: Divider(
                                thickness: 5,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Places Nearby',
                                style: TextStyle(fontSize: 21),
                              ),
                            )
                          ],
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          onTap: () {},
                          leading: const Icon(Icons.car_rental),
                          title: const Text("Test"),
                          selectedTileColor: Colors.grey[200],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Search text field plus the horizontally scrolling categories below the text field
class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        CustomSearchContainer(),
        CustomSearchCategories(),
      ],
    );
  }
}

class CustomSearchContainer extends StatelessWidget {
  const CustomSearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: <Widget>[
            const CustomTextField(),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {
                print('Saved places');
              },
              icon: const Icon(Icons.favorite),
              tooltip: 'Saved places',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        maxLines: 1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(16),
          hintText: "Search here",
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class CustomSearchCategories extends StatelessWidget {
  const CustomSearchCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        SizedBox(width: 16),
        CustomCategoryChip(Icons.local_hospital, "Hospital"),
        SizedBox(width: 12),
        CustomCategoryChip(Icons.restaurant, "Restaurant"),
      ],
    );
  }
}

class CustomCategoryChip extends StatelessWidget {
  final IconData iconData;
  final String title;

  const CustomCategoryChip(this.iconData, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      onSelected: (value) {},
      label: Row(
        children: <Widget>[
          Icon(iconData, size: 16),
          const SizedBox(width: 8),
          Text(title)
        ],
      ),
      selected: true,
      backgroundColor: Colors.grey[50],
    );
  }
}
