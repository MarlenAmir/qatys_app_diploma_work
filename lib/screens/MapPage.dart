import 'package:diploma_work/screens/BookinPageFromMap.dart';
import 'package:diploma_work/screens/BookingPage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:google_fonts/google_fonts.dart';


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  late LocationData _currentLocation;

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

  static final CameraPosition initialPosition = CameraPosition(
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

        BookingData bookingData = BookingData(
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
                  builder: (context) => BookingPageFromMap(
                    bookingData: bookingData,
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

class BookingData {
  final String image;
  final String name;
  final String location;
  final String playersQuantity;
  final String coatingType;
  final String description;

  BookingData(
      {required this.image,
      required this.name,
      required this.location,
      required this.playersQuantity,
      required this.coatingType,
      required this.description});
}
