// import 'package:flutter/material.dart';

// Widget textField({
//   required TextEditingController controller,
//   required String label,
//   required String hint,
//   required String initialValue,
//   required double width,
//   required Icon prefixIcon,
//   required Widget suffixIcon,
//   required Function(String) locationCallback,
// }) {
//   return Container(
//     width: width * 0.8,
//     child: TextField(
//       onChanged: (value) {
//         locationCallback(value);
//       },
//       controller: controller,
//       // initialValue: initialValue,
//       decoration: new InputDecoration(
//         prefixIcon: prefixIcon,
//         suffixIcon: suffixIcon,
//         labelText: label,
//         filled: true,
//         fillColor: Colors.white,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(10.0),
//           ),
//           borderSide: BorderSide(
//             color: Colors.grey[400]!,
//             width: 2,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(10.0),
//           ),
//           borderSide: BorderSide(
//             color: Colors.blue[300]!,
//             width: 2,
//           ),
//         ),
//         contentPadding: EdgeInsets.all(15),
//         hintText: hint,
//       ),
//     ),
//   );
// }
