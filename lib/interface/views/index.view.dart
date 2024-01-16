import 'dart:async';
import 'dart:isolate';

import 'package:be_group_test/core/models.dart';
import 'package:be_group_test/interface/widgets/index.widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color(0xFF000000),
        backgroundColor: Color(0xFF0068A0),
        elevation: 4,
        centerTitle: true,
        title: Text(
          "BE Group: Technical Test",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
      body: HomeView(),
    );
    ;
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String text = "Obteniendo ubicación...";
  bool isInit = true;
  DateTime date = DateTime.now();
  @override
  void initState() {
    super.initState();
    MyLocation().getPermissions().then((value) {
      if (value == true) {
        if(isInit)updateTime();
        var receivePort = ReceivePort();
        Isolate.spawn((message) {
          Timer.periodic(Duration(seconds: 120), (timer) {
            message.send("update");
          });
        }, receivePort.sendPort);

        receivePort.listen((message) {
          isInit = false;
          date = DateTime.now();
          print(date);
          updateTime();
        });
      }
    });
  }

  void updateTime() async {
    text = await MyLocation().getLocation();
    text = "$text $date";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BodyCounter(
          textCoordinates: "$text",
        )
      ],
    );
  }
}
