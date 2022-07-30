import 'package:flutter/material.dart';
import 'package:onwords_invoice/Screens/splash_screen.dart';
import 'package:onwords_invoice/image_saving/user_preference.dart';
import 'package:onwords_invoice/provider_page.dart';
import 'package:provider/provider.dart';

import 'Screens/intro_Screen.dart';




//app completed 30.07.2022


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // home:  IntroScreen(),
        home:  SplashScreenPage(),
      ),
    );
  }
}


