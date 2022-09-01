import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:onwords_invoice/Screens/Customer_Details_Screen.dart';
import 'package:onwords_invoice/Screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';




class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);


  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> with TickerProviderStateMixin{
  bool isLoggedIn = false;
  late AnimationController _controller;
  late SharedPreferences logData;

  readData()async {
    logData = await SharedPreferences.getInstance();
    setState((){
     isLoggedIn = logData.getBool('login')??false;
    });
  }
//
  @override
  void initState() {
    readData();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    super.initState();
  }

  _navigateUser() {
    if(isLoggedIn) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const CustomerDetails()));
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => const LoginScreenPage()));
    }else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreenPage()));
    }

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:  Colors.white,
      // backgroundColor:  Theme.of(context).backgroundColor,
      body: Container(
        height: height*1.0,
        width: width*1.0,
        child: Center(
          child: Lottie.asset(
            'images/Comp 1.json',
            controller: _controller,
            height: MediaQuery.of(context).size.height * 1.0,
            width: width*1.0,
            animate: true,
            onLoaded: (composition) {
              _controller..duration = composition.duration..forward().whenComplete((){
                _navigateUser();
              });
            },
          ),
        ),
      ),
    );
  }
}