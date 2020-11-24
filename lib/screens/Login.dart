import 'package:flutter/material.dart';
import 'OTP.dart';
import 'package:yukti/data.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isSpin = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          // statusBarColor: Color(0xFF5200FF),
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.greenAccent[400],
          systemNavigationBarIconBrightness: Brightness.light),
    );
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: isSpin,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                      height: size.height / 3,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: size.width * 0.8,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFFB5A9FF),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x550000A0),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(5, 5))
                            ],
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                          'Yukti Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 10, top: 10),
                        margin: EdgeInsets.only(right: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: Colors.grey[200],
                        ),
                        child: Material(
                          elevation: 20.0,
                          shadowColor: Colors.grey[900],
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            showCursor: true,
                            style: TextStyle(fontSize: 20),
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Email', //var hintText
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 3.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Material(
                        color: Color(0xFFB5A9FF),
                        elevation: 20,
                        shadowColor: Colors.grey[900],
                        borderRadius: new BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            topLeft: Radius.circular(40)),
                        child: FlatButton(
                          onPressed: () async {
                            setState(() {
                              isSpin = true;
                            });
                            if (email != '') {
                              await login();
                              isSpin = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OTP(email, otp),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 40, right: 20),
                            child: Text(
                              'Request OTP',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                  SizedBox(height: 50), //var login
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
