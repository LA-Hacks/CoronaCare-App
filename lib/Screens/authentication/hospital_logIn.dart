import 'package:la_hack/Screens/authentication/registration_screen.dart';
import 'package:la_hack/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:la_hack/components/rounded_button.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:la_hack/components/resuable_card.dart';
import 'package:la_hack/components/icon_content.dart';
import 'package:la_hack/utilities/constants.dart';
import 'package:la_hack/utilities/networking.dart';
import 'package:la_hack/Screens/HospitalView/hospital_home.dart';
import 'registration_screen.dart';

class Hospital {
  const Hospital(this.name, this.id, this.icon);
  final String name;
  final String id;
  final Icon icon;
}

class Hoppital_Registration extends StatefulWidget {
  static const String id = 'Hospital_registration_screen';

  @override
  _Hoppital_RegistrationState createState() => _Hoppital_RegistrationState();
}

class _Hoppital_RegistrationState extends State<Hoppital_Registration> {
  // final _auth = FirebaseAuth.instance;

  bool showSpinner = false;

  String username;
  String password;
  String hospital_id;
  String phone_number;

  NetworkHelper hospitalList = NetworkHelper("/hospitallist");
  NetworkHelper registerHospital = NetworkHelper("/register");

  List<Hospital> hospitals = [];
  Hospital selectedHospital;

  Future getHospitals() async {
    var hospitalResponse = await hospitalList.getData();

    for (var i in hospitalResponse['hospitals']) {
      Hospital hospital = Hospital(
          i['name'], i['_id']['\$oid'].toString(), Icon(Icons.android));
      setState(() {
        hospitals.add(hospital);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getHospitals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.hospital,
                    color: Colors.white,
                    size: 85,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Hospital',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    username = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Username')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  phone_number = value;
                  //Do something with the user input.
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Phone Number'),
              ),
              SizedBox(
                height: 24.0,
              ),
              DropdownButton<Hospital>(
                hint: Text('Select a Hospital'),
                value: selectedHospital,
                onChanged: (Hospital value) {
                  setState(() {
                    selectedHospital = value;
                  });
                },
                items: hospitals.map((Hospital hospital) {
                  return DropdownMenuItem<Hospital>(
                    value: hospital,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        children: <Widget>[
                          hospital.icon,
                          SizedBox(width: 10),
                          Text(
                            hospital.name,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              RoundedButton(
                title: 'Register',
                color: Colors.red,
                onPressed: () {
                  if (username != null &&
                      password != null &&
                      phone_number != null &&
                      selectedHospital != null) {
                    setState(() {
                      registerHospital.sendData({
                        "username": username,
                        "password": password,
                        "provider_id": selectedHospital.id,
                        "phone_number": phone_number,
                      });
                    });

                    Navigator.popAndPushNamed(context, LoginScreen.id);
                  }
                },
                /*
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                */
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
import 'package:flutter_screenutil/flutter_screenutil.dart';



class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
      width: 14,
      height: 14,
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2.0, color: Colors.black)),
      child: isSelected
          ? Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            )
          : Container());
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff013243),
      resizeToAvoidBottomPadding: true,
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              //Profile Pic / Logo
              Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 40),
                    child: Image.asset(
                      "assets/ecowealth.png",
                      width: 125,
                      height: 250,
                    ),
                  ),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Color(0xfff0ead6)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 10.0),
                        blurRadius: (10.0),
                      ),
                    ],
                  ),
                ),
              ),
              //end of Profile Picture(?)
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, right: 30.0, top: 0.0, bottom: 28.0),
                  child: Center(
                    child: Column(
                      //Login Infos
                      children: <Widget>[
                        Center(
                          child: Text(
                            'EcoWealth',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(80),
                            ),
                          ),
                        ),

                        //box for logins
                        Container(
                          width: double.infinity,
                          height: ScreenUtil.getInstance().setHeight(400),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 10.0),
                                blurRadius: (5.0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(50),
                                      fontFamily: "Poppins-Bold",
                                      letterSpacing: .6),
                                ),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(30),
                                ),
                                Text(
                                  "Username",
                                  style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(28),
                                  ),
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'username',
                                    hintStyle: TextStyle(
                                        fontFamily: "Roboto-Bold",
                                        color: Colors.grey,
                                        fontSize: 12.0),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(10),
                                ),
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(28),
                                  ),
                                ),
                                TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'password',
                                    hintStyle: TextStyle(
                                        fontFamily: "Roboto-Bold",
                                        color: Colors.grey,
                                        fontSize: 12.0),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 3, top: 13, bottom: 0),
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: _radio,
                                          child: radioButton(_isSelected),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text("Remember me",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontFamily:
                                                      "Poppins-Medium")),
                                        )
                                      ],
                                    ))
                              ],
                              //end of rows in column
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30, left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(425),
                        height: ScreenUtil.getInstance().setHeight(75),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(75.0 / 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 10.0),
                                blurRadius: 10.0,
                              )
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          //the sign-in with Google button
                          child: InkWell(
                            //do something when pressed
                            onTap: () {},
                            child: Center(
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 18, right: 10),
                                    child: Image(
                                        image: AssetImage(
                                            "assets/google_logo.png"),
                                        height: 33.0),
                                  ),
                                  Text(
                                    "Sign in with Google",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 16.25,
                                        letterSpacing: 0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(200),
                        height: ScreenUtil.getInstance().setHeight(75),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(75.0/2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 10.0),
                                blurRadius: 10.0,
                              )
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          //the sign-in button
                          child: InkWell(
                            //do something when pressed
                            onTap: () {
                                  onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                            },
                            child: Center(
                              child: Text("Sign In",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 20,
                                      letterSpacing: .5)),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
}
*/
