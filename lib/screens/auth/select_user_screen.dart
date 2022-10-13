import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/screens/auth/sign_up_famer.dart';
import 'package:flutter/material.dart';

class SelectUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          "assets/images/sbackjpg.jpg",
          height: double.infinity,
          width: size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Who are you ?  ",
                style: TextStyle(
                    fontSize: size.width * 0.06, color: Colors.black87),
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  GestureDetector(
                    child: SelectpetItem(
                      img: "assets/icons/farmer.png",
                      titel: "Farmer",
                      size: size,
                    ),
                    onTap: () {
                      print("dog");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignUpFamer();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  GestureDetector(
                    child: SelectpetItem(
                      img: "assets/icons/officer.png",
                      titel: "Feild Officer",
                      size: size,
                    ),
                    onTap: () {
                      print("dog");
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return AddPetscreen(0);
                      //     },
                      //   ),
                      // );
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  GestureDetector(
                      child: SelectpetItem(
                        img: "assets/icons/expert.png",
                        titel: "Expert",
                        size: size,
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return AddPetscreen(1);
                        //     },
                        //   ),
                        // );
                      })
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SelectpetItem extends StatelessWidget {
  final String titel;
  final String img;
  const SelectpetItem({
    Key? key,
    required this.size,
    required this.titel,
    this.img = "assets/icons/farmer.png",
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.25,
        right: size.width * 0.25,
      ),
      child: Container(
        width: size.width * 0.6,
        decoration: BoxDecoration(
          color: kPrimaryColordark.withOpacity(0.7),
          borderRadius: BorderRadius.all(Radius.circular(size.width * 0.05)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.green,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 0.05)),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.blueGrey.shade100,
                  //     blurRadius: 2.0, // has the effect of softening the shadow
                  //     spreadRadius:
                  //         2.0, // has the effect of extending the shadow
                  //     offset: const Offset(
                  //       3.0, // horizontal, move right 10
                  //       3.0, // vertical, move down 10
                  //     ),
                  //   )
                  // ],
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 0.05)),
                  child: Image.asset(
                    img,
                    width: size.width * 0.4,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.005, bottom: size.height * 0.005),
              child: Text(
                titel,
                style: TextStyle(
                    fontSize: size.width * 0.06,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
