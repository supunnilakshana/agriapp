import 'package:agriapp/components/popup_dilog.dart';
import 'package:agriapp/components/roundedtextFiled.dart';
import 'package:agriapp/components/tots.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/constants/initdata.dart';
import 'package:agriapp/models/usermodel.dart';
import 'package:agriapp/screens/Chat/components/singel_chat.dart';
import 'package:agriapp/screens/home/drawer_item/addtimeslot.dart';
import 'package:agriapp/screens/home/drawer_item/schedule_ap.dart';
import 'package:agriapp/services/firebase/fb_handeler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  late Future<List<UserModel>> futureData;
  String searchvalue = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var userModel = Provider.of<UserModel>(context);
    return Scaffold(
      floatingActionButton:
          int.parse(userModel.role) == UserRole.expert.index ||
                  int.parse(userModel.role) == UserRole.fofficer.index
              ? FloatingActionButton.extended(
                  backgroundColor: kPrimaryColordark,
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AddFreeTimeSlots();
                        },
                      ),
                    );
                  },
                  label: Text("Add a time slot"))
              : Container(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "My Appointments",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.transparent,
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
                    hintText: "Search appointments...",
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
            StreamBuilder(
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
                                                subtitle: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2, bottom: 2),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 0,
                                                                bottom: 8),
                                                        child: Row(children: [
                                                          Expanded(
                                                            child: Text(
                                                                "(${getpossition(userModel.role)})",
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                softWrap: false,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: kBasefontColor
                                                                        .withOpacity(
                                                                            0.7))),
                                                          ),
                                                        ]),
                                                      ),
                                                      Row(children: [
                                                        Expanded(
                                                          child: Text(
                                                              "Time : 8.00 - 9.00",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: false,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: kBasefontColor
                                                                      .withOpacity(
                                                                          0.7))),
                                                        ),
                                                      ]),
                                                      Row(children: [
                                                        Expanded(
                                                          child: Text(
                                                              "Date : 20/11/2019",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: false,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: kBasefontColor
                                                                      .withOpacity(
                                                                          0.7))),
                                                        ),
                                                      ]),
                                                      Row(children: [
                                                        Expanded(
                                                          child: Text(
                                                              "Type : Video",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: false,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: kBasefontColor
                                                                      .withOpacity(
                                                                          0.7))),
                                                        ),
                                                      ]),
                                                      Text(
                                                          "I'm writing to invite you to a meeting on to discuss green concept. ",
                                                          maxLines: 4,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: kBasefontColor
                                                                  .withOpacity(
                                                                      0.7))),
                                                    ],
                                                  ),
                                                ),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () async {
                                                        PopupDialog.showPopupDilog(
                                                            context,
                                                            "Join meeting",
                                                            "Are you sure join this meeting ?",
                                                            () {
                                                          Customtost.commontost(
                                                              "Sended",
                                                              Colors.green);
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.add_box_outlined,
                                                        color: kBasefontColor
                                                            .withOpacity(0.6),
                                                      ),
                                                      color: kPrimaryColordark
                                                          .withOpacity(0.8),
                                                      iconSize:
                                                          size.width * 0.06,
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
                                                          .message_outlined),
                                                      color: kBasefontColor
                                                          .withOpacity(0.6),
                                                      iconSize:
                                                          size.width * 0.055,
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {},
                                                      icon: Icon(
                                                        Icons.close,
                                                        color: kBasefontColor
                                                            .withOpacity(0.6),
                                                      ),
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      iconSize:
                                                          size.width * 0.065,
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
                                "You have no appointments!!",
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
                              "You have no appointments!!",
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
            )
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2035),
    );
    if (selected != null) setState(() {});
  }
}
