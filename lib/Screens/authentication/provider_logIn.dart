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

// get the data for the list of providers
class Provider_id {
  const Provider_id(this.name, this.location);
  final String name;
  final String location;
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

  var providers;

  void getProviders() async {
    var providersResponse = await providerList.getData();
    providers = providersResponse['providers/'];
    print(providers);
    print(providers.toString());
  }

  List _providerDopDownList = ["Birds", "Apples"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selected_provider;

  List<DropdownMenuItem<String>> buildAndGetDropDownItems(
      List providerDopDownList) {
    List<DropdownMenuItem<String>> items = List();
    for (String i in providerDopDownList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Container(
            
            child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(i,),
              ],
              ),
        ),
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    getProviders();
    _dropDownMenuItems = buildAndGetDropDownItems(_providerDopDownList);
    _selected_provider = _dropDownMenuItems[0].value;
  }

  void changeDropDownItem(String selectedProvider) {
    setState(() {
      _selected_provider = selectedProvider;
    });
  }

  NetworkHelper providerList = NetworkHelper("/providerlist");
  NetworkHelper registerProvider = NetworkHelper("/register");

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
                    username = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Name')),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    //email = value;
                    password = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Password')),
              SizedBox(
                height: 24.0,
              ),
              DropdownButton(
                items: _dropDownMenuItems,
                value: _selected_provider,
                onChanged: changeDropDownItem,
              ),
              /*TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  provider_id = value;
                  //Do something with the user input.
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Provider ID'),
              ),*/
              RoundedButton(
                title: 'Register',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  setState(() {
                    registerProvider.sendData({
                      "username": username,
                      "password": password,
                      "provider_id": provider_id,
                    });
                  });

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
