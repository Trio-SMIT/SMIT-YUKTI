import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukti/data.dart';
import 'package:flutter/services.dart';
// import 'About.dart';
// import 'change_pass.dart';
import 'package:libm/main.dart';
import 'package:libm/screens/ConnectionError.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

DateTime currentBackPressTime;
// String name;
// String gender;
// int regi;
// Map data;

int picIndex = gender == 'male' ? 1 : 'female';

// Future fetch() async {
//   if (regNo == null) {
//     WidgetsFlutterBinding.ensureInitialized();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     regi = prefs.getInt('regno');
//   } else {
//     regi = regNo;
//   }
//   String url =
//       "http://hiddennet.languagenectar.com/database/libms/details.php?username=$regi";
//   var response = await http.get(url);
//   if (response.statusCode == 200) {
//     print("_Reg : $regi");
//     print("Reg : $regNo");
//     data = json.decode(response.body);
//     name = data["name"];
//     gender = data["gender"];
//     print(data);
//     if (gender == "male") {
//       picIndex = 1;
//     } else {
//       picIndex = 2;
//     }
//   }
// }

class Setting extends StatefulWidget {
  // Setting() {
  //   fetch();
  // }
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  // Check Connection
  Future<void> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!(connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ConnectionError()));
    }
  }

  @override
  void initState() {
    checkConnection();
    super.initState();
  }

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
        systemNavigationBarColor: Color(0xCC0000FF),
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
        return false;
      },
      child: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isSpin,
          child: Scaffold(
            body: Column(
              children: <Widget>[
                FadeAnimation(
                  0.4,
                  Card(
                    color: Color(0xFF2200FF),
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
                                    backgroundImage:
                                        AssetImage('images/pic$picIndex.jpg'),
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
                                        name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '$regNo',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
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
                ),
                //),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Button('Change Password', 'change_password'),
                        Button('About', 'about'),
                        FadeAnimation(
                          0.4,
                          Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            elevation: 10,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                              height: 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'Clear eBook History',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 35,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          isSpin = true;
                                        });
                                        try {
                                          await checkConnection();
                                          var response = await http.post(
                                            'https://smit-libms-server.herokuapp.com/e_books/clearHistory/individual/all',
                                            headers: {
                                              "Content-Type": "application/json"
                                            },
                                            body:
                                                json.encode({'reg_no': regNo}),
                                          );
                                          print(response.body);
                                          Fluttertoast.showToast(
                                              msg: 'History Cleared');
                                        } catch (e) {
                                          Fluttertoast.showToast(
                                              msg: 'An Error Occured');
                                          print(e);
                                        }
                                        setState(() {
                                          isSpin = false;
                                        });
                                      }),
                                  SizedBox(width: 20)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Button('Log Out', 'log_out'),
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
    return FadeAnimation(
      0.4,
      Card(
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
                heroTag: null,
                mini: true,
                elevation: 15,
                onPressed: () async {
                  if (text == 'Log Out') {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setInt('regno', null);
                    prefs.setString('name', null);
                    prefs.setString('gender', null);
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
      ),
    );
  }
}
