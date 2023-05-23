import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  const MapPage({
    Key? key,
    required this.position,
  }) : super(key: key);

  final LatLng position;

  @override
  Widget build(BuildContext context) {
    return MapView(
      latLng: position,
    );
  }
}

class MapView extends StatefulWidget {
  const MapView({Key? key, required this.latLng}) : super(key: key);

  final LatLng latLng;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? controller;

  LatLng? newloc;

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: GoogleMap(
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.latLng.latitude, widget.latLng.longitude),
                zoom: 15,
              ),
              onMapCreated: (c) {
                setState(() {
                  controller = c;
                });
              },
              markers: {
                Marker(
                  markerId: const MarkerId(
                    'MyLocation',
                  ),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(
                    widget.latLng.latitude,
                    widget.latLng.longitude,
                  ),
                  draggable: true,
                  onDragEnd: (newPosition) {
                    controller!.animateCamera(
                      CameraUpdate.newLatLng(newPosition),
                    );
                    setState(() {
                      newloc = newPosition;
                    });
                  },
                )
              },
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
              onPressed: () {
                if (newloc != null) {
                  Navigator.pop(context, newloc);
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Location'),
            ),
          )
        ],
      ),
    );
  }
}
