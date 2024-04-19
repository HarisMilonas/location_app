import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_app/models/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.98518680360116,
      longitude: 23.727138589661514,
      address: '',
    ),
  });

  final PlaceLocation location;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  void initState() {
    super.initState();
    _pickedLocation =
        LatLng(widget.location.latitude, widget.location.longitude);
  }

  void _selectLocation(dynamic tapPosn, LatLng posn) {
    setState(() {
      _pickedLocation = posn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick your Location'), actions: [
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            Navigator.of(context).pop(_pickedLocation);
          },
        ),
      ]),
      body: FlutterMap(
        options: MapOptions(
          initialCenter:
              LatLng(widget.location.latitude, widget.location.longitude),
          initialZoom: 15.0,
          onTap: _selectLocation,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://{s}.google.com/vt/lyrs=m&hl={hl}&x={x}&y={y}&z={z}',
            additionalOptions: const {'hl': 'en'},
            subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
          ),
          if (_pickedLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _pickedLocation!,
                  child: const Icon(
                    Icons.location_on,
                    size: 25,
                    color: Colors.red,
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
