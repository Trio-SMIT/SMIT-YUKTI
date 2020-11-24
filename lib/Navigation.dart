import 'package:flutter/material.dart';
import 'screens/Activity.dart';
import 'screens/Videos.dart';
import 'screens/HomePage.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'screens/Badminton.dart';
import 'screens/Basketball.dart';
import 'screens/Cricket.dart';
import 'screens/Football.dart';
import 'screens/Volleyball.dart';
import 'package:yukti/screens/Settings.dart';

class Navigate extends StatefulWidget {
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  PageController _myPage = PageController(initialPage: 0);
  int currentIndex = 0;
  bool isBarVisible = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: isBarVisible
          ? BottomAppBar(
              elevation: 20,
              color: Color(0xCC00FF00),
              // shape: CircularNotchedRectangle(),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0))),
                height: 50,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _myPage.jumpToPage(0);
                          currentIndex = 0;
                          print(currentIndex);
                        });
                      },
                      iconSize: currentIndex == 0 ? 35 : 25.0,
                      padding: EdgeInsets.only(left: 20.0, right: 10),
                      icon: Icon(FlutterIcons.home_ant,
                          color:
                              currentIndex == 0 ? Colors.white : Colors.green),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _myPage.jumpToPage(1);
                          currentIndex = 1;
                          print(currentIndex);
                        });
                      },
                      iconSize: currentIndex == 1 ? 35 : 25.0,
                      padding: EdgeInsets.only(right: 20.0, left: 10),
                      icon: Icon(
                        Icons.directions_run_outlined,
                        color: currentIndex == 1 ? Colors.white : Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _myPage.jumpToPage(2);
                          currentIndex = 2;
                          print(currentIndex);
                        });
                      },
                      iconSize: currentIndex == 2 ? 35 : 25.0,
                      padding: EdgeInsets.only(left: 20.0, right: 10),
                      icon: Icon(Icons.video_collection,
                          color:
                              currentIndex == 2 ? Colors.white : Colors.green),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _myPage.jumpToPage(3);
                          currentIndex = 3;
                          print(currentIndex);
                        });
                      },
                      iconSize: currentIndex == 3 ? 35 : 25.0,
                      padding: EdgeInsets.only(right: 20.0, left: 10),
                      icon: Icon(Icons.settings,
                          color:
                              currentIndex == 3 ? Colors.white : Colors.green),
                    )
                  ],
                ),
              ),
            )
          : Container(
              color: Colors.white,
              height: 1,
            ),
      body: PageView(
        controller: _myPage,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [HomePage(), Activity(), Videos(), Settings()],
        // physics: NeverScrollableScrollPhysics(),
        physics: BouncingScrollPhysics(),
      ),
      floatingActionButton: FabCircularMenu(
        fabColor: Color(0xFF7cfc00),
        ringColor: Color(0xFF00FF00),
        ringDiameter: 350,
        ringWidth: 80.0,
        fabOpenIcon: Icon(Icons.event),
        alignment: Alignment.bottomCenter,
        onDisplayChange: (change) {
          setState(() {
            isBarVisible = !isBarVisible;
          });
        },
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.sports_volleyball,
                color: Colors.yellowAccent,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Volleyball()));
                print('Volleyball');
              }),
          IconButton(
              icon: Icon(Icons.sports_soccer,
                  color: Colors.lightGreenAccent, size: 35),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Football()));
                print('Football');
              }),
          IconButton(
              icon:
                  Icon(Icons.sports_cricket, color: Colors.redAccent, size: 35),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Cricket()));
                print('Cricket');
              }),
          IconButton(
              icon: Icon(Icons.sports_basketball,
                  color: Colors.lightBlueAccent, size: 35),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Basketball()));
                print('Basketball');
              }),
          IconButton(
              icon: Icon(Icons.sports_tennis,
                  color: Colors.orangeAccent, size: 35),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Badminton()));
                print('Badminton');
              }),
        ],
      ),
    );
  }
}
