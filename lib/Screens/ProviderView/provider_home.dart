import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:la_hack/Screens/authentication/provider_logIn.dart';
import 'package:la_hack/utilities/networking.dart';
import 'package:la_hack/Screens/HospitalView/feedScreen.dart';
import 'package:la_hack/Screens/HospitalView/trackPackage.dart';
import 'mySupplies_Screen.dart';

class ProviderHome extends StatefulWidget {
  static const String id = "Provider_Home";

  @override
  _ProviderHomeState createState() => _ProviderHomeState();
}

class _ProviderHomeState extends State<ProviderHome> {
  int _currentIndex = 0;
  String username;
  var hospital;
  String location;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void getData() async {
    NetworkHelper networkHelper = NetworkHelper('/hospitallist');
    var data = await networkHelper.getData();
    print(data);
    updateUI(data);
  }

  void updateUI(dynamic data) {
    setState(() {
      for (int i = 0; i < data['hospitals'].length; i++) {
        hospital = data['hospitals'][i];
        print('Hospital Name :' +
            hospital['name'] +
            '\n' +
            'Location : ' +
            hospital['location']);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  final List<Widget> _children = [
    MySupplies(),
    TrackPackage(),
    HospitalFeedScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        child: BottomNavigationBar(
          elevation: 5,
          backgroundColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: onTappedBar,
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Icon(
                    FontAwesomeIcons.firstAid,
                    size: 20.0,
                  ),
                ),
                title: Text('')),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Icon(
                  FontAwesomeIcons.car,
                  size: 20.0,
                ),
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Icon(
                    FontAwesomeIcons.hospital,
                    size: 20.0,
                  ),
                ),
                title: Text('')),
          ],
        ),
      ),
    );
  }
}
