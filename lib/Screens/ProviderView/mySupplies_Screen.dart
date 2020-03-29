import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_hack/utilities/constants.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:la_hack/utilities/networking.dart';

class MySupplies extends StatefulWidget {
  @override
  _MySuppliesState createState() => _MySuppliesState();
}

class _MySuppliesState extends State<MySupplies> {
  List<Supply> supplies = [];

  Future getSupplies() async {
    NetworkHelper supply;
    String index;
    if (NetworkHelper.type == "provider") {
      supply = NetworkHelper('/supplylist');
      index = "supplies";
    } else {
      supply = NetworkHelper('/requestlist');
      index = "requests";
    }

    var suppliesList = await supply.getData();
    for (var s in suppliesList[index]) {
      print(s);
      setState(() {
        supplies.add(Supply(s['resource_name'], s['standard'], s['quantity']));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSupplies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title:
            Text((NetworkHelper.type == "provider" ? "Supplies" : "Requests")),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => AddTaskScreen(
                            (newSupplyTitle, newStandard, newSupplyQuantity) {
                          setState(() {
                            supplies.add(
                              Supply(
                                newSupplyTitle,
                                newStandard,
                                newSupplyQuantity,
                              ),
                            );
                          });
                        }));
              },
            ),
          )
        ],
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
                    NetworkHelper.username,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 30.0),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${supplies.length} Supplies',
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

class Supply {
  final String name;
  final String standard;
  final int quantity;
  bool isDeleated;
  Supply(this.name, this.standard, this.quantity);
  void toggleDone() {
    isDeleated = !isDeleated;
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
          return SupplyTile(
            productName: widget.supplies[index].name,
            quantity: widget.supplies[index].quantity.toString(),
            //add callback too if needed
          );
        });
  }
}

class SupplyTile extends StatelessWidget {
  final String productName;
  final String quantity;

  SupplyTile({this.productName, this.quantity});

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
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      productName,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Quantity : ' + quantity,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
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
                    children: <Widget>[
                      Text(
                        '',
                        // quantity,
                      )
                    ],
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
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () {},
                    color: Colors.red,
                    child: Text(
                      'Delete',
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
  }
}

class AddTaskScreen extends StatefulWidget {
  final Function addSupplyCallback;

  AddTaskScreen(this.addSupplyCallback);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newSupplyTitle;

  int supplyCount;

  Product selectedProduct;
  //  = Product("", "", ["Select a Standard"]);
  String selectedStandard;

  List<Product> products = [];
  NetworkHelper productList = NetworkHelper("/resourcelist");
  Future<List<Product>> getProviders() async {
    var providersResponse = await productList.getData();

    for (var i in providersResponse['resource']) {
      print(i['standard']);
      List<String> standards = [];
      for (var s in i['standard']) {
        standards.add(s.toString());
      }
      Product product = Product(i['name'], i['_id']['\$oid'], standards);
      setState(() {
        products.add(product);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProviders();
  }

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
              (NetworkHelper.type == "provider" ? "New Supply" : "New Request"),
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
              decoration: kTextFieldDecoration.copyWith(hintText: 'Quantity'),
              //decoration: kTextFieldDecoration.copyWith(hintText: 'Name')),
              onChanged: (newText) {
                //newTaskTitle = newText;
                supplyCount = int.parse(newText);
              },
            ),
            SizedBox(
              height: 24,
            ),
            DropdownButton<Product>(
              hint: Text('Select a Product'),
              value: selectedProduct,
              onChanged: (Product value) {
                setState(() {
                  selectedProduct = value;
                });
              },
              items: products.map((Product product) {
                return DropdownMenuItem<Product>(
                  value: product,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Row(
                      children: <Widget>[
                        Text(product.productName),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 24,
            ),
            DropdownButton<String>(
              hint: Text('Select a Standard'),
              value: selectedStandard,
              onChanged: (String value) {
                setState(() {
                  selectedStandard = value;
                });
              },
              items: (selectedProduct != null
                      ? selectedProduct.productStandard
                      : List<String>())
                  .map((String standard) {
                return DropdownMenuItem<String>(
                  value: standard,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Row(
                      children: <Widget>[
                        Text(standard),
                      ],
                    ),
                  ),
                );
              }).toList(),
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
                NetworkHelper adder;
                if (NetworkHelper.type == "provider") {
                  adder = NetworkHelper('/supply');
                } else {
                  adder = NetworkHelper('/request');
                }

                adder.sendData({
                  "resource_name": selectedProduct.productName,
                  "resource_id": selectedProduct.productId,
                  "standard": selectedStandard,
                  "quantity": supplyCount
                });

                print("SENT");

                widget.addSupplyCallback(newSupplyTitle, supplyCount);
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

class Product {
  const Product(this.productName, this.productId, this.productStandard);
  final String productName;
  final String productId;
  final List<String> productStandard;
}
