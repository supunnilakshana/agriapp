import 'package:agriapp/components/popup_dilog.dart';
import 'package:agriapp/components/roundedtextFiled.dart';
import 'package:agriapp/components/tots.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/constants/initdata.dart';
import 'package:agriapp/models/usermodel.dart';
import 'package:agriapp/screens/Chat/components/singel_chat.dart';
import 'package:agriapp/services/firebase/fb_handeler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

import '../../home/drawer_item/schedule_ap.dart';

class ChatList extends StatefulWidget {
  const ChatList({
    Key? key,
  }) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  late Future<List<UserModel>> futureData;
  String searchvalue = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.08,
          ),
          SizedBox(
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
                  hintText: "Search chats...",
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
          Expanded(
            child: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref("users/${FbHandeler.user!.uid}/chatbox")
                  .onValue,
              builder: (context, snapshot) {
                List<String> chatkeyList = [];
                if (snapshot.hasData) {
                  if ((snapshot.data as DatabaseEvent).snapshot.value != null) {
                    final mydata = Map<dynamic, dynamic>.from(
                        (snapshot.data as DatabaseEvent).snapshot.value
                            as Map<dynamic, dynamic>);
                    mydata.forEach((key, value) {
                      // msgList = [];
                      // print(value);

                      if (chatkeyList.contains(key) == false) {
                        chatkeyList.add(key);
                      }
                    });
                    List<String> data = [];

                    if (chatkeyList.isNotEmpty) {
                      return Container(
                          child: ListView.builder(
                              itemCount: chatkeyList.length,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, indext) {
                                late Future<UserModel> fdata;
                                fdata =
                                    FbHandeler.getUserid(chatkeyList[indext]);
                                return FutureBuilder(
                                    future: fdata,
                                    builder: (context, snapshot1) {
                                      if (snapshot1.hasData) {
                                        UserModel userModel;
                                        userModel = snapshot1.data as UserModel;
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SingelChatScreen(
                                                          rid: userModel.uid!,
                                                          email:
                                                              userModel.email,
                                                          name: userModel.name,
                                                          userModel: userModel,
                                                        )));
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        size.width * 0.05))),
                                            color: kPrimaryColorlight,
                                            child: ListTile(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0,
                                                        vertical: 10.0),
                                                leading: Container(
                                                    child: Container(
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        kPrimaryColorlight,
                                                    radius: size.width * 0.1,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      userModel.imageurl != ""
                                                          ? userModel.imageurl
                                                          : guserimg,
                                                    ),
                                                  ),
                                                )),
                                                title: Text(
                                                  userModel.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: kBasefontColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          size.width * 0.037),
                                                ),
                                                subtitle: Row(children: [
                                                  Expanded(
                                                    child: Text(
                                                        getpossition(
                                                            userModel.role),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: false,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: kBasefontColor
                                                                .withOpacity(
                                                                    0.7))),
                                                  ),
                                                ]),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () async {
                                                        PopupDialog
                                                            .choosecallDilog(
                                                                context,
                                                                userModel);
                                                      },
                                                      icon: Icon(
                                                        Icons.call,
                                                        color: kBasefontColor
                                                            .withOpacity(0.6),
                                                      ),
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      iconSize:
                                                          size.width * 0.07,
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return ScheduleAp(
                                                                userModel:
                                                                    userModel,
                                                                val: "1",
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .date_range_outlined,
                                                        color: kBasefontColor
                                                            .withOpacity(0.6),
                                                      ),
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      iconSize:
                                                          size.width * 0.07,
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {
                                                        // reloaddata();
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        SingelChatScreen(
                                                                          rid: userModel
                                                                              .uid!,
                                                                          email:
                                                                              userModel.email,
                                                                          name:
                                                                              userModel.name,
                                                                          userModel:
                                                                              userModel,
                                                                        )));
                                                        print(userModel.uid);
                                                      },
                                                      icon: const Icon(Icons
                                                          .message_rounded),
                                                      color: kBasefontColor
                                                          .withOpacity(0.6),
                                                      iconSize:
                                                          size.width * 0.06,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    });
                              }));
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
                                "You have no chats!!",
                                style: TextStyle(
                                    color: kBasefontColor.withOpacity(0.8),
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              child: Lottie.asset(
                                  "assets/animations/nofriendwhite.json",
                                  width: size.width * 0.6),
                            )
                          ],
                        ),
                      );
                    }
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
                              "You have no chats!!",
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
                        width: size.height * 0.18));
              },
            ),
          )
        ],
      ),
    );
  }
}
