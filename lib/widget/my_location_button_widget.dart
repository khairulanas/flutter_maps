import 'package:flutter/material.dart';
import 'package:flutter_maps/src/location_util.dart';
import 'package:geolocator/geolocator.dart';

class MyLocationButtonWidget extends StatelessWidget {
  const MyLocationButtonWidget({Key? key, this.onGetMyLocationSucces})
      : super(key: key);
  final void Function(Position)? onGetMyLocationSucces;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.orange[100], // button color
        child: InkWell(
          splashColor: Colors.orange,
          onTap: () async {
            var _position = await LocationUtils.determinePosition();
            if (onGetMyLocationSucces != null)
              onGetMyLocationSucces!(_position);
          }, // inkwell color
          child: SizedBox(
            width: 56,
            height: 56,
            child: Icon(Icons.my_location),
          ),
        ),
      ),
    );
  }
}
