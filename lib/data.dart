import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String name = 'Hello There';
int weight;
int age;

String email = '';
String otp;

String videoUrl = 'https://smit-yukti-server.herokuapp.com/display/video/all';
String eventUrl = 'https://smit-yukti-server.herokuapp.com/display/events/';
String otpUrl = 'https://smityukti.rishabh.live/api/v1/sendotp/';
String userDataUrl = 'https://smit-yukti-server.herokuapp.com/display/user';
String userLogoUrl =
    'https://www.nj.com/resizer/zovGSasCaR41h_yUGYHXbVTQW2A=/1280x0/smart/cloudfront-us-east-1.images.arcpublishing.com/advancelocal/SJGKVE5UNVESVCW7BBOHKQCZVE.jpg';
String fitnessUrl =
    'https://www.pinclipart.com/picdir/big/59-596765_regular-exercise-is-necessary-for-physical-fitness-vector.png';
String userDataUpdateUrl = 'https://smit-yuktiserver.heroku.com/mod/age&wt';

String jayInsta = 'https://instagram.com/little.j.hobbit?igshid=14np6usrilpyp';
String jayLinkedIn = 'https://linkedin.com/in/jay-kumar-smit';
String surajInsta =
    'https://instagram.com/surajkumarojha9123?igshid=eg6o81e2v0pf';
String surajLinkedIn = 'https://www.linkedin.com/in/suraj-kumar-ojha-b51511194';

Future login() async {
  try {
    var response = await http.get(otpUrl + email);
    print(response.body);
    var data = json.decode(response.body);
    otp = data["otp"].toString();
    print(otp);
  } catch (e) {
    print(e);
  }
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
      name = data["name"];
      age = data["age"];
      weight = data["weight"];
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

Future updateUserData(age, wt) async {
  try {
    var response = await http.post(
      userDataUpdateUrl,
      headers: {"Content-Type": "application/json"},
      body: json.encode({'email': email, 'new_wt': wt, 'new_age': age}),
    );
  } catch (e) {
    print(e);
  }
  return 1;
}
