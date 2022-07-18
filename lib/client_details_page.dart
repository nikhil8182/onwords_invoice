import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onwords_invoice/product_list_page.dart';
import 'package:onwords_invoice/provider_page.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';


class ClientDetailsPage extends StatefulWidget {
  const ClientDetailsPage({Key? key}) : super(key: key);

  @override
  State<ClientDetailsPage> createState() => _ClientDetailsPageState();
}

class _ClientDetailsPageState extends State<ClientDetailsPage> {
  TextEditingController clientName = TextEditingController();
  TextEditingController clientStreet = TextEditingController();
  TextEditingController clientAddress = TextEditingController();
  TextEditingController clientCity = TextEditingController();
  TextEditingController clientCountry = TextEditingController();
  TextEditingController clientPin = TextEditingController();


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
                  decoration: InputDecoration(hintText: 'Customer name'),
                  controller: clientName,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Customer Street'),
                  controller: clientStreet,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Customer Address'),
                  controller: clientAddress,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Customer city'),
                  controller: clientCity,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Customer country'),
                  controller: clientCountry,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Customer pin'),
                  controller: clientPin,
                ),
              ),

              SizedBox(
                height: height*0.08,
              ),
              ElevatedButton(
                  onPressed: (){
                    Provider.of<TaskData>(context,listen: false).addTask(clientName.text,clientStreet.text,
                        clientAddress.text,clientCity.text,clientCountry.text,int.parse(clientPin.text));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProductListOutPage()));
                    },
                  child: Text(" Next ",style: TextStyle(fontSize: height*0.025),)),
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
