import 'package:la_hack/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:la_hack/components/rounded_button.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:la_hack/components/resuable_card.dart';
import 'package:la_hack/components/icon_content.dart';
import 'package:la_hack/utilities/constants.dart';
import 'package:la_hack/Screens/ProviderView/provider_home.dart';
import 'package:la_hack/utilities/networking.dart';

class Provider_Registration extends StatefulWidget {
  static const String id = "Provider_logIn";

  @override
  _Provider_RegistrationState createState() => _Provider_RegistrationState();
}

class _Provider_RegistrationState extends State<Provider_Registration> {
  bool showSpinner = false;

  String email;
  String password;

  void sendData(String username, String password) async {
    NetworkHelper networkHelper = NetworkHelper("/register");
    Map<String, String> data = Map<String, String>();
    data['username'] = username;
    data['password'] = password;
    var response = await networkHelper.sendData(data);
    print(response);
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
                //  Icon(
                 //   FontAwesomeIcons.user,
                 //   color: Colors.white,
                 ////   size: 200,
                 // ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Provider',
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
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Name')),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Name of Product')),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Address'),
              ),
              RoundedButton(
                title: 'Register',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  sendData(email, password);
                  Navigator.popAndPushNamed(context, ProviderHome.id);
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
