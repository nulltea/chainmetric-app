import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class LoadingSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        color: Theme.of(context).primaryColor,
        child: LoadingBouncingGrid.square(
            size: 75,
            backgroundColor: Colors.teal.shade600,
            borderColor: Colors.black54),
      );
}
