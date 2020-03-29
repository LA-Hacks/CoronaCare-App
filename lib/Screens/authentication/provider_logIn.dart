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
import 'package:la_hack/Screens/ProviderView/provider_home.dart';
import 'package:la_hack/utilities/networking.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'registration_screen.dart';

// get the data for the list of providers
class Provider {
  const Provider(this.name, this.id, this.icon);
  final String name;
  final String id;
  final Icon icon;
}

class Provider_Registration extends StatefulWidget {
  static const String id = "Provider_logIn";

  @override
  _Provider_RegistrationState createState() => _Provider_RegistrationState();
}

class _Provider_RegistrationState extends State<Provider_Registration> {
  bool showSpinner = false;

  String username;
  String password;
  String provider_id;
  String phone_number;

  NetworkHelper providerList = NetworkHelper("/providerlist");
  NetworkHelper registerProvider = NetworkHelper("/register");

  List<Provider> providers = [];
  Provider selectedProvider;

  Future<List<Provider>> getProviders() async {
    var providersResponse = await providerList.getData();

    for (var i in providersResponse['providers']) {
      Provider provider = Provider(
          i['name'], i['_id']['\$oid'].toString(), Icon(Icons.android));
      setState(() {
        providers.add(provider);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProviders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      //user/username
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
                    FontAwesomeIcons.user,
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
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //email = value;
                  phone_number = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Phone Number'),
              ),
              SizedBox(
                height: 24.0,
              ),
              DropdownButton<Provider>(
                hint: Text('Select a Provider'),
                value: selectedProvider,
                onChanged: (Provider value) {
                  setState(() {
                    selectedProvider = value;
                  });
                },
                items: providers.map((Provider provider) {
                  return DropdownMenuItem<Provider>(
                    value: provider,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        children: <Widget>[
                          provider.icon,
                          SizedBox(width: 10),
                          Text(
                            provider.name,
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
                      selectedProvider != null) {
                    setState(() {
                      registerProvider.sendData({
                        "username": username,
                        "password": password,
                        "provider_id": selectedProvider.id,
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

class SendData {
  final int id;
  final String title;
  final String provider_id;

  SendData({this.id, this.title, this.provider_id});

  factory SendData.fromJson(Map<String, dynamic> json) {
    return SendData(
      id: json['username'],
      title: json['password'],
      provider_id: json['provider_id'],
    );
  }
}
