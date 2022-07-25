import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Account_Screen.dart';
import 'Customer_Details_Screen.dart';
import 'Draft_View_Screen.dart';

class NewAndDraft extends StatefulWidget {
  const NewAndDraft({Key? key}) : super(key: key);

  @override
  State<NewAndDraft> createState() => _NewAndDraftState();
}

class _NewAndDraftState extends State<NewAndDraft> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:    Text(
          "Company Name",
          style: TextStyle(
              fontFamily: 'Nexa',
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: height * 0.018),
        ),
        centerTitle: true,
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
        actions: [
          GestureDetector(
            child: Icon(
              Icons.account_circle_outlined,
              color: Colors.deepOrangeAccent,
              size: height * 0.03,
            ),
            onTap: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountScreen()));
              });
            },
          ),
          SizedBox(width: width*0.05,)

        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [

          Container(
            margin: EdgeInsets.all(height * 0.05),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DraftView()));
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.all(20),
                      height: height * 0.12,
                      decoration: BoxDecoration(
                          color: Color(0xffF7F9FC),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(5, 5),
                                blurRadius: 10,
                                spreadRadius: 0)
                          ]),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/edit.png',
                              scale: 2.6,
                            ),
                            Text('Draft',style: TextStyle(
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
                SizedBox(
                  height: height * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerDetails()));
                    });
                  },
                  child: Container(

                    padding: EdgeInsets.all(20),
                    height: height * 0.12,
                    decoration: BoxDecoration(
                        color: Color(0xffF7F9FC),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(5, 5),
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
              ],
            ),
          ),

        ],
      ),
    );
  }
}
