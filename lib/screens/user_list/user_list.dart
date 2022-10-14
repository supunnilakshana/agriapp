import 'package:agriapp/components/roundedtextFiled.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/constants/initdata.dart';
import 'package:agriapp/screens/user_list/friendlist.dart';
import 'package:agriapp/screens/user_list/friensreachres.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class UserListScreen extends StatefulWidget {
  final String role;
  const UserListScreen({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();
  String stext = "";
  bool issearch = false;
  int val = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.green.withOpacity(0.2),
        child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Container(
                  child: Column(
                children: [
                  Row(
                    children: [
                      BackButton(),
                    ],
                  ),
                  issearch
                      ? Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.01),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: size.height * 0.02,
                                    left: size.width * 0.035),
                                child: Text(
                                  "Search results...",
                                  style: TextStyle(
                                      color: kBasefontColor.withOpacity(0.8),
                                      fontSize: size.width * 0.04,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              // FirendSearchRes(svalue: stext)
                            ],
                          ))
                      : SizedBox(height: size.height * 0),
                  Friendlist(
                    role: widget.role,
                  )
                ],
              ))
            ]),
      ),
    );
  }
}
