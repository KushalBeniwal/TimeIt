import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'pg2.dart';

class pg1 extends StatefulWidget {
  @override
  State createState() => pg1State();
}

class pg1State extends State<pg1> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: initScreen(context),
    );
  }

  initScreen(BuildContext context) {
    return Column(
      children: [SizedBox(height: 60),
        Text("TimeIt", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 50,
            decoration: TextDecoration.none)
          ),
        SizedBox(height: 15),
        Image.asset('assets/image/clock.png', height: 400, width: 400, alignment: Alignment.bottomCenter),

        ]
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => pg2()
    )
    );
  }
}


