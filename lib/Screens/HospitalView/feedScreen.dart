import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:la_hack/Screens/authentication/provider_logIn.dart';
import 'package:la_hack/utilities/networking.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:la_hack/utilities/constants.dart';

class HospitalFeedScreen extends StatefulWidget {
  @override
  _HospitalFeedScreenState createState() => _HospitalFeedScreenState();
}

class _HospitalFeedScreenState extends State<HospitalFeedScreen> {
  var hospital;

  int tileCount = 0;
  Widget tile;
  

  Future<List<Hospital>> getData() async {
    NetworkHelper networkHelper = NetworkHelper('/hospitallist');
    var data = await networkHelper.getData();

    List<Hospital> hospitals = [];
    for (var u in data['hospitals']) {
      Hospital hospital = Hospital(name: u['name'], location: u['city_state']);
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
      itemCount: tileCount,
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
        appBar: (AppBar(
          title: Text('Hospital Requests'),
          backgroundColor: Colors.red,
        )),
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          ExpansionTileCard(
                            leading: Icon(
                              FontAwesomeIcons.hospital,
                              size: 50,
                            ),
                            title: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //Text(snapshot.data[index].city_name),
                                 // Text(snapshot.data[index].address),
                                  Text(snapshot.data[index].name),
                                  Text(
                                    snapshot.data[index].location,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                            children: <Widget>[
                              Divider(
                                thickness: 1.0,
                                height: 1.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 8.0,
                                  ),
                                  child: Column(
                                    children: <Widget>[Text('Requesting')],
                                  ),
                                ),
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.end,
                                buttonHeight: 52.0,
                                buttonMinWidth: 90.0,
                                children: <Widget>[
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.red)),
                                    onPressed: () {
                                      showModalBottomSheet(context: context, builder: (context) => SendRequestScreen());
                                    },
                                    color: Colors.red,
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );

                    /*Container
                      child: Card(
                    
                        child: CustomListItemTwo(
                          thumbnail: Container(
                            child: Icon(
                              Icons.local_hospital,
                              color: Colors.blue,
                              size: 50,
                            ),
                          ),
                          title: (snapshot.data[index].name),
                          subtitle: 'In Urgent Need of Candy\nIn Urgent need of Money',
                          author: 'Level of Urgency - High',
                          publishDate: 'Dec 28',
                          readDuration: (snapshot.data[index].location),
                        ),
                      ),
                    )
                    */
                    ;
                  });
            }
          },
        ),
      ),
    );
  }
}

class SendRequestScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'New Supply',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 24,),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Name'),
              //decoration: kTextFieldDecoration.copyWith(hintText: 'Name')),
              onChanged: (newText) {
                //newTaskTitle = newText;
              },
            ),
              SizedBox(height: 24,),
                TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Quantity'),
              //decoration: kTextFieldDecoration.copyWith(hintText: 'Name')),
              onChanged: (newText) {
                //newTaskTitle = newText;
              },
            ),
            SizedBox(height: 24,),
            FlatButton(
              child: Text(
                'Send',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.redAccent,
              onPressed: () {
                //Provider.of<TaskData>(context).addTask(newTaskTitle);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$subtitle',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '$author',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate · $readDuration ★',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.thumbnail,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
 ListTile(
                          leading: Icon(FontAwesomeIcons.hospital),
                          title: Text(snapshot.data[index].name),
                          subtitle: Text(snapshot.data[index].location),
                          trailing: Icon(Icons.add),
                          isThreeLine: true,
                        ),
              */

class Hospital {
  final String name;
  final String location;
  final String address;
  final String city_state;
  Hospital({this.name, this.location,this.address,this.city_state});
}