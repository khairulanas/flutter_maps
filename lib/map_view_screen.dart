import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    // Determining the screen width & height
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    GoogleMapController mapController;

    CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));

    return Container(
      height: height,
      width: width,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: ClipOval(
                child: Material(
                  color: Colors.orange[100], // button color
                  child: InkWell(
                    splashColor: Colors.orange, // inkwell color
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(Icons.my_location),
                    ),
                    onTap: () {
                      // TODO: Add the operation to be performed
                      // on button tap
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
