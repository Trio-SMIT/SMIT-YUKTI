import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukti/data.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';

DateTime currentBackPressTime;

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSpin = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        // statusBarColor: Color(0xFF5200FF),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.greenAccent,
        systemNavigationBarIconBrightness: Brightness.light));
    print('Setting');
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(msg: 'tap back again to exit');
          return Future.value(false);
        }
        exit(0);
      },
      child: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isSpin,
          child: Scaffold(
            body: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Color(0xFF00FF00), //Color(0xFF2200FF),
                  elevation: 10.0,
                  child: Container(
                    // height: 400,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Center(
                          child: Text(
                            'Settings',
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF)),
                          ),
                        ),
                        Divider(
                          color: Color(0xAA55F2FF),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          // height: 180,
                          padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blueGrey,
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                      )
                                    ]),
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundImage: NetworkImage(userLogoUrl),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 20),
                                margin: EdgeInsets.all(5),
                                // padding: EdgeInsets.only(top: 40),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$name',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // Text(
                                    //   '$name',
                                    //   style: TextStyle(
                                    //       fontSize: 20,
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.white),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Expanded(
                        //   child: SizedBox(),
                        // ),
                      ],
                    ),
                  ),
                ),

                //),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Button('Change your Data', 'changeData'),
                        Button('About', 'about'),
                        Button('Log Out', 'login'),
                        // Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  Button(this.text, this.routeName);
  final routeName;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      elevation: 10.0,
      child: Container(
        height: 80.0,
        padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            FloatingActionButton(
              backgroundColor: Color(0xFF00FF00),
              heroTag: null,
              mini: true,
              elevation: 15,
              onPressed: () async {
                if (text == 'Log Out') {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('email', '');
                }
                Navigator.pushNamed(context, routeName);
              },
              child: Icon(
                Icons.arrow_forward,
                color: Colors.grey[900],
                size: 20,
              ),
            ),
            SizedBox(width: 20)
          ],
        ),
      ),
    );
  }
}
