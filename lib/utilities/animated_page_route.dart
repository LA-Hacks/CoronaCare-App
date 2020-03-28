import 'package:flutter/material.dart';

class AnimatedPageRoute extends PageRouteBuilder {
  final Widget widget;

  AnimatedPageRoute({this.widget})
      : super(
            transitionDuration: Duration(milliseconds: 200),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeIn);
              return ScaleTransition(
                scale: animation,
                child: child,
                alignment: Alignment.bottomCenter,
              );
            },
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
            ) {
              return widget;
            });
}
