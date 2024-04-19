import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:map_launcher/map_launcher.dart';
import 'package:test_app/map_image.dart';
import 'package:test_app/models/location.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  loc.LocationData? locationData;
  PlaceLocation? selectedLocation;
  late final MapController mapController;
  LatLng? pickedLocation;
  bool isLoading = false;

  @override
  void initState() {
    mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  Future<String> _getAddress(double latitude, double longitude) async {
    final addressData = await getLocationAddress(latitude, longitude);

    final String street = addressData[0].street;
    final String postalcode = addressData[0].postalCode;
    final String locality = addressData[0].locality;
    final String country = addressData[0].country;
    final String address = '$street, $postalcode, $locality, $country';

    return address;
  }

  Future<void> getLocation() async {
    setState(() {
      isLoading = true;
    });
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    double latitude;
    double longitude;

    if (pickedLocation != null) {
      latitude = pickedLocation!.latitude;
      longitude = pickedLocation!.longitude;
    } else {
      if (locationData == null) {
        return;
      }
      latitude = locationData!.latitude!;
      longitude = locationData!.longitude!;
    }

    String address = await _getAddress(latitude, longitude);

    final locationNow = PlaceLocation(
        latitude: latitude, longitude: longitude, address: address);

    pickedLocation = null;

    if (mounted) {
      setState(() {
        isLoading = false;
      });
      final newLocation = await Navigator.of(context).push<LatLng>(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (ctx) => MapScreen(location: locationNow),
        ),
      );
      if (newLocation != null) {
        setState(() {
          pickedLocation = newLocation;
        });
      } else {
        setState(() {
          pickedLocation = LatLng(locationNow.latitude, locationNow.longitude);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );

    if (pickedLocation != null) {
      previewContent = FlutterMap(
        mapController: mapController,
        options: MapOptions(
          interactionOptions:
              const InteractionOptions(flags: InteractiveFlag.none),
          initialCenter:
              LatLng(pickedLocation!.latitude, pickedLocation!.longitude),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://{s}.google.com/vt/lyrs=m&hl={hl}&x={x}&y={y}&z={z}',
            additionalOptions: const {'hl': 'en'},
            subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point:
                    LatLng(pickedLocation!.latitude, pickedLocation!.longitude),
                child: const Icon(
                  Icons.location_on,
                  size: 25,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 250,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : previewContent,
          ),
          const SizedBox(height: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    onPressed: () => getLocation(),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [Text("Location"), Icon(Icons.location_on)],
                    )),
                pickedLocation != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: ElevatedButton(
                            onPressed: () => openMapsSheet(context),
                            child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Open in maps'),
                                  SizedBox(width: 5),
                                  Icon(Icons.map),
                                ])),
                      )
                    : const SizedBox(),
              ])
        ]));
  }

  Future<List> getLocationAddress(double latitude, double longitude) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(latitude, longitude);
    return placemark;
  }

  openMapsSheet(context) async {
    try {
      final coords =
          Coords(pickedLocation!.latitude, pickedLocation!.longitude);
      final title = await _getAddress(
          pickedLocation!.latitude, pickedLocation!.longitude);

      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showMarker(
                        coords: coords,
                        title: title,
                      ),
                      title: Text(map.mapName),
                      leading: map.mapType == MapType.google
                          ? Image.asset("assets/images/google_maps.png",
                              width: 30, height: 30)
                          : map.mapType == MapType.apple
                              ? Image.asset("assets/images/IOS_maps.png",
                                  width: 30, height: 30)
                              : const Icon(Icons.map),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}