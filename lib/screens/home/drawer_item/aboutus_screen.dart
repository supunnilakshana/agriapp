import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var userModel = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColordark,
        elevation: 0,
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.02,
                      left: size.width * 0.15,
                      right: size.width * 0.15),
                  child: Image.asset("assets/icons/app_icon.png")),
              Card(
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: size.width * 0.05,
                      right: size.width * 0.05),
                  child: Text(
                    "Smart Agri provide facilities to build better connection with paddy farmers ,Agri experts and Field officers.This mobile app provide facilities to farmers to contact with  Agei experts and field officers easily. Also Agri experts can contact with paddy farmers and Field officers via online. Agri field officers can contact with paddy farmers and Agri experts easily.\n\nSmart Agri currently offers a range of Agri services including experts connection sessions at Agriculture department , E-Community , News and videos.",
                    style: TextStyle(
                      fontSize: size.width * 0.039,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
