import 'package:flutter/material.dart';

import 'package:la_hack/components/rounded_button.dart';
import 'package:la_hack/components/resuable_card.dart';
import 'package:la_hack/components/icon_content.dart';
import 'package:la_hack/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'hospital_logIn.dart';
import 'provider_logIn.dart';


enum Hospital_Or_Provider {
  hospital,
  provider,
}

class Hospital_or_Provider extends StatefulWidget {
  static const String id = 'Hospital_or_Provider';

  @override
  _Hospital_or_ProviderState createState() => _Hospital_or_ProviderState();
}

class _Hospital_or_ProviderState extends State<Hospital_or_Provider> {
  // final _auth = FirebaseAuth.instance;
  // bool showSpinner = false;
  Hospital_Or_Provider choice;

  //String email;
  //String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 200,
            //  color: Colors.white,
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.stretch,

              children: <Widget>[
                Expanded(
                  child: ReuableCard(
                    onPress: () {
                      setState(() {
                        choice = Hospital_Or_Provider.hospital;
                      });
                      Navigator.popAndPushNamed(context, Hoppital_Registration.id);
                      // MaterialPageRoute(builder: (context) => Provider_Registration());
                    },
                    color: choice == Hospital_Or_Provider.hospital
                        ? kActiveCardColor
                        : kInActiveCardColor,
                    cardChild: IconContent(
                      iconCard: FontAwesomeIcons.hospital,

                      text: 'Hospital',
                    ),
                  ),
                ),
                Expanded(
                  child: ReuableCard(
                    onPress: () {
                      
                      Navigator.popAndPushNamed(context, Provider_Registration.id);
                    },
                    color: kActiveCardColor,
                    cardChild: IconContent(
                      iconCard: FontAwesomeIcons.user,
                      text: 'Provider',
                    ),
                  ),
                ),
              ],
            ),
          ),
         
          
        ],
      ),
      
    );
  }
}

/*
Expanded(
              child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
              Expanded(
             child: ReuableCard(
               onPress: (){
                 setState(() {
                   choice = Hospital_Or_Provider.hospital;
                 });
               },
               color: choice == Hospital_Or_Provider.hospital ? kActiveCardColor : kInActiveCardColor,
               cardChild: IconContent(iconCard: FontAwesomeIcons.hospital,
               text: 'Hospital',),
             ),
         ),
         Expanded(
            
             child: ReuableCard(
               onPress: (){
                 setState(() {
                   choice = Hospital_Or_Provider.provider;
                 });
               },
               color: choice == Hospital_Or_Provider.provider ? kActiveCardColor : kInActiveCardColor,
               cardChild: IconContent(iconCard: FontAwesomeIcons.accusoft,
               text: 'Provider',),
             ),
         ),
         */
