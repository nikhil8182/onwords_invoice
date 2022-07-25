// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:onwords_invoice/Screens/Customer_Details_Screen.dart';
//
// import 'Account_Screen.dart';
// import 'invoice_and_Draft_Screen.dart';
//
//
// class UploadData extends StatefulWidget {
//   const UploadData({Key? key}) : super(key: key);
//
//   @override
//   State<UploadData> createState() => _UploadDataState();
// }
//
// class _UploadDataState extends State<UploadData> {
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title:    Text(
//           "Company Name",
//           style: TextStyle(
//               fontFamily: 'Nexa',
//               fontWeight: FontWeight.w700,
//               color: Colors.black,
//               fontSize: height * 0.018),
//         ),
//         centerTitle: true,
//         leading:   GestureDetector(
//           child: Image.asset(
//             'assets/back arrow.png',
//             scale: 2.3,
//           ),
//           onTap: () {
//             setState(() {
//               Navigator.pop(context);
//             });
//           },
//         ),
//         actions: [
//           GestureDetector(
//             child: Icon(
//               Icons.account_circle_outlined,
//               color: Colors.deepOrangeAccent,
//               size: height * 0.03,
//             ),
//             onTap: () {
//               setState(() {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const AccountScreen()));
//               });
//             },
//           ),
//           SizedBox(width: width*0.05,)
//
//         ],
//       ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//
//             Container(
//               margin: EdgeInsets.all(height * 0.09),
//               // color: Colors.blue,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Upload Logo",
//                           style: TextStyle(
//                               fontFamily: 'Nexa',
//                               fontWeight: FontWeight.w700,
//                               fontSize: height * 0.02),
//                         ),
//                         GestureDetector(
//                           onTap: () {},
//                           child: Container(
//                               margin: EdgeInsets.only(top: height*0.02),
//                               height: height * 0.12,
//                               width: width*0.8,
//                               decoration: BoxDecoration(
//                                   color: Color(0xffF7F9FC),
//                                   borderRadius: BorderRadius.circular(20),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.black.withOpacity(0.2),
//                                         offset: Offset(5, 5),
//                                         blurRadius: 10,
//                                         spreadRadius: 0)
//                                   ]),
//                               child: Center(
//                                 child: Image.asset(
//                                   'assets/upload.png',
//                                   scale: 2.8,
//                                 ),
//                               )),
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: height * 0.03,
//                   ),
//                   SizedBox(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Upload Sing",
//                           style: TextStyle(
//                               fontFamily: 'Nexa',
//                               fontWeight: FontWeight.w700,
//                               fontSize: height * 0.02),
//                         ),
//                         GestureDetector(
//                           onTap: () {},
//                           child: Container(
//                               margin: EdgeInsets.only(top: height*0.02),
//                               height: height * 0.12,
//                               decoration: BoxDecoration(
//                                 color: Color(0xffF7F9FC),
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.black.withOpacity(0.2),
//                                       offset: Offset(5, 5),
//                                       blurRadius: 10,
//                                       spreadRadius: 0)
//                                 ],
//                               ),
//                               child: Center(
//                                 child: Image.asset(
//                                   'assets/upload.png',
//                                   scale: 2.8,
//                                 ),
//                               )),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   // Navigator.push(context, MaterialPageRoute(builder: (context) => NewAndDraft()));
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => const CustomerDetails()));
//                 });
//               },
//               child: Container(
//                 width: width * 0.28,
//                 height: height * 0.05,
//                 decoration: BoxDecoration(
//                   color: Color(0xffFF7E44),
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black.withOpacity(0.3),
//                         offset: Offset(8, 8),
//                         blurRadius: 10,
//                         spreadRadius: 0)
//                   ],
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Next",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: height * 0.013,
//                         fontFamily: 'Nexa',
//                         color: Colors.white),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onwords_invoice/Screens/invoice_and_Draft_Screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../image_saving/profile_widget.dart';
import '../image_saving/user.dart';
import '../image_saving/user_preference.dart';
import 'Account_Screen.dart';
import 'Customer_Details_Screen.dart';

class UploadData extends StatefulWidget {
  const UploadData({Key? key}) : super(key: key);

  @override
  State<UploadData> createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  late User user;
  late SharedPreferences logData;

  setData() async {
    logData = await SharedPreferences.getInstance();
  }


  @override
  void initState() {
    setData();
    super.initState();
    user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Company Name",
          style: TextStyle(
              fontFamily: 'Nexa',
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: height * 0.018),
        ),
        centerTitle: true,
        leading: GestureDetector(
          child: Image.asset(
            'assets/back arrow.png',
            scale: 2.3,
          ),
          onTap: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        actions: [
          GestureDetector(
            child: Icon(
              Icons.account_circle_outlined,
              color: Colors.deepOrangeAccent,
              size: height * 0.03,
            ),
            onTap: () {
              setState(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AccountScreen()));
              });
            },
          ),
          SizedBox(
            width: width * 0.05,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(height * 0.09),
              // color: Colors.blue,
              child: Column(
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upload Logo",
                          style: TextStyle(
                              fontFamily: 'Nexa',
                              fontWeight: FontWeight.w700,
                              fontSize: height * 0.02),
                        ),
                        SizedBox(
                          height: height*0.05,
                        ),
                        SizedBox(
                          child: ProfileWidget(
                            imagePath: user.imagePath,
                            isEdit: true,
                          ),
                        ),
                        SizedBox(
                          height: height*0.05,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final image = await ImagePicker().getImage(source: ImageSource.gallery);
                            if (image == null) return;
                            final directory = await getApplicationDocumentsDirectory();
                            final name = basename(image.path);
                            final imageFile = File('${directory.path}/$name');
                            final newImage = await File(image.path).copy(imageFile.path);
                            setState(
                                    () => user = user.copy(imagePath: newImage.path));
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.02,
                                  left: width * 0.09,
                                  right: width * 0.09),
                              height: height * 0.05,
                              width: width * 0.5,
                              decoration: BoxDecoration(
                                  color: Color(0xffF7F9FC),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(5, 5),
                                        blurRadius: 10,
                                        spreadRadius: 0)
                                  ]),
                              child: Center(
                                  child: Image.asset(
                                    'assets/upload.png',
                                    scale: 3.9,
                                  ))),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  UserPreferences.setUser(user);
                  logData.setBool('login', true);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const CustomerDetails()));
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                height: height * 0.12,
                decoration: BoxDecoration(
                    color: const Color(0xffF7F9FC),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(5, 5),
                          blurRadius: 10,
                          spreadRadius: 0)
                    ]),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/new.png',
                          scale: 2.6,
                        ),
                        Text('Generate new invoice',style: TextStyle(
                            fontFamily: 'Nexa',
                            fontWeight: FontWeight.w700,
                            fontSize: height * 0.015),),
                        Image.asset(
                          'assets/right side navigate.png',
                          scale: 3.0,
                        ),
                      ],
                    )
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       UserPreferences.setUser(user);
            //       logData.setBool('login', true);
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => const NewAndDraft()));
            //     });
            //   },
            //   child: Container(
            //     width: width * 0.28,
            //     height: height * 0.05,
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
            //     child: Center(
            //       child: Text(
            //         "Next",
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: height * 0.013,
            //             fontFamily: 'Nexa',
            //             color: Colors.white),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
