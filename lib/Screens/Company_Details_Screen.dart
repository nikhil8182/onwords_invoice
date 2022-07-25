import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Upload_image_screen.dart';


class CompanyDetails extends StatefulWidget {
  const CompanyDetails({Key? key}) : super(key: key);

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {

  TextEditingController ownerName = TextEditingController();
  TextEditingController ownerStreet = TextEditingController();
  TextEditingController ownerAddress = TextEditingController();
  TextEditingController ownerPhone = TextEditingController();
  TextEditingController ownerEmail = TextEditingController();
  TextEditingController ownerWebsite = TextEditingController();
  TextEditingController ownerGst = TextEditingController();
  late SharedPreferences logData;
  final formKey = GlobalKey<FormState>();

  final companyName = TextEditingController();
  final gst = TextEditingController();
  final number = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 0.06),
                child: Center(
                  child: Text(
                    'Company Details',
                    style: TextStyle(
                        fontFamily: 'Nexa',
                        fontSize: height * 0.022,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.1),
                height: height * 0.8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.08, vertical: height * 0.05),
                        height: height * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              controller: ownerName,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Company Name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'assets/company.png',
                                    scale: 2.9,
                                  ),
                                  hintText: ' Company Name',
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Nexa')),
                            ),
                            TextFormField(
                              controller: ownerStreet,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Company Address';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'assets/location.png',
                                    scale: 2.9,
                                  ),
                                  hintText: ' Address',
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Nexa')),
                            ),
                            TextFormField(
                              controller: ownerAddress,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter City';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'assets/location.png',
                                    scale: 2.9,
                                  ),
                                  hintText: ' City',
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Nexa')),
                            ),
                            TextFormField(
                              controller: ownerGst,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter GST NO';
                              //   }
                              //   return null;
                              // },
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'assets/gst no.png',
                                    scale: 2.9,
                                  ),
                                  hintText: ' GST NO',
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Nexa')),
                            ),
                            TextFormField(
                              controller: ownerPhone,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              validator: (value) {
                                if (value == null || value.isEmpty || value.length!=10) {
                                  return 'Please enter valid Mobile Number';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'assets/number.png',
                                    scale: 2.9,
                                  ),
                                  hintText: ' Phone Number',
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Nexa')),
                            ),
                            TextFormField(
                              controller: ownerEmail,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Email Address';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'assets/mail.png',
                                    scale: 2.9,
                                  ),
                                  hintText: ' E-mail',
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Nexa')),
                            ),
                            TextFormField(
                              controller: ownerWebsite,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.emailAddress,
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter Company Address';
                              //   }
                              //   return null;
                              // },
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'assets/web.png',
                                    scale: 1.5,
                                  ),
                                  hintText: ' Website',
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Nexa')),
                            ),

                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          logData = await SharedPreferences.getInstance();
                          if (formKey.currentState!.validate()){
                            setState(() {
                              logData.setString('ownerName', ownerName.text);
                              logData.setString('ownerStreet', ownerStreet.text);
                              logData.setString('ownerAddress', ownerAddress.text);
                              logData.setString('ownerWebsite', ownerWebsite.text);
                              logData.setString('ownerEmail', ownerEmail.text);
                              logData.setString('ownerGst', ownerGst.text);
                              logData.setInt('ownerPhone', int.parse(ownerPhone.text));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UploadData()));
                            });
                          }
                        },
                        child: Container(
                          width: width * 0.28,
                          height: height * 0.05,
                          decoration: BoxDecoration(
                              color: const Color(0xffFF7E44),
                              borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(8,8),
                                  blurRadius: 10,
                                  spreadRadius: 0)
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.013,
                                  fontFamily: 'Nexa',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
