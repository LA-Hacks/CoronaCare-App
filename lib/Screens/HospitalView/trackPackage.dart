import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_hack/utilities/constants.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:la_hack/utilities/networking.dart';

class TrackPackage extends StatefulWidget {
  @override
  _TrackPackageState createState() => _TrackPackageState();
}

class Supply {
  final String id;
  final String name;
  final int quantity;
  final String standard;
  final String provider;
  final String address;
  bool isDeleated;
  Supply(
      {this.id,
      this.name,
      this.quantity,
      this.standard,
      this.provider,
      this.address,
      this.isDeleated});
  void toggleDone() {
    isDeleated = !isDeleated;
  }
}

class _TrackPackageState extends State<TrackPackage> {
  List<Supply> supplies = [];

  NetworkHelper getShipments = NetworkHelper('/shipmentlist');

  Future getData() async {
    var shipments = await getShipments.getData();

    print(shipments);

    for (var s in shipments['shipments']) {
      String name;
      String address;
      if (NetworkHelper.type == "hospital") {
        name = "From: " + s['provider']['name'];
        address = s['provider']['address'] + " " + s['provider']['city_state'];
      } else {
        name = "To: " + s['hospital']['name'];
        address = s['hospital']['address'] + " " + s['provider']['city_state'];
      }

      setState(() {
        supplies.add(Supply(
            id: s['_id']['\$oid'],
            name: s['resource_name'],
            quantity: s['quantity'],
            standard: s['standard'],
            provider: name,
            address: address));
      });
    }

    print(supplies.length);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('Shipments'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Shipments',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 30.0),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${supplies.length} ${NetworkHelper.type == "hospital" ? "Incoming" : "Outgoing"} Shipments',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: SupplyList(supplies),
            ),
          ),
        ],
      ),
    );
  }
}

class SupplyList extends StatefulWidget {
  final List<Supply> supplies;
  SupplyList(this.supplies);
  @override
  _SupplyListState createState() => _SupplyListState();
}

class _SupplyListState extends State<SupplyList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.supplies.length,
        itemBuilder: (context, index) {
          String status = "Received";
          if (NetworkHelper.type == "provider") {
            status = "Sent";
          }
          return SupplyTile(widget.supplies[index], status);
        });
  }
}

class SupplyTile extends StatelessWidget {
  final Supply supply;
  final String status;

  SupplyTile(this.supply, this.status);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ExpansionTileCard(
            leading: Icon(
              FontAwesomeIcons.shippingFast,
              size: 50,
            ),
            title: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    supply.name,
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    supply.standard,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0, 0),
                          blurRadius: 1.0,
                        ),
                      ],
                    ),
                    child: FAProgressBar(
                      currentValue: 80,
                      displayText: '',
                      progressColor: Colors.red,
                      borderRadius: 5,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Count: " + supply.quantity.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              supply.provider,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () {},
                    color: Colors.red,
                    child: Row(
                      children: <Widget>[
                        Text(
                          status,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddTaskScreen extends StatelessWidget {
  final Function addSupplyCallback;
  AddTaskScreen(this.addSupplyCallback);
  String newSupplyTitle;
  String supplyCount;
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
            SizedBox(
              height: 24,
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Name'),
              //decoration: kTextFieldDecoration.copyWith(hintText: 'Name')),
              onChanged: (newText) {
                //newTaskTitle = newText;
                newSupplyTitle = newText;
              },
            ),
            SizedBox(
              height: 24,
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Quantity'),
              //decoration: kTextFieldDecoration.copyWith(hintText: 'Name')),
              onChanged: (newText) {
                //newTaskTitle = newText;
                supplyCount = newText;
              },
            ),
            SizedBox(
              height: 24,
            ),
            FlatButton(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.redAccent,
              onPressed: () {
                //print(newSupplyTitle);
                //print(supplyCount);
                addSupplyCallback(newSupplyTitle, supplyCount);
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
