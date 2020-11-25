import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yukti/data.dart';

class ChangeData extends StatefulWidget {
  @override
  _ChangeDataState createState() => _ChangeDataState();
}

class _ChangeDataState extends State<ChangeData> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            child: Column(
              children: <Widget>[
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
                    'Change Data',
                    style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Center(
                                child: Text(
                                  'Name : $name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            ChangeDataField(task: 'Age'),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            ChangeDataField(task: 'Weight'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChangeDataField extends StatefulWidget {
  ChangeDataField({this.task});
  final String task;
  @override
  _ChangeDataFieldState createState() => _ChangeDataFieldState();
}

class _ChangeDataFieldState extends State<ChangeDataField> {
  int newAge = age;
  int newWt = weight;
  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(225, 95, 27, .3),
                      blurRadius: 20,
                      offset: Offset(0, 10))
                ]),
            child: Material(
              child: Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) {
                    if (widget.task == 'Weight') {
                      try {
                        newWt = int.parse(value);
                      } catch (e) {
                        print(e);
                      }
                    } else {
                      try {
                        newAge = int.parse(value);
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "${widget.task}",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                  validator: (value) {
                    try {
                      String pattern = r'(^[0-9]{1,3})';
                      RegExp regExp = RegExp(pattern);
                      if (value.isEmpty) {
                        return 'Please Enter ${widget.task}';
                      } else if (!regExp.hasMatch(value)) {
                        return 'Please Enter a valid ${widget.task}';
                      } else {
                        return null;
                      }
                    } catch (e) {
                      print(e);
                      return 'Please Enter a valid ${widget.task}';
                    }
                  },
                  onSaved: (value) {
                    if (widget.task == 'Weight') {
                      try {
                        newWt = int.parse(value);
                      } catch (e) {
                        print(e);
                      }
                    } else {
                      try {
                        newAge = int.parse(value);
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Center(
              child: FlatButton(
                onPressed: () async {
                  if (form.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Done'),
                      ),
                    );
                    updateUserData(newAge, newWt);
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                  }
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xCC00FF55)),
                  child: Center(
                    child: Text(
                      'Change ${widget.task} ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
