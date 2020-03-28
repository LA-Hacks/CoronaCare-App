import 'package:flutter/material.dart';

class ReuableCard extends StatelessWidget {
  ReuableCard({@required this.color, this.cardChild, this.onPress});
  //Final makes this property immutable!
  //immutable - means the color can't be changed again
  final Color color;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
