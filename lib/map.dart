import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripMapPage extends StatefulWidget {
  final LatLng startLocation;
  final LatLng destinationLocation;
  final List<LatLng> places;

  TripMapPage({
    required this.startLocation,
    required this.destinationLocation,
    required this.places,
  });

  @override
  _TripMapPageState createState() => _TripMapPageState();
}

class _TripMapPageState extends State<TripMapPage> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.startLocation,
          zoom: 10,
        ),
        onMapCreated: (controller) {
          setState(() {
            _mapController = controller;
          });
        },
        markers: {
          Marker(
            markerId: MarkerId('start'),
            position: widget.startLocation,
            infoWindow: InfoWindow(title: 'Starting Location'),
          ),
          Marker(
            markerId: MarkerId('destination'),
            position: widget.destinationLocation,
            infoWindow: InfoWindow(title: 'Destination Place'),
          ),
          ...widget.places.map((place) {
            return Marker(
              markerId: MarkerId(place.toString()),
              position: place,
              infoWindow: InfoWindow(title: 'Place'),
            );
          }),
        },
        polylines: {
          Polyline(
            polylineId: PolylineId('route'),
            points: [widget.startLocation, ...widget.places, widget.destinationLocation],
            color: Colors.blue,
            width: 5,
          ),
        },
      ),
    );
  }
}
