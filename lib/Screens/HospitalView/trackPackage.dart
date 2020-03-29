import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';


class TrackPackage extends StatefulWidget {
 

  @override
  _TrackPackageState createState() => _TrackPackageState();
}

class _TrackPackageState extends State<TrackPackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                            maxValue: 100,
                            displayText: '\$',
                            progressColor: Colors.lightBlueAccent,
                            borderRadius: 5,
                            backgroundColor: Colors.white,
                          ),
                        ),
            ],
          ),
    );
  }
}
