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
class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class Provider {
  final String name;
  final String location;
  final String id;

  Provider({this.name, this.location, this.id});
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

  List providerNames = [];
  List providerLocation = [];
  NetworkHelper providerList = NetworkHelper("/providerlist");
  NetworkHelper registerProvider = NetworkHelper("/register");

  Future<List<Provider>> getProviders() async {
    var providersResponse = await providerList.getData();
    List<Provider> providers = [];
    print('hello world');
    print(providersResponse);
    print(providersResponse['providers']);
    //providers = providersResponse['providers'];
    for (var i in providersResponse['providers']) {
      Provider provider = Provider(
          name: i['name'],
          location: i['zip'],
          id: i['_id']['\$oid'].toString());
      providers.add(provider);
      providerNames.add(provider.name);
      providerLocation.add(provider.location);
      print(provider);
      print('Name:' + provider.name);
      print(provider.id);
      print('gsertghsethgrtn');
    }
    return providers;
  }

  Item selectedUser;
  List<Item> users = <Item>[
    Item(
      'Android',
      Icon(Icons.android),
    ),
     Item(
      'Android',
      Icon(Icons.android),
    ),
     Item(
      'Android',
      Icon(Icons.android),
    ),
  ];

  @override
  void initState() {
    super.initState();
    getProviders();
  }

  void submit() {}

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
                    size: 125,
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
              DropdownButton<Item>(
                hint: Text('Provider Id'),
                value: selectedUser,
                onChanged: (Item value) {
                  setState(() {
                    selectedUser = value;
                  });
                },
                items: users.map((Item user) {
                  return DropdownMenuItem<Item>(
                    value: user,
                    child: Row(
                      children: <Widget>[
                        user.icon,
                        SizedBox(width: 10),
                        Text(
                          user.name,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              RoundedButton(
                title: 'Register',
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    registerProvider.sendData({
                      "username": username,
                      "password": password,
                      "provider_id": provider_id,
                      "phone_number": phone_number,
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
