// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'dart:async';

import 'package:agriapp/screens/auth/check_signIn.dart';
import 'package:agriapp/screens/auth/load_userdata.dart';
import 'package:agriapp/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';

import '../../constants/constraints.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 2);

    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => CheckSignIn()));
  }

  initScreen(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(color: kPrimaryColorlight),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.2,
          ),
          Padding(
              padding: EdgeInsets.all(size.width * 0.1),
              child: Image.asset("assets/icons/app_icon.png")),
          SizedBox(
            height: size.height * 0.2,
          ),
          Text(
            "Agrii App",
            style: TextStyle(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    ));
  }
}
