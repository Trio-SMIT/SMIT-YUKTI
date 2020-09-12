import 'package:flutter/material.dart';
import 'package:yukti/data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey[200],
                              spreadRadius: 5.0,
                              blurRadius: 10.0),
                        ]),
                    child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                            'https://www.nj.com/resizer/zovGSasCaR41h_yUGYHXbVTQW2A=/1280x0/smart/cloudfront-us-east-1.images.arcpublishing.com/advancelocal/SJGKVE5UNVESVCW7BBOHKQCZVE.jpg')),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              color: Color(0xFF5333FF),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Rank : #$rank",
                          style: TextStyle(
                              color: Color(0xFF5333FF),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.lightBlueAccent,
              ),
              Card(
                color: Color(0xFFBE7FEF),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Image(
                        height: 100,
                        image: NetworkImage(
                            'https://www.pinclipart.com/picdir/big/59-596765_regular-exercise-is-necessary-for-physical-fitness-vector.png'),
                      ),
                      Text(
                        "Fitness Score",
                        style: TextStyle(
                            color: Color(0xFF5333FF),
                            fontSize: 25,
                            fontFamily: 'Caveat',
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
