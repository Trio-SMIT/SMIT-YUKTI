import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  String showSteps = '';
  String _km = "Unknown";
  String _calories = "Unknown";

  String _stepCountValue = 'Unknown';

  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;

  String _status = '', _steps = '0';

  double _numberx;
  double _convert;
  double _kmx;
  double burnedx;

  @override
  void initState() {
    setUpPedometer();
    super.initState();
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

  void setUpPedometer() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    if (!mounted) return;
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void onStepCount(StepCount stepCountValue) {
    try {
      print(stepCountValue);
      setState(() {
        _steps = stepCountValue.steps.toString();
      });

      setState(() {
        _stepCountValue = "${stepCountValue.steps}";
      });

      var dist = stepCountValue.steps;
      double y = (dist + .0);

      setState(() {
        _numberx = y;
      });

      var long3 = (_numberx);
      long3 = num.parse(y.toStringAsFixed(2));
      var long4 = (long3 / 10000);

      int decimals = 1;
      int fac = pow(10, decimals);
      double d = long4;
      d = (d * fac).round() / fac;
      print("d: $d");

      getDistanceRun(_numberx);

      setState(() {
        _convert = d;
        print(_convert);
      });
    } catch (e) {
      print(e);
    }
  }

  //function to determine the distance run in kilometers using number of steps
  void getDistanceRun(double _numerox) {
    var distance = ((_numerox * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2)); //dos decimales
    var distancekmx = distance * 34;
    distancekmx = num.parse(distancekmx.toStringAsFixed(2));
    //print(distance.runtimeType);
    setState(() {
      _km = "$distance";
      //print(_km);
    });
    setState(() {
      _kmx = num.parse(distancekmx.toStringAsFixed(2));
    });
  }

  //function to determine the calories burned in kilometers using number of steps
  void getBurnedRun() {
    setState(() {
      var calories = _kmx; //dos decimales
      _calories = "$calories";
      //print(_calories);
    });
  }

  Container returnStatus() {
    return Container(
      child: _status == 'walking'
          ? Image.asset('assets/images/running.gif')
          : Image.asset('assets/images/standing.gif'),
    );
  }

  @override
  Widget build(BuildContext context) {
    getBurnedRun();
    //print(_stepCountValue);
    return SafeArea(
      child: Scaffold(
          body: _status == ''
              ? ListView(
                  padding: EdgeInsets.all(5.0),
                  children: <Widget>[
                    SizedBox(
                      height: 25,
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
                        'Activity',
                        style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      width: 250, //ancho
                      height: 250, //largo tambien por numero height: 300
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment
                                .bottomCenter, //cambia la iluminacion del degradado
                            end: Alignment.topCenter,
                            colors: [Color(0xFFA9F5F2), Color(0xFF01DFD7)],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(27.0),
                            bottomRight: Radius.circular(27.0),
                            topLeft: Radius.circular(27.0),
                            topRight: Radius.circular(27.0),
                          )),
                      child: CircularPercentIndicator(
                        radius: 200.0,
                        lineWidth: 13.0,
                        animation: true,
                        center: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 50,
                                width: 50,
                                padding: EdgeInsets.only(left: 20.0),
                                child: Icon(
                                  FontAwesomeIcons.walking,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                //color: Colors.orange,
                                child: Text(
                                  // '$_stepCountValue',
                                  '$_steps / 10000',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.purpleAccent),
                                ),
                                // height: 50.0,
                                // width: 50.0,
                              ),
                            ],
                          ),
                        ),
                        percent: int.parse(_steps) / 10000,
                        //percent: _convert,
                        footer: Text(
                          "Steps:  $_stepCountValue",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.purple),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.purpleAccent,
                      ),
                    ),
                    Divider(
                      height: 5.0,
                    ),
                    Container(
                      width: 80,
                      height: 100,
                      padding:
                          EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Card(
                              child: Container(
                                height: 80.0,
                                width: 80.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/distance.png"),
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                                child: Text(
                                  "$_km Km",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(
                            width: 20.0,
                          ),
                          Container(
                            child: Card(
                              child: Container(
                                height: 80.0,
                                width: 80.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/burned.png"),
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(
                            width: 20.0,
                          ),
                          Container(
                            child: Card(
                              child: Container(
                                height: 80.0,
                                width: 80.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/step.png"),
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 2.0),
                      width: 150,
                      height: 30,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Card(
                              child: Container(
                                child: Text(
                                  "$_km Km",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      color: Colors.white),
                                ),
                              ),
                              color: Colors.purple,
                            ),
                          ),
                          VerticalDivider(
                            width: 20.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Card(
                              child: Container(
                                child: Text(
                                  "$_calories kCal",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      color: Colors.white),
                                ),
                              ),
                              color: Colors.red,
                            ),
                          ),
                          VerticalDivider(
                            width: 5.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Card(
                              child: Container(
                                child: Text(
                                  "$_stepCountValue Steps",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      color: Colors.white),
                                ),
                              ),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    returnStatus(),
                  ],
                )
              : Center(child: CircularProgressIndicator())),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class Activity extends StatefulWidget {
//   @override
//   _ActivityState createState() => _ActivityState();
// }

// class _ActivityState extends State<Activity> {
//   @override
//   Widget build(BuildContext context) {
//     final List<Color> color = <Color>[];
//     color.add(Colors.blue[50]);
//     color.add(Colors.blue[200]);
//     color.add(Colors.blue);

//     final List<double> stops = <double>[];
//     stops.add(0.0);
//     stops.add(0.5);
//     stops.add(1.0);

//     final LinearGradient gradientColors =
//         LinearGradient(colors: color, stops: stops);
//     final List<SalesData> chartData = [
//       SalesData(2010, 35),
//       SalesData(2011, 28),
//       SalesData(2012, 34),
//       SalesData(2013, 32),
//       SalesData(2014, 40)
//     ];

//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           child: Column(
//             children: [
//               SfCartesianChart(series: <ChartSeries>[
//                 // Renders area chart
//                 AreaSeries<SalesData, double>(
//                     dataSource: chartData,
//                     xValueMapper: (SalesData sales, _) => sales.year,
//                     yValueMapper: (SalesData sales, _) => sales.sales,
//                     gradient: gradientColors)
//               ]),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SalesData {
//   SalesData(this.year, this.sales);
//   final double year;
//   final double sales;
// }
