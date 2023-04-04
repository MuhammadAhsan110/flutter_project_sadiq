//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UpdateLocationPage extends StatefulWidget {
  const UpdateLocationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UpdateLocationPageState createState() => _UpdateLocationPageState();
}

class _UpdateLocationPageState extends State<UpdateLocationPage> {
  final databaseReference = FirebaseDatabase.instance.ref('location');
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _updateLocation();
  }

  // Get the user's current location
  Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // Update the user's location in the database
  _updateLocation() async {
    Position position = await _getCurrentLocation();
    setState(() {
      _currentPosition = position;
    });
    databaseReference.child('1').set({
      'latitude': _currentPosition!.latitude,
      'longitude': _currentPosition!.longitude,
    });
  }

  // Update the user's location in Firebase
  // _updateLocation() async {
  //   try {
  //     await databaseReference.child('users').child('userId').update({
  //       'latitude': _currentPosition!.latitude,
  //       'longitude': _currentPosition!.longitude,
  //     });
  //     print('Location updated successfully');
  //   } catch (e) {
  //     print('Error updating location: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Location'),
      ),
      body: Center(
        // ignore: unnecessary_null_comparison
        child: _currentPosition != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Latitude: ${_currentPosition!.latitude}'),
                  Text('Longitude: ${_currentPosition!.longitude}'),
                  const SizedBox(height: 20),
                  const Text('Location updated on firebase')
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
