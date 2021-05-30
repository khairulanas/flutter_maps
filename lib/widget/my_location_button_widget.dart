import 'package:flutter/material.dart';

class MyLocationButtonWidget extends StatelessWidget {
  const MyLocationButtonWidget({Key? key, this.onTap}) : super(key: key);
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.orange[100], // button color
        child: InkWell(
          splashColor: Colors.orange,
          onTap: onTap,
          // onTap: () async {
          //   var _position = await LocationUtils.getCurrentPosition();
          //   if (onGetMyLocationSucces != null) {
          //     onGetMyLocationSucces!(_position);
          //   }
          // }, // inkwell color
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
