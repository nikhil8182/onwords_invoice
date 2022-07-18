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
  TextEditingController ownerCity = TextEditingController();
  TextEditingController ownerCountry = TextEditingController();
  TextEditingController ownerPin = TextEditingController();
  late SharedPreferences logData;





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
      body: Container(
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
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Supplier name'),
                  controller: ownerName,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Supplier Street'),
                  controller: ownerStreet,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Supplier Address'),
                  controller: ownerAddress,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Supplier City'),
                  controller: ownerCity,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Supplier Country'),
                  controller: ownerCountry,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Supplier pin'),
                  controller: ownerPin,
                ),
              ),
              SizedBox(
                height: height*0.08,
              ),
              ElevatedButton(
                  onPressed: () async {
                    logData = await SharedPreferences.getInstance();
                    // Provider.of<TaskData>(context,listen: false).addOwnerData(
                    //     ownerName.text, ownerStreet.text,
                    //     ownerAddress.text, ownerCity.text, ownerCountry.text);
                    print("hello");
                    setState((){
                      logData.setString('ownerName', ownerName.text);
                      logData.setString('ownerStreet', ownerStreet.text);
                      logData.setString('ownerAddress', ownerAddress.text);
                      logData.setString('ownerCity', ownerCity.text);
                      logData.setString('ownerCountry', ownerCountry.text);
                      logData.setInt('ownerPin', int.parse(ownerPin.text));

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ClientDetailsPage()));
                    });

                  },
                  child: Text(" Next ",style: TextStyle(fontSize: height*0.025),)),
              // ElevatedButton(
              //     onPressed: (){
              //       pickImage();
              //     },
              //     child: Text(" select ",style: TextStyle(fontSize: height*0.025),)),
              // image != null? Container(
              //   height: height*0.20,
              //   width: width*0.20,
              //   child: Image.file(
              //     image!,
              //     fit: BoxFit.cover,
              //   ),
              // ):Container(),
            ],
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
