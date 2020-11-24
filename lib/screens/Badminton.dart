import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:yukti/data.dart';
import 'package:flip_card/flip_card.dart';

class Badminton extends StatefulWidget {
  @override
  _BadmintonState createState() => _BadmintonState();
}

class _BadmintonState extends State<Badminton> {
// Start
  Future buildCards() async {
    List<Widget> listOfEvents = [];
    String url = '${eventUrl}badminton';
    var data;
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: json.encode({}));
      if (response.statusCode != 200) {
        print('Error');
      } else {
        data = jsonDecode(response.body);
        print(data);
      }
      if (data != null) {
        print('This is Inside if');
        for (int i = 0; i < data.length; i++) {
          listOfEvents.add(
            FlipCard(
              direction: FlipDirection.HORIZONTAL,
              front: Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                color: Color(0xCC0000FF),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    ListTile(
                      leading: Text(
                        '${data[i]["title"]}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        '${data[i]["date"]}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Text(
                      'Tap for more info',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              back: Center(
                child: Container(
                  height: 50,
                  color: Color(0xCC0000FF),
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: ListTile(
                      leading: Text(
                        'Details : ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        '${data[i]["description"]}',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )),
                ),
              ),
            ),
          );
        }
      }
      if (listOfEvents.length == 0) {
        print('This is Else');
        listOfEvents.add(
          Card(
            margin: EdgeInsets.all(10.0),
            elevation: 10.0,
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              leading: Text(
                "There Are No Events",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
      print('This is catch');
    }
    print(listOfEvents.length);
    return listOfEvents;
  }

// End

  bool isSpin;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(children: [
            SizedBox(
              height: 25.0,
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0x550000FF),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                      offset: Offset(2, 2))
                ],
              ),
              child: Text(
                'Badminton',
                style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: FutureBuilder(
                future: buildCards(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children: snapshot.data,
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
