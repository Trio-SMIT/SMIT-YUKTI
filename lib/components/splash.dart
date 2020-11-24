import 'package:flutter/material.dart';
import 'dart:async';
import 'package:yukti/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.get('email');
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(email.isEmpty ? 'login' : 'nav');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset('assets/images/AppIcon.png'),
      ),
    );
  }
}
