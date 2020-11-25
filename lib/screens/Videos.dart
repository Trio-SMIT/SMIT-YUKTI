import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yukti/VideoPlay.dart';
import 'package:yukti/data.dart';

class Videos extends StatefulWidget {
  Videos({Key key}) : super(key: key);

  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  Size _size;
  List _links;
  List<Card> listOfVideo = [];
  Future getLinks() async {
    // list of title author and video link will be fetched
    String url = "$videoUrl";
    var response = await http.get(url);
    _links = json.decode(response.body);
    var videoLink;
    if (_links != null) {
      print('This is Inside if');
      for (int i = 0; i < _links.length; i++) {
        videoLink = _links[i]["video_link"];
        listOfVideo.add(
          Card(
            margin: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            color: Colors.greenAccent[100],
            elevation: 20.0,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YoutubePlayerApp(
                              _links[i]["video_link"],
                              _links[i]["title"],
                              _links[i]["creater"]),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 1),
                        Stack(
                          children: [
                            Container(
                              color: Colors.black,
                              child: SizedBox(
                                height: 120,
                                width: 160,
                                child: Image.network(
                                    'https://img.youtube.com/vi/${_links[i]["video_link"]}/0.jpg'),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              child: Text(
                                '${_links[i]["duration"]}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Expanded(flex: 1, child: SizedBox()),
                        Container(
                            child: Column(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                width: _size.width * 0.5,
                                margin: EdgeInsets.all(5),
                                child: Text(
                                  '${_links[i]["title"]}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800),
                                )), //${_links[i]["creater"]}
                            Container(
                                width: _size.width * 0.5,
                                margin: EdgeInsets.all(2),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${_links[i]["creater"]}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.brown),
                                )),
                            //views
                          ],
                        )),
                        Expanded(
                          flex: 3,
                          child: SizedBox(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    }
    if (listOfVideo.length == 0) {
      print('This is Else');
      listOfVideo.add(
        Card(
          margin: EdgeInsets.all(10.0),
          elevation: 10.0,
          child: ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            leading: Text(
              "No Results Found",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      );
    }
    return listOfVideo;
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _size = size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 6.0),
                child: Container(
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
                      borderRadius: BorderRadius.circular(0.0)),
                  child: Text(
                    'Videos',
                    style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future:
                      getLinks(), // a previously-obtained Future<String> or null
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List<Widget> children;
                    if (snapshot.hasData) {
                      return ListView(
                        physics: BouncingScrollPhysics(),
                        children: snapshot.data,
                      );
                    } else if (snapshot.hasError) {
                      children = <Widget>[
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('Error: ${snapshot.error}'),
                        )
                      ];
                    } else {
                      children = <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting result...'),
                        )
                      ];
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
