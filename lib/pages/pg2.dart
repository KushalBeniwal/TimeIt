import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Calendar.dart';
import 'day.dart';

class pg2 extends StatefulWidget {
  @override
  State createState() => pg2State();
}

class pg2State extends State<pg2> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("TimeIt"),
          ),
          bottomNavigationBar: Container(
            color: Colors.blue,
            child: TabBar(

              tabs: [
                Tab(icon: Icon(Icons.event_note), text: 'Add Events',),
                Tab(icon: Icon(Icons.schedule), text: 'Today',),
                Tab(icon: Icon(Icons.show_chart), text: 'Stats',)
              ],
            ),
          ),
          body: TabBarView(
            children: [Calendar(), TimeBlockList(), Icon(Icons.show_chart)],
          ),
        ),
      ),
    );
  }
}
