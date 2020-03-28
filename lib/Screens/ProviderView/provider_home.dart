import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:la_hack/utilities/networking.dart';


class ProviderHome extends StatefulWidget {
  static const String id = "Provider_Home";

  @override
  _ProviderHomeState createState() => _ProviderHomeState();
}

class _ProviderHomeState extends State<ProviderHome> {
  int _currentIndex = 0;
  String hospitalName;
  String cityName;
  String message;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void getData() async {
    NetworkHelper networkHelper = NetworkHelper('http://2c990005.ngrok.io/');
    var data = await networkHelper.getData();
  }

  void updateUI(dynamic data){
    setState(() {
      hospitalName = data['hospitalName'];
      cityName = data['name'];
      message = data['description'];
    });
  }

  @override
  void initState() {
    super.initState();
    
  }

   @override
  void deactivate() {
    super.deactivate();
  }



  final List<Widget> _children = [
    ProviderListView(),
    ProviderOrderInfo(),
    ProviderResourceList(),
    
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
          selectedItemColor: Colors.lightBlueAccent,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Icon(
                  FontAwesomeIcons.hospital,
                  size: 20.0,
                ),
              ),
              title: Text('')
            ),
             BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Icon(
                  FontAwesomeIcons.car,
                  size: 20.0,
                ),
              ),
              title: Text('')
            ),
            
             BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Icon(
                  FontAwesomeIcons.firstAid,
                  size: 20.0,
                ),
              ),
              title: Text('')
            ),
          ],
        ),
      ),
    );
  }
}

class ProviderOrderInfo extends StatelessWidget {
  const ProviderOrderInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.lightBlueAccent,
       title: Text('Orders'),),
    );
  }
}

class ProviderResourceList extends StatelessWidget {
  const ProviderResourceList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.lightBlueAccent,
       title: Text('Donate'),),
    );
  }
}

class ProviderListView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     appBar: AppBar(
       backgroundColor: Colors.grey,
       title: Text('Hospital Requests'),),
       body: SafeArea(child: 
       Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: <Widget>[
           
         ],
         ),
        ),
    );
  }
}
