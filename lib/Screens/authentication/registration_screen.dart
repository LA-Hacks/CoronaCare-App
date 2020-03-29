import 'package:flutter/material.dart';
import 'package:la_hack/components/rounded_button.dart';
import 'package:la_hack/utilities/constants.dart';
import 'package:la_hack/utilities/networking.dart';
//import 'package:firebase_auth/firebase_auth.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:la_hack/Screens/HospitalView/hospital_home.dart';
import 'package:la_hack/Screens/ProviderView/provider_home.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String type;

  NetworkHelper hospitalList = NetworkHelper("/login");

  Future login() async {
    type = await hospitalList.login(username, password);

    if (type == 'hospital') {
      Navigator.pushNamed(context, HospitalHome.id);
    }

    if (type == 'provider') {
      Navigator.pushNamed(context, ProviderHome.id);
    }
  }

  String username;
  String password;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    username = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Username')),
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
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Password')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Login',
                color: Colors.white,
                onPressed: () {
                  login();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
