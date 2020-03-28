import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:la_hack/Screens/authentication/provider_logIn.dart';
import 'package:la_hack/utilities/networking.dart';



class HospitalFeedScreen extends StatefulWidget {
  @override
  _HospitalFeedScreenState createState() => _HospitalFeedScreenState();
}

class _HospitalFeedScreenState extends State<HospitalFeedScreen> {
  var hospital;
  String location;
  int tileCount = 0;
  Widget tile;

  Future<List<Hospital>> getData() async {
    NetworkHelper networkHelper = NetworkHelper('/hospitallist');
    var data = await networkHelper.getData();

    List<Hospital> hospitals = [];
    for (var u in data['hospitals']) {
      Hospital hospital = Hospital(name: u['name'], location: u['location']);
      hospitals.add(hospital);
    }
    print(hospitals.length);
    return hospitals;
  }

  void updateUI(dynamic data) {
    print(data);

    setState(() {
      tileCount = data['hospitals'].count;

      for (int i = 0; i < data['hospitals'].length; i++) {
        hospital = data['hospitals'][i];
      }
    });
  }

  Widget hospitalTile() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(8),
      itemCount: 2,
      itemBuilder: (BuildContext context, index) {
        return ListTile(
          title: Text('${hospital['name']}'),
          leading: Icon(FontAwesomeIcons.accessibleIcon),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(
                child: Center(child: CircularProgressIndicator(),),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Icon(FontAwesomeIcons.hospital),
                          title: Text(snapshot.data[index].name),
                          subtitle: Text(snapshot.data[index].location),
                          trailing: Icon(Icons.add),
                        
          
                        ),
                      ),
                    );
                  
                  }
                  
                  );
            }
          },
        ),
      ),
    );
  }
}

class Hospital {
  final String name;
  final String location;
  Hospital({this.name, this.location});
}
