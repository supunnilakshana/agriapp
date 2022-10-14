import 'package:agriapp/components/errorpage.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/models/usermodel.dart';
import 'package:agriapp/screens/home/home_screen.dart';
import 'package:agriapp/services/firebase/fb_handeler.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoadUserData extends StatefulWidget {
  const LoadUserData({
    Key? key,
  }) : super(key: key);
  @override
  _LoadUserDataState createState() => _LoadUserDataState();
}

class _LoadUserDataState extends State<LoadUserData> {
  late Future<UserModel> futureData;

  @override
  void initState() {
    super.initState();
    futureData = FbHandeler.getUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: futureData,
      builder: (context, snapshot) {
        print(snapshot.hasData);
        if (snapshot.hasData) {
          UserModel data = snapshot.data as UserModel;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<UserModel>().updateData(data);
          });

          return const HomeScreen();
        } else if (snapshot.hasError) {
          return Errorpage(size: size.width * 0.7);
        }
        // By default show a loading spinner.
        return Scaffold(
          backgroundColor: kPrimaryColorlight,
          body: Center(
              child: Lottie.asset("assets/animations/loadinganimi.json",
                  width: size.width * 0.6)),
        );
      },
    );
  }

  loaddata() async {
    futureData = FbHandeler.getUser();
    setState(() {});
  }
}
