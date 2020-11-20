import 'package:flutter/material.dart';
import 'package:yukti/data.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';

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

  @override
  Widget build(BuildContext context) {
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
