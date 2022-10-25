import 'package:agriapp/screens/calling_ui/constants.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';
import 'components/body.dart';

class DialScreen extends StatelessWidget {
  final String name;
  final String iurl;

  const DialScreen({super.key, required this.name, required this.iurl});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kBackgoundColor,
      body: Body(iurl: iurl, name: name),
    );
  }
}
