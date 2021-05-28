// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapView extends StatefulWidget {
//   @override
//   _MapViewState createState() => _MapViewState();
// }

// class _MapViewState extends State<MapView> {
//   GoogleMapController? mapController;
//   // final Geolocator _geolocator = Geolocator();
//   final GeocodingPlatform _geolocator = GeocodingPlatform.instance;
//   CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
//   late Position _currentPosition;

//   final startAddressController = TextEditingController();

//   // Getting the placemarks
// List<Placemark> startPlacemark =
//     await _geolocator.placemarkFromAddress(_startAddress);
// List<Placemark> destinationPlacemark =
//     await _geolocator.placemarkFromAddress(_destinationAddress);

// // Retrieving coordinates
// Position startCoordinates = startPlacemark[0].position;
// Position destinationCoordinates = destinationPlacemark[0].;

//   // Method for retrieving the current location
//   Future<void> _getCurrentLocation() async {
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) async {
//       setState(() {
//         // Store the position in the variable
//         _currentPosition = position;

//         print('CURRENT POS: $_currentPosition');

//         // For moving the camera to current location
//         mapController?.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(position.latitude, position.longitude),
//               zoom: 18.0,
//             ),
//           ),
//         );
//       });
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   void _onPointMapTap() {
//     _getCurrentLocation();
//     mapController?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(
//             // Will be fetching in the next step
//             _currentPosition.latitude,
//             _currentPosition.longitude,
//           ),
//           zoom: 18.0,
//         ),
//       ),
//     );
//   }

//   _getAddress() async {
//     try {
//       // Places are retrieved using the coordinates
//       List<Placemark> p = await placemarkFromCoordinates(
//           _currentPosition.latitude, _currentPosition.longitude);

//       // Taking the most probable result
//       Placemark place = p[0];

//       setState(() {
//         // Structuring the address
//         _currentAddress =
//             "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";

//         // Update the text of the TextField
//         startAddressController.text = _currentAddress;

//         // Setting the user's present location as the starting address
//         _startAddress = _currentAddress;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   void initState() async {
//     super.initState();
//     _getCurrentLocation().then((_) => _onPointMapTap());
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Container(
//       height: height,
//       width: width,
//       child: Scaffold(
//         body: Stack(
//           children: <Widget>[
//             GoogleMap(
//               initialCameraPosition: _initialLocation,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: false,
//               mapType: MapType.normal,
//               zoomGesturesEnabled: true,
//               zoomControlsEnabled: false,
//               onMapCreated: (GoogleMapController controller) {
//                 mapController = controller;
//               },
//             ),
//             Positioned(
//               bottom: 20,
//               right: 20,
//               child: ClipOval(
//                 child: Material(
//                   color: Colors.orange[100], // button color
//                   child: InkWell(
//                     splashColor: Colors.orange, // inkwell color
//                     child: SizedBox(
//                       width: 56,
//                       height: 56,
//                       child: Icon(Icons.my_location),
//                     ),
//                     onTap: () {
//                       _onPointMapTap();
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
