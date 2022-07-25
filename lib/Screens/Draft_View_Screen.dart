import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Account_Screen.dart';

class DraftView extends StatefulWidget {
  const DraftView({Key? key}) : super(key: key);

  @override
  State<DraftView> createState() => _DraftViewState();
}

class _DraftViewState extends State<DraftView> {

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
            height: height * 0.78,
            margin: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date : 23.07.2022',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.012,
                        fontFamily: 'Nexa',
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width * 0.9,
                    height: height * 0.04,
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Table(
                      children: [
                        buildRow([
                          'Invoices',
                          'Qty',
                          'Amount',

                        ]),
                      ],
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    //  print("eeee in draft");
                    // _refreshJournals();
                  }, child: Text("get"))
                ],
              ),
            ),
          )


        ],
      ),
    );
  }
  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
    children: cells.map(
          (cell) {
        final style = TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        );
        return Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Text(
              cell,
              style: style,
            ),
          ),
        );
      },
    ).toList(),
  );
}
