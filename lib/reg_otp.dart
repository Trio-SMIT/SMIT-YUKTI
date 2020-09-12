import 'package:flutter/material.dart';

class Reg_OTP extends StatelessWidget {
  Reg_OTP(this.hintText, this.namedRoute, this.login,this.text1,this.text2,this.buttonText,this.linkRoute1);
  final hintText;
  final namedRoute;
  final login;
  final text1;
  final text2;
  final buttonText;
  final linkRoute1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(text1,
                    style: TextStyle(color: Colors.blueAccent,fontSize: 18)),
              ),
              Container(
                  child: Text(
                text2,
                style: TextStyle(color: Colors.blueAccent,fontSize: 18),
              ))
            ],
          ),
          SizedBox(height:40),
          Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.only(right: 10, top: 10),
                margin: EdgeInsets.only(right: 50),
                child: Material(
                  elevation: 20.0,
                  shadowColor: Colors.grey[900],
                  child: TextFormField(
                    showCursor: true,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      hintText: hintText, //var hintText
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.white, width: 3.0),
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
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, namedRoute);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 40, right: 20),
                    child: Text(
                      buttonText,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          )),
          SizedBox(height: 50), //var login
          FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, linkRoute1);
              },
              child: Text(
                login,
                style: TextStyle(fontSize: 18, color: Colors.blueAccent),
              ))
        ],
      )),
    );
  }
}
