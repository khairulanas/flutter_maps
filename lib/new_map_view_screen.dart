import 'package:flutter/material.dart';
import 'package:flutter_maps/src/location_util.dart';
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
  final startAddressController = TextEditingController();
  String _currentAddress = '';

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    await _getMyPosition();
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

  Future<void> _getMyPosition() async {
    await LocationUtils.getCurrentPosition().then((value) {
      setState(() {
        _currentPosition = value;
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
    });
  }

  _getAddres() async {
    var eitherPlace =
        await LocationUtils.getAddressFromPosition(_currentPosition!);
    eitherPlace.fold(
        (error) => null,
        (place) => _currentAddress =
            '${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}');
    startAddressController.text = _currentAddress;
  }

  @override
  void initState() {
    super.initState();
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
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: const LatLng(0, 0),
                zoom: 2,
              ),
              markers: _markers.values.toSet(),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: MyLocationButtonWidget(
                onTap: _getMyPosition,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
