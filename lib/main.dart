import 'package:flutter/material.dart';
import 'package:la_hack/Screens/HospitalView/hospital_home.dart';
import 'package:la_hack/Screens/authentication/welcome_screen.dart';

import 'package:la_hack/Screens/authentication/hospital_provider.dart';
//HOSPITAL
import 'package:la_hack/Screens/authentication/hospital_logIn.dart';
//HOSPITAL SCREENS

//PROVIDER
import 'package:la_hack/Screens/authentication/provider_logIn.dart';
//PROVIDER SCREENS
import 'package:la_hack/Screens/ProviderView/provider_home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        //Registration
        WelcomeScreen.id: (context) => WelcomeScreen(),

        //Registration Screen
        Hospital_or_Provider.id: (context) => Hospital_or_Provider(),
        Hoppital_Registration.id: (context) => Hoppital_Registration(),
        Provider_Registration.id: (context) => Provider_Registration(),

        //Provider Pages
        ProviderHome.id: (context) => ProviderHome(),

        //Hospital Pages
        HospitalHome.id: (context) => HospitalHome(),

       

      },
    );
  }
}
