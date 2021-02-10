import 'package:flutter/material.dart';
import 'dart:math' as math;

class FloatingButtonAnimated extends StatefulWidget {
  @override
  _FloatingButtonAnimatedState createState() => _FloatingButtonAnimatedState();
}

class _FloatingButtonAnimatedState extends State<FloatingButtonAnimated>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: animate,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform(
            transform:
                Matrix4.rotationZ(_animationController.value * 0.5 * math.pi),
            alignment: FractionalOffset.center,
            child: Icon(
                _animationController.isDismissed ? Icons.add : Icons.close),
          );
        },
      ),
    );
  }
}
