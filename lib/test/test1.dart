import 'package:agriapp/constants/constraints.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Material(
                child: TabBar(
                  indicatorColor: Colors.green,
                  tabs: [
                    Tab(
                      text: "Home",
                    ),
                    Tab(
                      text: "Work",
                    ),
                    Tab(
                      text: "Play",
                    ),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicator: RectangularIndicator(
                    color: kPrimaryColordark,
                    bottomLeftRadius: 100,
                    bottomRightRadius: 100,
                    topLeftRadius: 100,
                    topRightRadius: 100,
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  Icon(Icons.directions_car),
                  Icon(Icons.directions_transit),
                  Icon(Icons.directions_bike),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
