import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;

  List<Marker> _markers = [];

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(43.238949, 76.889709),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    // Получить данные из Firebase и создать маркеры
    FirebaseFirestore.instance
        .collection('foregrounds')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        String name = data['name'];
        double latitude = data['latitude'];
        double longitude = data['longitude'];
        Marker marker = Marker(
          markerId: MarkerId(doc.id),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(title: name),
          onTap: () {
            // Здесь вы можете передать данные в другую страницу, используя Navigator.push()
          },
        );
        _markers.add(marker);
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Тренажерные залы')),
      body: GoogleMap(
        markers: Set<Marker>.from(_markers),
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }
}




  /*late GoogleMapController _mapController;

  final List<Marker> _markers = [
    Marker(
      markerId: MarkerId('PFC'),
      position: LatLng(43.247857, 76.910402),
      infoWindow: InfoWindow(title: 'PFC'),
      onTap: (){

      }
    ),
    Marker(
      markerId: MarkerId('Jas Qyran'),
      position: LatLng(43.229931, 76.910402),
      infoWindow: InfoWindow(title: 'Jas Qyran'),
      onTap: (){
        
      }
    ),
    Marker(
      markerId: MarkerId('AlmatyArena'),
      position: LatLng(43.265689, 76.814821),
      infoWindow: InfoWindow(title: 'AlmatyArena'),
      onTap: (){
        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BookingPage(firebaseData: ,),));
      }
    ),
  ];

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(43.238949, 76.889709),
    zoom: 15,
  );
  
  
  
  
  
  
  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingPage(firebaseData: ,)
              ),
            );
  
  
  */