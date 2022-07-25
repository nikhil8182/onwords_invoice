import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
          onTap: onClicked,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: 130,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xffFF7E44),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(8, 8),
                    blurRadius: 10,
                    spreadRadius: 0)
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontFamily: 'Nexa',
                      color: Colors.white),
                ),
                Image.asset('assets/pdf.png',scale: 3.0,),

              ],
            ),
          ),
        );
}


// GestureDetector(
//   onTap: () {
//
//   },
//   child: Container(
//     padding: EdgeInsets.symmetric(horizontal: width*0.02),
//     width: width * 0.30,
//     height: height * 0.06,
//     decoration: BoxDecoration(
//       color: Color(0xffFF7E44),
//       borderRadius: BorderRadius.circular(15),
//       boxShadow: [
//         BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             offset: Offset(8, 8),
//             blurRadius: 10,
//             spreadRadius: 0)
//       ],
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           "Save as",
//           style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: height * 0.013,
//               fontFamily: 'Nexa',
//               color: Colors.white),
//         ),
//         Image.asset('assets/pdf.png',scale: 3.0,),
//
//       ],
//     ),
//   ),
// )