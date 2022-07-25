import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Company_Details_Screen.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        body: Stack(
          children: [
            Positioned(
              top: height * -0.05,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Image.asset(
                    'assets/invoice-home.png',
                    scale: 2.2,
                  ),
                ],
              ),
            ),
            Positioned(
                top: height * 0.45,
                right: 0,
                left: 0,
                child: Container(
                  height: height * 0.8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.11,
                      ),
                      Text(
                        'Manage your daily Invoices Here!',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: height * 0.02,
                          fontFamily: 'Nexa'
                        ),
                      ),
                      SizedBox(
                        height: height * 0.11,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CompanyDetails()));
                          });
                        },
                        child: Container(
                          width: width * 0.28,
                          height: height * 0.05,
                          decoration: BoxDecoration(
                              color: Color(0xffFF7E44),
                              borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: Offset(8,8),
                                  blurRadius: 10,
                                  spreadRadius: 0)
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Get Start",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.013,
                                fontFamily: 'Nexa',
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}
