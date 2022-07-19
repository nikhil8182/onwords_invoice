import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:onwords_invoice/product_list_page.dart';
import 'package:onwords_invoice/provider_page.dart';
import 'package:provider/provider.dart';
// import 'dart:io';

// import 'package:shared_preferences/shared_preferences.dart';


class ClientDetailsPage extends StatefulWidget {
  const ClientDetailsPage({Key? key}) : super(key: key);

  @override
  State<ClientDetailsPage> createState() => _ClientDetailsPageState();
}

class _ClientDetailsPageState extends State<ClientDetailsPage> {
  TextEditingController clientName = TextEditingController();
  TextEditingController clientStreet = TextEditingController();
  TextEditingController clientAddress = TextEditingController();
  TextEditingController clientPhone = TextEditingController();
  final _formKey = GlobalKey<FormState>();


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
                        return 'Please enter Customer Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'Customer name'),
                    controller: clientName,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Address';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'Address'),
                    controller: clientStreet,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter City';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'City'),
                    controller: clientAddress,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                    if (value == null || value.isEmpty || value.length != 10) {
                      return 'Please enter valid Mobile Number';
                    }
                    return null;
                  },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(hintText: 'Phone Number'),
                    controller: clientPhone,
                  ),
                ),

                SizedBox(
                  height: height*0.08,
                ),
                ElevatedButton(
                    onPressed: (){
                        if (_formKey.currentState!.validate()) {
                          Provider.of<TaskData>(context,listen: false).addTask(clientName.text,clientStreet.text,
                              clientAddress.text,int.parse(clientPhone.text));
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProductListOutPage()));
                        }
                      },
                    child: Text(" Next ",style: TextStyle(fontSize: height*0.025),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // File? image;
  //
  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if(image == null) return;
  //     final imageTemp = File(image.path);
  //     print(imageTemp.toString());
  //     setState(() => this.image = imageTemp);
  //   } on PlatformException catch(e) {
  //     print('Failed to pick image: $e');
  //   }
  // }
}
