import 'package:flutter/material.dart';
import 'screens/Activity.dart';
import 'screens/Videos.dart';
import 'screens/homePage.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Navigate extends StatefulWidget {
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  PageController _myPage = PageController(initialPage: 0);
  int currentIndex = 0;
  bool isBarVisible = true;

  // final _pageOptions = [Home(), Books(), IssuedBooks(), Setting()];

  @override
  Widget build(BuildContext context) {
    // var childButtons = List<UnicornButton>();

    // childButtons.add(UnicornButton(
    //     hasLabel: true,
    //     labelText: "Football",
    //     currentButton: FloatingActionButton(
    //       heroTag: "Football",
    //       backgroundColor: Colors.redAccent,
    //       mini: true,
    //       child: Icon(Icons.sports_soccer),
    //       onPressed: () {},
    //     )));

    // childButtons.add(
    //   UnicornButton(
    //     hasLabel: true,
    //     labelText: "Cricket",
    //     currentButton: FloatingActionButton(
    //       heroTag: "Cricket",
    //       backgroundColor: Colors.yellow,
    //       mini: true,
    //       child: Icon(Icons.sports_cricket),
    //       onPressed: () {},
    //     ),
    //   ),
    // );

    // childButtons.add(
    //   UnicornButton(
    //     hasLabel: true,
    //     labelText: "Basketball",
    //     currentButton: FloatingActionButton(
    //       heroTag: "Basketball",
    //       backgroundColor: Colors.blueAccent,
    //       mini: true,
    //       child: Icon(Icons.sports_basketball),
    //       onPressed: () {},
    //     ),
    //   ),
    // );

    // childButtons.add(
    //   UnicornButton(
    //     hasLabel: true,
    //     labelText: "Volleyball",
    //     currentButton: FloatingActionButton(
    //       heroTag: "Volleyball",
    //       backgroundColor: Colors.greenAccent,
    //       mini: true,
    //       child: Icon(Icons.sports_volleyball),
    //       onPressed: () {},
    //     ),
    //   ),
    // );

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: isBarVisible
            ? BottomAppBar(
                elevation: 20,
                color: Color(0xCC0000FF),
                // shape: CircularNotchedRectangle(),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          topLeft: Radius.circular(5.0))),
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
                                currentIndex == 0 ? Colors.white : Colors.blue),
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
                          color: currentIndex == 1 ? Colors.white : Colors.blue,
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
                                currentIndex == 2 ? Colors.white : Colors.blue),
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
                                currentIndex == 3 ? Colors.white : Colors.blue),
                      )
                    ],
                  ),
                ),
              )
            : Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
              ),
        body: PageView(
          controller: _myPage,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: [HomePage(), Activity(), Videos()],
          // physics: NeverScrollableScrollPhysics(),
          physics: BouncingScrollPhysics(),
        ),
        floatingActionButton: FabCircularMenu(
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
                  icon: Icon(Icons.sports_volleyball),
                  onPressed: () {
                    print('Volleyball');
                  }),
              IconButton(
                  icon: Icon(Icons.sports_soccer),
                  onPressed: () {
                    print('Football');
                  }),
              IconButton(
                  icon: Icon(Icons.sports_cricket),
                  onPressed: () {
                    print('Cricket');
                  }),
              IconButton(
                  icon: Icon(Icons.sports_basketball),
                  onPressed: () {
                    print('Basketball');
                  }),
              IconButton(
                  icon: Icon(Icons.sports_tennis),
                  onPressed: () {
                    print('Badminton');
                  }),
            ]));
  }
}
