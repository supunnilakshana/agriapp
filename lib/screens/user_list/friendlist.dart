import 'dart:math';

import 'package:agriapp/components/popup_dilog.dart';
import 'package:agriapp/components/roundedtextFiled.dart';
import 'package:agriapp/components/tots.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/constants/initdata.dart';
import 'package:agriapp/models/usermodel.dart';
import 'package:agriapp/screens/home/drawer_item/schedule_ap.dart';
import 'package:agriapp/services/firebase/fb_handeler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

import '../Chat/components/singel_chat.dart';

class Friendlist extends StatefulWidget {
  final String role;
  const Friendlist({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  _FriendlistState createState() => _FriendlistState();
}

class _FriendlistState extends State<Friendlist> {
  late Future<List<UserModel>> futureData;
  String searchvalue = "";

  @override
  void initState() {
    super.initState();
    futureData = FbHandeler.getalluserspec(widget.role);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Container(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedInput(
                  onchange: (text) {
                    setState(() {
                      searchvalue = text;
                    });
                    print("Search text -------" + searchvalue);
                  },
                  valid: (text) {},
                  save: (text) {},
                  hintText: "Search new ${getpossition(widget.role)}s...",
                  icon: LineIcons.search,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.01),
                  child: Container(
                      decoration: BoxDecoration(
                          // color: kprimarylightcolor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 0.05))),
                      width: size.width * 0.15,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.008),
                        child: IconButton(
                          icon: Icon(
                            LineIcons.searchengin,
                            color: kPrimaryColordark,
                            size: size.width * 0.1,
                          ),
                          onPressed: () {},
                        ),
                      )),
                )
              ],
            ),
          ),
          FutureBuilder(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<UserModel> tempdata = snapshot.data as List<UserModel>;
                List<UserModel> data = [];
                print(data);
                if (searchvalue.isEmpty) {
                  data = snapshot.data as List<UserModel>;
                } else {
                  data = tempdata
                      .where((element) => element.name
                          .toLowerCase()
                          .contains(searchvalue.toLowerCase()))
                      .toList();
                }
                if (data.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            itemCount: data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, indext) {
                              String titel;

                              print(data[indext].name);
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width * 0.05))),
                                color: kPrimaryColorlight,
                                child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 10.0),
                                    leading: Container(
                                        width: size.width * 0.15,
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          fit: StackFit.expand,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  kPrimaryColorlight,
                                              radius: size.width * 0.1,
                                              backgroundImage: NetworkImage(
                                                data[indext].imageurl != ""
                                                    ? data[indext].imageurl
                                                    : guserimg,
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: indext % 2 == 0 &&
                                                        int.parse(data[indext]
                                                                .role) ==
                                                            UserRole
                                                                .expert.index
                                                    ? Image.asset(
                                                        "assets/icons/batch1.png",
                                                        width:
                                                            size.width * 0.055,
                                                      )
                                                    : Container())
                                          ],
                                        )),
                                    title: Text(
                                      data[indext].name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: kBasefontColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.037),
                                    ),
                                    subtitle: Row(children: [
                                      Expanded(
                                        child: Text(
                                            getpossition(data[indext].role),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: kBasefontColor
                                                    .withOpacity(0.7))),
                                      ),
                                    ]),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return ScheduleAp(
                                                    userModel: data[indext],
                                                    val: "1",
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.call,
                                            color:
                                                kBasefontColor.withOpacity(0.6),
                                          ),
                                          color: Colors.black.withOpacity(0.5),
                                          iconSize: size.width * 0.07,
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return ScheduleAp(
                                                    userModel: data[indext],
                                                    val: "2",
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.video_call_rounded,
                                            color:
                                                kBasefontColor.withOpacity(0.6),
                                          ),
                                          color: Colors.black.withOpacity(0.5),
                                          iconSize: size.width * 0.07,
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            reloaddata();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SingelChatScreen(
                                                          rid:
                                                              data[indext].uid!,
                                                          email: data[indext]
                                                              .email,
                                                          name:
                                                              data[indext].name,
                                                          userModel:
                                                              data[indext],
                                                        )));
                                            print(data[indext].uid);
                                          },
                                          icon: Icon(Icons.message_rounded),
                                          color:
                                              kBasefontColor.withOpacity(0.6),
                                          iconSize: size.width * 0.06,
                                        ),
                                      ],
                                    )),
                              );
                            })),
                  );
                } else {
                  return Container(
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: size.height * 0.02,
                              left: size.width * 0.035),
                          child: Text(
                            "You have no ${getpossition(widget.role)}s!!",
                            style: TextStyle(
                                color: kBasefontColor.withOpacity(0.8),
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          child: Lottie.asset(
                              "assets/animations/nofriends.json",
                              width: size.width * 0.6),
                        )
                      ],
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default show a loading spinner.
              return Center(
                  child: Lottie.asset("assets/animations/loadinganimi.json",
                      width: size.height * 0.2));
            },
          ),
        ],
      ),
    );
  }

  reloaddata() {
    setState(() {
      futureData = FbHandeler.getalluserspec(widget.role);
    });
  }
}
