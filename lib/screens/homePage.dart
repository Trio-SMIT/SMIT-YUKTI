import 'package:flutter/material.dart';
import 'package:yukti/data.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getUserData();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  Future getLatestUpdates() async {
    List<Widget> listOfEvents = [];
    String url = '${eventUrl}all';
    var data;
    try {
      var response = await http.get(url);
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
              front: Card(
                color: Color(0xFF0000FF),
                elevation: 10,
                margin: EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
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
              back: Card(
                color: Color(0xFF0000FF),
                elevation: 10,
                margin: EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
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
          );
        }
      }
      if (listOfEvents.length == 0) {
        print('This is Else');
        listOfEvents.add(
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.all(10.0),
            elevation: 10.0,
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              title: Text(
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

  Future getUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email = prefs.getString('email');
      print('email : ' + email);
      var response = await http.post(
        userDataUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          name = data["name"];
          age = data["age"];
          weight = data["weight"];
        });
        print(name);
        print(age);
        print(weight);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        // statusBarColor: Color(0xFF5200FF),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.greenAccent,
        systemNavigationBarIconBrightness: Brightness.light));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
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
                          backgroundImage:
                              AssetImage('assets/images/userLogo.gif')),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: size.width * 0.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$name',
                              style: TextStyle(
                                  color: Color(0xFF5333FF),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '$age years',
                              style: TextStyle(
                                  color: Color(0xFF5333FF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '$weight Kgs',
                              style: TextStyle(
                                  color: Color(0xFF5333FF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.0),
                            // Text(
                            //   "Rank : #$rank",
                            //   style: TextStyle(
                            //       color: Color(0xFF5333FF),
                            //       fontSize: 25,
                            //       fontWeight: FontWeight.bold),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.lightBlueAccent,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Color(0xFFBE7FEF),
                  elevation: 10.0,
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image(
                          height: 100,
                          image: NetworkImage(fitnessUrl),
                        ),
                        Row(
                          children: [
                            Text(
                              "Today's Steps : ",
                              style: TextStyle(
                                  color: Color(0xFF5333FF),
                                  fontSize: 25,
                                  fontFamily: 'Caveat',
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "$_steps",
                              style: TextStyle(
                                  color: Color(0xFFE3AAFF),
                                  fontSize: 25,
                                  fontFamily: 'Caveat',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                FutureBuilder(
                    future: getLatestUpdates(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data != null) {
                        return Column(
                          children: snapshot.data,
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
