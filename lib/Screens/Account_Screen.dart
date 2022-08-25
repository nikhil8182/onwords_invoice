import 'package:flutter/material.dart';
import 'package:onwords_invoice/Screens/Customer_Details_Screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../image_saving/user.dart';
import '../image_saving/user_preference.dart';
import '../provider_page.dart';
import 'intro_Screen.dart';
import 'dart:io';


class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();
  late SharedPreferences logData;

  readData() async {
    logData = await SharedPreferences.getInstance();
    setState((){
      name.text = logData.getString('ownerName')!;
      email.text = logData.getString('ownerEmail')!;
      var phone = logData.getInt('ownerPhone')!;
      number.text = phone.toString();
    });
  }
  late User user;



  @override
  void initState() {
    readData();
    user = UserPreferences.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final image = user.imagePath.contains('images/blank.png') ? AssetImage(user.imagePath) : FileImage(File(user.imagePath));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:   GestureDetector(
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
        title:   Text(
          "My Account",
          style: TextStyle(
              fontFamily: 'Nexa',
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: height * 0.015),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                logData.setBool('login', false);
                logData.clear();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const IntroScreen()));
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              width: width * 0.2,
              height: height * 0.05,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Logout",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.015,
                        fontFamily: 'Nexa',
                        color: Colors.black),
                  ),
                  Image.asset('assets/sign-out.png',scale: 2.8,)
                ],
              ),
            ),
          )
        ],

      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 0.09),
                height: height * 0.7,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: Ink.image(
                          image: image as ImageProvider,
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.08,),
                      height: height * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
                            controller: name,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'Enter value';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.deepOrangeAccent,
                                  size: height * 0.023,
                                ),
                                // suffixIcon: IconButton(
                                //   onPressed: () => number.clear(),
                                //   icon: Image.asset('assets/etit1.png',scale: 2.5,),
                                // ),
                                hintText: 'Name',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Nexa')),
                          ),
                          TextFormField(
                            controller: number,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'Enter value';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                prefixIcon: Image.asset(
                                  'assets/number.png',
                                  scale: 2.5,
                                ),
                                // suffixIcon: IconButton(
                                //   onPressed: () => number.clear(),
                                //   icon: Image.asset('assets/etit1.png',scale: 2.5,),
                                // ),
                                hintText: 'Phone Number',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Nexa')),
                          ),
                          TextFormField(
                            controller: email,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'Enter value';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                prefixIcon: Image.asset(
                                  'assets/mail.png',
                                  scale: 2.5,
                                ),
                                // suffixIcon: IconButton(
                                //   onPressed: () => number.clear(),
                                //   icon: Image.asset('assets/etit1.png',scale: 2.5,),
                                // ),
                                hintText: 'E mail',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Nexa')),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const CustomerDetails()));
                      Provider.of<TaskData>(context,listen: false).invoiceListData.clear();
                      Provider.of<TaskData>(context,listen: false).subTotalValue.clear();
                    }, child: const Text("Generate new Pdf "))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
