// import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/util/location_util.dart';
import 'package:flutter_maps/widget/my_location_button_widget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'src/locations.dart' as locations;

class NewMapView extends StatefulWidget {
  @override
  _NewMapViewState createState() => _NewMapViewState();
}

class _NewMapViewState extends State<NewMapView> {
  Set<Marker> curentMarker = {};
  GoogleMapController? mapController;
  List<Placemark> _listAddress = [];
  late Position _currentPosition;
  // use/edit it for state management or anything from outside of dimension
  MyLocationModel? _myLocationModel;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    await _getMyPosition();
  }

  void _onMapTapped(LatLng latLang) {
    var _position = Position(
        longitude: latLang.longitude,
        latitude: latLang.latitude,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0);
    _setStateMarkerAndAddressAndCameraFromPosition(_position);
  }

  Future<Position> _getMyPosition() async {
    var position = await LocationUtils.getCurrentPosition();
    await _setStateMarkerAndAddressAndCameraFromPosition(position);
    return position;
  }

  // inti nye disini
  Future<void> _setStateMarkerAndAddressAndCameraFromPosition(
      Position position) async {
    var _addresses = await _getListAddresFromPosition(position);
    // place mark(addres) paling dekat dengan marker di index [0]
    final _address = _addresses[0];
    setState(() {
      _currentPosition = position;
      _listAddress = _addresses;
      curentMarker = {
        Marker(
          markerId: MarkerId('Current Position'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: _address.name,
            snippet:
                '${_address.name}, ${_address.locality}, ${_address.postalCode}, ${_address.country}',
          ),
        )
      };
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
          ),
        ),
      );
    });
  }

  Future<List<Placemark>> _getListAddresFromPosition(Position position) async {
    var addresses = await LocationUtils.getListAddressFromPosition(position);
    return addresses;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      onTap: _onMapTapped,
                      myLocationEnabled: false,
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: const LatLng(0, 0),
                        zoom: 2,
                      ),
                      markers: curentMarker,
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
              Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: ListView.builder(
                      itemCount: _listAddress.length,
                      itemBuilder: (context, index) {
                        var _place = _listAddress[index];
                        return ListTile(
                          onTap: () {
                            // set _myLocationModel (current_position and address_choosen)
                            _myLocationModel =
                                MyLocationModel(_currentPosition, _place);

                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: Text(
                                          _myLocationModel?.placemark.name ??
                                              'not found'),
                                      content: Column(
                                        children: [
                                          Text(
                                              'latitude: ${_myLocationModel?.position.latitude}'),
                                          Text(
                                              'longitude: ${_myLocationModel?.position.longitude}'),
                                          Text(
                                              'address: ${_myLocationModel?.placemark.street}'),
                                        ],
                                      ),
                                    ));
                          },
                          title: Text(_place.name ?? 'not found'),
                          subtitle: Text(
                              '${_place.name}, ${_place.locality}, ${_place.postalCode}, ${_place.country}'),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
