import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onwords_invoice/client_details_page.dart';
import 'package:onwords_invoice/product_list_page.dart';
import 'package:onwords_invoice/provider_page.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';


class OwnerDetailsPage extends StatefulWidget {
  const OwnerDetailsPage({Key? key}) : super(key: key);

  @override
  State<OwnerDetailsPage> createState() => _OwnerDetailsPageState();
}

class _OwnerDetailsPageState extends State<OwnerDetailsPage> {
  TextEditingController ownerName = TextEditingController();
  TextEditingController ownerStreet = TextEditingController();
  TextEditingController ownerAddress = TextEditingController();
  TextEditingController ownerPhone = TextEditingController();
  TextEditingController ownerEmail = TextEditingController();
  TextEditingController ownerWebsite = TextEditingController();
  late SharedPreferences logData;
  final _formKey = GlobalKey<FormState>();




  // @override
  // Future<void> initState() async {
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          width: width*1.0,
          height: height*1.0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height*0.08,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Company Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'Company name'),
                    controller: ownerName,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Company Address';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'Company Address'),
                    controller: ownerStreet,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter City & State';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'City & State'),
                    controller: ownerAddress,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length!=10) {
                        return 'Please enter valid Mobile Number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(hintText: 'Phone Number'),
                    controller: ownerPhone,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Email'),
                    controller: ownerEmail,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Website';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Website'),
                    controller: ownerWebsite,
                  ),
                ),
                SizedBox(
                  height: height*0.08,
                ),
                ElevatedButton(
                    onPressed: () async {
                      logData = await SharedPreferences.getInstance();
                      await logData.clear();
                        if (_formKey.currentState!.validate()){
                          setState((){
                            logData.setBool('login', true);
                            logData.setString('ownerName', ownerName.text);
                            logData.setString('ownerStreet', ownerStreet.text);
                            logData.setString('ownerAddress', ownerAddress.text);
                            logData.setString('ownerWebsite', ownerWebsite.text);
                            logData.setString('ownerEmail', ownerEmail.text);
                            logData.setInt('ownerPhone', int.parse(ownerPhone.text));
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const ClientDetailsPage()));
                          });

                        }
                      // Provider.of<TaskData>(context,listen: false).addOwnerData(
                      //     ownerName.text, ownerStreet.text,
                      //     ownerAddress.text, ownerCity.text, ownerCountry.text);

                    },
                    child: Text(" Next ",style: TextStyle(fontSize: height*0.025),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      print(imageTemp.toString());
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }
}
