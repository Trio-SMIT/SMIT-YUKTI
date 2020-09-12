import 'package:flutter/material.dart';

class Pass_Acc extends StatelessWidget {
  Pass_Acc(this.hintText1, this.hintText2, this.buttonText,
      this.linkDescription1, this.linkDescription2, this.namedRoute,this.linkRoute1,this.linkRoute2);
  final hintText1;
  final hintText2;
  final buttonText;
  final namedRoute;
  final linkDescription1;
  final linkDescription2;
  final linkRoute1;
  final linkRoute2;
  @override
  Widget build(BuildContext context) {
    print(hintText1);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height:30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  color: Colors.grey[100],
                  padding: EdgeInsets.only(right: 10, top: 10),
                  margin: EdgeInsets.only(right: 50),
                  child: Material(
                    elevation: 20.0,
                    shadowColor: Colors.grey[900],
                    child: TextFormField(
                      showCursor: true,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        hintText: hintText1, //var hintText
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.white, width: 3.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                        hintText: hintText2, //var hintText
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
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
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 50), //var login
        FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, linkRoute1);
            },
            child: Text(
              linkDescription1,
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            )),
        FlatButton(
            onPressed: () {Navigator.pushNamed(context, linkRoute2);},
            child: Text(
              linkDescription2,
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            ))
      ],
    ));
  }
}
