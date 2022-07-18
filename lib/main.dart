import 'package:flutter/material.dart';
import 'package:onwords_invoice/client_details_page.dart';
import 'package:onwords_invoice/pdf_page.dart';
import 'package:onwords_invoice/provider_page.dart';
import 'package:provider/provider.dart';

import 'owner_details_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: PdfPage(),
        // home: ClientDetailsPage(),
        home: OwnerDetailsPage(),
      ),
    );
  }
}


