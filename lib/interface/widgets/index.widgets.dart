import 'dart:async';

import 'package:flutter/material.dart';

class BodyCounter extends StatefulWidget {
  final String textCoordinates;
  const BodyCounter({super.key, required this.textCoordinates});

  @override
  State<BodyCounter> createState() => _BodyCounterState();
}

class _BodyCounterState extends State<BodyCounter> {
  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text("Tú ubicación actual es:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          Text(widget.textCoordinates, style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
        ]),
      ),
    );
  }
}
