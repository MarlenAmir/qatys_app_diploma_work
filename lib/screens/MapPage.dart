import 'package:diploma_work/screens/BookingPage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:diploma_work/screens/model/firebaseData.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  LocationData? _currentLocation;

  void _getUserLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData currentLocation = await location.getLocation();
    setState(() {
      _currentLocation = currentLocation;
    });
  }

  List<Marker> markers = [];

  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(43.238949, 76.889709),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    getMarkersFromFirestore();
  }

  Future<void> getMarkersFromFirestore() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('foregrounds').get();

    setState(() {
      markers = querySnapshot.docs.map((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        FirebaseData firebaseData = FirebaseData(
            image: data['image_url'],
            name: data['name'],
            location: data['location'],
            playersQuantity: data['playersQuantity'],
            coatingType: data['coatingType'],
            description: data['description']);

        double latitude = double.parse(data['latitude'] as String);
        double longitude = double.parse(data['longitude'] as String);
        String name = data['name'] as String;

        return Marker(
            markerId: MarkerId(document.id),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingPage(
                    firebaseData: firebaseData,
                  ),
                ),
              );
            });
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        markers: Set<Marker>.of(markers),
        initialCameraPosition: initialPosition,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          _getUserLocation();
        },
      ),
    );
  }
}
