import 'package:flutter/material.dart';
import 'package:flutter_maps/widget/my_location_button_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'src/locations.dart' as locations;

class NewMapView extends StatefulWidget {
  @override
  _NewMapViewState createState() => _NewMapViewState();
}

class _NewMapViewState extends State<NewMapView> {
  final Map<String, Marker> _markers = {};
  GoogleMapController? mapController;
  Position? _currentPosition;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    // final googleOffices = await locations.getGoogleOffices();
    // setState(() {
    //   _markers.clear();
    //   for (final office in googleOffices.offices) {
    //     final marker = Marker(
    //       markerId: MarkerId(office.name),
    //       position: LatLng(office.lat, office.lng),
    //       infoWindow: InfoWindow(
    //         title: office.name,
    //         snippet: office.address,
    //       ),
    //     );
    //     _markers[office.name] = marker;
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: const LatLng(0, 0),
                zoom: 2,
              ),
              markers: _markers.values.toSet(),
            ),
            Positioned(
              bottom: 120,
              right: 20,
              child: MyLocationButtonWidget(
                onGetMyLocationSucces: (position) {
                  setState(() {
                    _currentPosition = position;
                    mapController?.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(position.latitude, position.longitude),
                          zoom: 18.0,
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
