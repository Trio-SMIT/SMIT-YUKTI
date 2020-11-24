import 'package:flutter/material.dart';
import 'Navigation.dart';
import 'screens/Login.dart';
import 'data.dart';
import 'package:yukti/screens/About.dart';
import 'package:yukti/screens/ChangeData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukti/components/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.get('email');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splash',
    // initialRoute: 'login',
    routes: {
      'login': (context) => Login(),
      'nav': (context) => Navigate(),
      'about': (context) => About(),
      'changeData': (context) => ChangeData(),
      'splash': (context) => Splash(),
    },
  ));
}
