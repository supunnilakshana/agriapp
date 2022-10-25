import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:agriapp/components/roundedtextFiled.dart';
import 'package:agriapp/components/tots.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/models/msgModel.dart';
import 'package:agriapp/models/usermodel.dart';
import 'package:agriapp/screens/Chat/components/singelFileItem.dart';
import 'package:agriapp/screens/Chat/components/singelImgItem.dart';
import 'package:agriapp/screens/Chat/components/singelMsg.dart';
import 'package:agriapp/services/date_time/date.dart';
import 'package:agriapp/services/firebase/fb_handeler.dart';
import 'package:agriapp/services/upload/file_upload.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../components/popup_dilog.dart';
import 'package:path/path.dart' as p;

import '../../calling_ui/dialScreen/dial_screen.dart';

class SingelChatScreen extends StatefulWidget {
  final bool isnew;
  final String email;
  final String rid;
  final String name;
  final UserModel userModel;

  const SingelChatScreen({
    Key? key,
    this.isnew = true,
    required this.email,
    required this.rid,
    required this.name,
    required this.userModel,
  }) : super(key: key);
  @override
  _SingelChatScreenState createState() => _SingelChatScreenState();
}

class _SingelChatScreenState extends State<SingelChatScreen>
    with AnimationMixin {
  // final dbRef = FirebaseDatabase.instance.ref(
  //     "users/" +FbHandeler.user!.uid + "/" + "chatbox" + "/" + widget.rid);
  bool isfirsttap = true;
  String sends = "f";
  String titel = "";
  String message = " ";
  bool isdeleing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mobileNocon = TextEditingController();
  // TextEditingController textController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool isnewchat = false;
  late Future<int> futureData;
  int chatcreate = 0;

  settitel() {
    if (widget.name == "") {
      titel = widget.email;
    } else {
      titel = widget.name;
    }
    setState(() {});
  }

  @override
  void initState() {
    settitel();
    futureData = FbHandeler.checkfiledstatus(
        "users/${FbHandeler.user!.uid}/chatbox/${widget.rid}");
    setState(() {});

    slideInputController = createController()
      ..duration = const Duration(milliseconds: 500);

    slideInputAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-2, 0),
    ).animate(slideInputController);

    opacity = Tween<double>(begin: 1, end: 0).animate(controller);
    controller.duration = const Duration(milliseconds: 200);
    super.initState();
  }

  bool isdownloading = false;
  bool isdownload = false;
  int nochat = 0;
  List<PathModel> pathlist = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final scolor = Colors.green.shade200;
    final rcolor = Colors.blueGrey.shade200;
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          // backgroundColor: Colors.,
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            titleSpacing: 0,
            leading: BackButton(
              color: Colors.white.withOpacity(0.8),
            ),
            title: ListTile(
              onTap: () {},
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.userModel.imageurl,
                ),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      titel,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              subtitle: Text('last seen yesterday at 21:05',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w400)),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: size.width * 0.03,
                ),
                child: GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DialScreen(
                              iurl: widget.userModel.imageurl,
                              name: widget.userModel.name,
                            );
                          },
                        ),
                      );
                    },
                    child: Icon(
                      Icons.videocam,
                      size: size.width * 0.07,
                      color: Colors.white.withOpacity(0.8),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: size.width * 0.06,
                ),
                child: GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DialScreen(
                              iurl: widget.userModel.imageurl,
                              name: widget.userModel.name,
                            );
                          },
                        ),
                      );
                    },
                    child: Icon(
                      Icons.call,
                      size: size.width * 0.06,
                      color: Colors.white.withOpacity(0.8),
                    )),
              ),
            ],
            backgroundColor: kPrimaryColordark,
          ),
          body: isdeleing
              ? Center(
                  child: Lottie.asset(
                      "assets/animations/loadinganimi.json.json",
                      width: size.width * 0.1),
                )
              : Container(
                  decoration: const BoxDecoration(
                    color: kPrimaryColorlight,
                  ),
                  height: size.height,
                  width: size.width,
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        child: FutureBuilder(
                          future: futureData,
                          builder: (context, snapshot1) {
                            if (snapshot1.hasData) {
                              int data1 = snapshot1.data as int;
                              nochat = data1;
                              chatcreate = data1;
                              print(nochat);
                              if (nochat == 0) {
                                return StreamBuilder(
                                  stream: FirebaseDatabase.instance
                                      .ref(
                                          "users/${FbHandeler.user!.uid}/chatbox/${widget.rid}")
                                      .onValue,
                                  builder: (context, snapshot) {
                                    print(
                                        "users/${FbHandeler.user!.uid}/chatbox/${widget.rid}");
                                    List<MsgModel> msgList = [];

                                    if (snapshot.hasData) {
                                      // List<MsgModel> data =
                                      //     snapshot.data as List<MsgModel>;
                                      // print(data.length);
                                      if (snapshot.data != null) {
                                        print("object");
                                        final myMessages =
                                            Map<dynamic, dynamic>.from((snapshot
                                                        .data! as DatabaseEvent)
                                                    .snapshot
                                                    .value
                                                as Map<dynamic, dynamic>);

                                        // print(myMessages);
                                        MsgModel mModel;

                                        myMessages.forEach((key, value) {
                                          // msgList = [];
                                          // print(value);
                                          Map<dynamic, dynamic> map =
                                              value as Map<dynamic, dynamic>;
                                          mModel = MsgModel.fromMap(map);
                                          if (msgList.contains(mModel.id) ==
                                              false) {
                                            msgList.add(mModel);
                                          }
                                        });
                                        msgList.sort((b, a) => b.datetimeid
                                            .compareTo(a.datetimeid));
                                      }
                                      if (msgList.isNotEmpty) {
                                        return ListView.builder(
                                            controller: _scrollController,
                                            // physics: ClampingScrollPhysics(),
                                            // keyboardDismissBehavior:
                                            //     ScrollViewKeyboardDismissBehavior
                                            //         .onDrag,
                                            itemCount: msgList.length,
                                            itemBuilder: (context, indext) {
                                              if (msgList[indext].sendemail ==
                                                  FbHandeler.user!.email!) {
                                                if (msgList[indext].msgtype ==
                                                    "file") {
                                                  String defilepath = "no--";
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        top: size.height * 0.01,
                                                        left: size.width * 0.25,
                                                        right: 8),
                                                    child: SingelFileItem(
                                                        msgModel:
                                                            msgList[indext],
                                                        pcolor: scolor),
                                                  );
                                                } else if (msgList[indext]
                                                        .msgtype ==
                                                    "tmsg") {
                                                  return SingelMsg(
                                                    mcolor: scolor,
                                                    msgModel: msgList[indext],
                                                    align:
                                                        CrossAxisAlignment.end,
                                                  );
                                                } else if (msgList[indext]
                                                        .msgtype ==
                                                    "img") {
                                                  return SingelImgItem(
                                                      align: CrossAxisAlignment
                                                          .end,
                                                      msgModel: msgList[indext],
                                                      pcolor: scolor,
                                                      pleft: size.width * 0.25,
                                                      pright:
                                                          size.width * 0.03);
                                                } else {
                                                  return Container();
                                                }
                                              } else {
                                                if (msgList[indext].msgtype ==
                                                    "file") {
                                                  String defilepath = "";
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        top: size.height * 0.01,
                                                        left: 8,
                                                        right:
                                                            size.width * 0.25),
                                                    child: SingelFileItem(
                                                      msgModel: msgList[indext],
                                                      pcolor: rcolor,
                                                    ),
                                                  );
                                                } else if (msgList[indext]
                                                        .msgtype ==
                                                    "tmsg") {
                                                  return SingelMsg(
                                                    mcolor: rcolor,
                                                    msgModel: msgList[indext],
                                                    align: CrossAxisAlignment
                                                        .start,
                                                  );
                                                } else if (msgList[indext]
                                                        .msgtype ==
                                                    "img") {
                                                  return SingelImgItem(
                                                      align: CrossAxisAlignment
                                                          .start,
                                                      msgModel: msgList[indext],
                                                      pcolor: rcolor,
                                                      pleft: size.width * 0.03,
                                                      pright:
                                                          size.width * 0.25);
                                                } else {
                                                  return Container();
                                                }
                                              }
                                            });
                                      } else {
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Lottie.asset(
                                                      "assets/animations/startchat.json",
                                                      width: size.width * 0.9),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    // By default show a loading spinner.
                                    return Center(
                                        child: Lottie.asset(
                                            "assets/animations/loadinganimi.json",
                                            width: size.height * 0.15));
                                  },
                                );
                              } else {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Lottie.asset(
                                                "assets/animations/startchat.json",
                                                width: size.width * 0.9),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            } else if (snapshot1.hasError) {
                              return Text("${snapshot1.error}");
                            }
                            // By default show a loading spinner.
                            return Center(
                                child: Lottie.asset(
                                    "assets/animations/loadinganimi.json",
                                    width: size.height * 0.15));
                          },
                        ),
                      )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Card(
                          color: const Color.fromARGB(255, 184, 226, 201),
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 8,
                                left: 8,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom > 0
                                        ? 5
                                        : 8,
                                top: 8),
                            child: Column(
                              children: [
                                isfileload
                                    ? isimg
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)),
                                              color: kPrimaryColorlight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: isfilesending
                                                          ? Lottie.asset(
                                                              "assets/animations/filesuploading.json",
                                                              width:
                                                                  size.width *
                                                                      0.1)
                                                          : GestureDetector(
                                                              onTap: () {
                                                                isfileload =
                                                                    false;
                                                                isfilesending =
                                                                    false;
                                                                isimg = false;
                                                                setState(() {});
                                                              },
                                                              child: const Icon(
                                                                  Icons.close)),
                                                    ),
                                                    Container(
                                                      height: size.height * 0.5,
                                                      width: size.width * 0.7,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                        child: Image.file(
                                                          sendfile!,
                                                          // height: size.height * 0.5,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(fileName),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)),
                                              color: kPrimaryColorlight,
                                              child: ListTile(
                                                leading: const Icon(
                                                  Icons.file_present_outlined,
                                                ),
                                                title: Text(fileName),
                                                trailing: isfilesending
                                                    ? Lottie.asset(
                                                        "assets/animations/filesuploading.json",
                                                        width: size.width * 0.1)
                                                    : GestureDetector(
                                                        onTap: () {
                                                          isfileload = false;
                                                          isfilesending = false;
                                                          isimg = false;
                                                          setState(() {});
                                                        },
                                                        child: const Icon(
                                                            Icons.close)),
                                              ),
                                            ),
                                          )
                                    : Container(),
                                Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: SlideTransition(
                                            position: slideInputAnimation,
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    _chooeseFile();
                                                  },
                                                  child: Icon(
                                                    Icons.attach_file,
                                                    color: Colors.grey.shade700,
                                                    size: 23,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    _showPicker(context);
                                                  },
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.grey.shade700,
                                                    size: 23,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    child: TextField(
                                                      controller:
                                                          textController,
                                                      minLines: 1,
                                                      maxLines: 5,
                                                      cursorColor:
                                                          kPrimaryColordark,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 16,
                                                                left: 20,
                                                                bottom: 12,
                                                                top: 12),
                                                        hintStyle: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .grey.shade700),
                                                        hintText:
                                                            'Type a message...',
                                                        border:
                                                            InputBorder.none,
                                                        filled: true,
                                                        fillColor: Colors
                                                            .grey.shade100,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          gapPadding: 0,
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .shade200),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          gapPadding: 0,
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .shade300),
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        if (value.isNotEmpty) {
                                                          hideTheMic();
                                                        } else {
                                                          showTheMic();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Visibility(
                                              visible: isVisible,
                                              child: FadeTransition(
                                                opacity: opacity,
                                                child: Icon(
                                                  Icons.mic,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              splashRadius: 20,
                                              color: kPrimaryColordark,
                                              icon: Icon(
                                                Icons.send,
                                                color: isVisible
                                                    ? Colors.grey.shade700
                                                    : kPrimaryColordark,
                                              ),
                                              onPressed: isfilesending
                                                  ? () {
                                                      setscroll();
                                                      Customtost.commontost(
                                                          "file sending..",
                                                          kPrimaryColordark);
                                                    }
                                                  : () async {
                                                      setscroll();
                                                      // print(msgList.length);
                                                      print("pressed");

                                                      if (isfileload) {
                                                        setState(() {
                                                          isfilesending = true;
                                                        });
                                                        print("press");

                                                        final extension =
                                                            p.extension(
                                                                sendfile!.path);

                                                        print(extension);
                                                        String id = FbHandeler
                                                                .user!.uid +
                                                            Date.getDateTimeId();
                                                        String vlink =
                                                            await FileUploader
                                                                .uploadData(
                                                                    sendfile!,
                                                                    id +
                                                                        extension);
                                                        print(vlink);

                                                        if (vlink != "false") {
                                                          MsgModel modelM = MsgModel(
                                                              fname: fileName,
                                                              id: id,
                                                              sendemail:
                                                                  FbHandeler
                                                                      .user!
                                                                      .email!,
                                                              reciveemail:
                                                                  widget.email,
                                                              message: vlink,
                                                              msgtype: mesgtype,
                                                              datetime: Date
                                                                  .getStringdatetimenow(),
                                                              datetimeid: Date
                                                                  .getDateTimeId(),
                                                              sendid: FbHandeler
                                                                  .user!.uid,
                                                              reciveid:
                                                                  widget.rid);

                                                          int res1 =
                                                              await FbHandeler
                                                                  .sendMsgs(
                                                                      modelM);
                                                          if (res1 == 1) {
                                                            isfileload = false;
                                                            isfilesending =
                                                                false;
                                                            isimg = false;
                                                            setState(() {});
                                                            loaddata();
                                                            setscroll();
                                                          } else {
                                                            setState(() {
                                                              isfilesending =
                                                                  false;
                                                            });
                                                            Customtost.commontost(
                                                                "Sending failed",
                                                                Colors
                                                                    .redAccent);
                                                          }
                                                        } else {
                                                          setState(() {
                                                            isfilesending =
                                                                false;
                                                          });
                                                          Customtost.commontost(
                                                              "Sending failed",
                                                              Colors.redAccent);
                                                        }
                                                      } else {
                                                        if (textController
                                                            .text.isNotEmpty) {
                                                          final id = FbHandeler
                                                                  .user!.uid +
                                                              Date.getDateTimeId();

                                                          MsgModel modelM = MsgModel(
                                                              id: id,
                                                              sendemail:
                                                                  FbHandeler
                                                                      .user!
                                                                      .email!,
                                                              reciveemail:
                                                                  widget.email,
                                                              message:
                                                                  textController
                                                                      .text,
                                                              msgtype: "tmsg",
                                                              datetime: Date
                                                                  .getStringdatetimenow(),
                                                              datetimeid: Date
                                                                  .getDateTimeId(),
                                                              sendid: FbHandeler
                                                                  .user!.uid,
                                                              reciveid:
                                                                  widget.rid);

                                                          await FbHandeler
                                                              .sendMsgs(modelM);
                                                          print("done");
                                                          nochat = 1;

                                                          textController
                                                              .clear();
                                                          showTheMic();
                                                          loaddata();
                                                          setscroll();
                                                          setState(() {});
                                                        }
                                                      }
                                                      if (_formKey.currentState!
                                                          .validate()) {}
                                                    },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  final textController = TextEditingController();

  late Animation<double> opacity;
  late AnimationController slideInputController;
  late Animation<Offset> slideInputAnimation;
  var isVisible = true;
  hideTheMic() {
    controller.play();
    controller.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed && isVisible) {
          isVisible = false;
        }
      });
    });
  }

  showTheMic() {
    isVisible = true;
    controller.reverse();
  }

  loaddata() async {
    futureData = FbHandeler.checkfiledstatus(
        "users/${FbHandeler.user!.uid}/chatbox/${widget.rid}");

    setState(() {});
    if (mounted) {
      setState(() {});
    }
  }

  File? sendfile;
  String fileExtesnsion = "";
  String fileName = "";
  bool isfileload = false;
  bool isfilesending = false;
  bool isimg = false;
  String mesgtype = "file";

  _chooeseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        sendfile = file;

        final path = file.path;
        print(path);
        final extension = p.extension(path);
        fileExtesnsion = extension;
        mesgtype = "file";
        print(extension);
        fileName = path.split('/').last;

        isfileload = true;
        print("okkkkkkkkkkkk");

        // widget.onimgfileChanged(base64Image);
      });
    } else {
      // User canceled the picker
    }
  }

  XFile? imgfile;
  final ImagePicker _picker = ImagePicker();
  _imgFromGallery() async {
    XFile? img =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 65);

    if (img != null) {
      setState(() {
        imgfile = img;
        sendfile = File(imgfile!.path);
        final path = imgfile!.path;
        print(path);
        final extension = p.extension(path);
        fileExtesnsion = extension;
        mesgtype = "img";
        print(extension);
        fileName = path.split('/').last;
        isfileload = true;
        isimg = true;
        print("okkkkkkkkkkkk");

        // widget.onimgfileChanged(base64Image);
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: const Color.fromARGB(255, 184, 226, 201),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library_outlined),
                      title: const Text('Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    XFile? img =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    if (img != null) {
      setState(() {
        imgfile = img;
        sendfile = File(imgfile!.path);
        final path = imgfile!.path;
        print(path);
        final extension = p.extension(path);
        fileExtesnsion = extension;
        mesgtype = "img";
        print(extension);
        fileName = path.split('/').last;
        isfileload = true;
        isimg = true;
        print("okkkkkkkkkkkk");

        // widget.onimgfileChanged(base64Image);
      });
    }
  }

  setscroll() {
    if (_scrollController.hasClients) {
      print("has------------------");
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}

class PathModel {
  final String id;
  final String path;

  PathModel({required this.id, required this.path});
}












 // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Column(
                      //       children: [
                      //         isfileload
                      //             ? isimg
                      //                 ? Padding(
                      //                     padding: const EdgeInsets.only(
                      //                         left: 8, right: 8),
                      //                     child: Card(
                      //                       shape: RoundedRectangleBorder(
                      //                           borderRadius:
                      //                               BorderRadius.circular(
                      //                                   15.0)),
                      //                       color: kPrimaryColordark,
                      //                       child: Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(8.0),
                      //                         child: Column(
                      //                           children: [
                      //                             Align(
                      //                               alignment:
                      //                                   Alignment.topRight,
                      //                               child: isfilesending
                      //                                   ? Lottie.asset(
                      //                                       "assets/animations/filesuploading.json",
                      //                                       width: size.width *
                      //                                           0.1)
                      //                                   : GestureDetector(
                      //                                       onTap: () {
                      //                                         isfileload =
                      //                                             false;
                      //                                         isfilesending =
                      //                                             false;
                      //                                         isimg = false;
                      //                                         setState(() {});
                      //                                       },
                      //                                       child: const Icon(
                      //                                           Icons.close)),
                      //                             ),
                      //                             Container(
                      //                               height: size.height * 0.5,
                      //                               width: size.width * 0.7,
                      //                               decoration: BoxDecoration(
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         15.0),
                      //                               ),
                      //                               child: ClipRRect(
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         15.0),
                      //                                 child: Image.file(
                      //                                   sendfile!,
                      //                                   // height: size.height * 0.5,
                      //                                 ),
                      //                               ),
                      //                             ),
                      //                             Padding(
                      //                               padding:
                      //                                   const EdgeInsets.all(
                      //                                       5.0),
                      //                               child: Text(fileName),
                      //                             )
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   )
                      //                 : Padding(
                      //                     padding: const EdgeInsets.only(
                      //                         left: 8, right: 8),
                      //                     child: Card(
                      //                       shape: RoundedRectangleBorder(
                      //                           borderRadius:
                      //                               BorderRadius.circular(
                      //                                   25.0)),
                      //                       color: kPrimaryColordark,
                      //                       child: ListTile(
                      //                         leading: const Icon(
                      //                           Icons.file_present_outlined,
                      //                         ),
                      //                         title: Text(fileName),
                      //                         trailing: isfilesending
                      //                             ? Lottie.asset(
                      //                                 "assets/animations/filesuploading.json",
                      //                                 width: size.width * 0.1)
                      //                             : GestureDetector(
                      //                                 onTap: () {
                      //                                   isfileload = false;
                      //                                   isfilesending = false;
                      //                                   isimg = false;
                      //                                   setState(() {});
                      //                                 },
                      //                                 child: const Icon(
                      //                                     Icons.close)),
                      //                       ),
                      //                     ),
                      //                   )
                      //             : Container(),
                      //         GestureDetector(
                      //           onTap: () {
                      //             setscroll();
                      //           },
                      //           child: Row(
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             children: [
                      //               Flexible(
                      //                 child: RoundedInputWithControll(
                      //                     textinput: TextInputType.multiline,
                      //                     controller: textController,
                      //                     icon: Icons.mic,
                      //                     onchange: (text) {
                      //                       // message = text;
                      //                       setscroll();
                      //                     },
                      //                     valid: (text) {
                      //                       return null;
                      //                     },
                      //                     save: (text) {}),
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsets.only(
                      //                     left: size.width * 0.01,
                      //                     bottom: size.height * 0.015),
                      //                 child: GestureDetector(
                      //                   onTap: () {
                      //                     _chooeseFile();
                      //                   },
                      //                   child: Icon(
                      //                     Icons.attachment,
                      //                     color:
                      //                         kBasefontColor.withOpacity(0.8),
                      //                     size: size.width * 0.08,
                      //                   ),
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsets.only(
                      //                     left: size.width * 0.01,
                      //                     bottom: size.height * 0.015),
                      //                 child: GestureDetector(
                      //                   onTap: () {
                      //                     _showPicker(context);
                      //                   },
                      //                   child: Icon(
                      //                     Icons.camera_alt_outlined,
                      //                     color:
                      //                         kBasefontColor.withOpacity(0.8),
                      //                     size: size.width * 0.06,
                      //                   ),
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsets.only(
                      //                     left: size.width * 0.01,
                      //                     bottom: size.height * 0.02),
                      //                 child: IconButton(
                      //                   color:
                      //                       kPrimaryColordark.withOpacity(0.95),
                      //                   icon: Icon(
                      //                     Icons.send_rounded,
                      //                     color: kPrimaryColordark
                      //                         .withOpacity(0.95),
                      //                     size: size.width * 0.1,
                      //                   ),
                      //                   onPressed: isfilesending
                      //                       ? () {
                      //                           setscroll();
                      //                           Customtost.commontost(
                      //                               "file sending..",
                      //                               kPrimaryColordark);
                      //                         }
                      //                       : () async {
                      //                           // setscroll();
                      //                           // // print(msgList.length);
                      //                           // print("pressed");

                      //                           // if (isfileload) {
                      //                           //   setState(() {
                      //                           //     isfilesending = true;
                      //                           //   });
                      //                           //   print("press");
                      //                           //   EncryptedItem enitem =
                      //                           //       await CryptoEncrpt
                      //                           //           .encryptFile(
                      //                           //               sendfile!);
                      //                           //   final extensionEn =
                      //                           //       p.extension(
                      //                           //           enitem.file.path);

                      //                           //   print(extensionEn);
                      //                           //   String id =
                      //                           //      FbHandeler.user!.uid +
                      //                           //           Date.getDateTimeId();
                      //                           //   String vlink =
                      //                           //       await FileUploader
                      //                           //           .uploadData(
                      //                           //               enitem.file,
                      //                           //               id + extensionEn);
                      //                           //   print(vlink);

                      //                           //   if (vlink != "false") {
                      //                           //     Keymodel keymodel = Keymodel(
                      //                           //         id: id,
                      //                           //         key: enitem.key,
                      //                           //         addeddate: Date
                      //                           //             .getDatetimenow(),
                      //                           //         extesion:
                      //                           //             fileExtesnsion);

                      //                           //     MsgModel modelM = MsgModel(
                      //                           //         fname: fileName,
                      //                           //         id: id,
                      //                           //         sendemail:
                      //                           //            FbHandeler
                      //                           //                 .user!.email!,
                      //                           //         reciveemail:
                      //                           //             widget.email,
                      //                           //         message: vlink,
                      //                           //         msgtype: mesgtype,
                      //                           //         datetime: Date
                      //                           //             .getDatetimenow(),
                      //                           //         datetimeid: Date
                      //                           //             .getDateTimeId(),
                      //                           //         sendid:FbHandeler
                      //                           //             .user!.uid,
                      //                           //         reciveid: widget.rid);
                      //                           //     int res1 =
                      //                           //         awaitFbHandeler
                      //                           //             .sendKey(modelM,
                      //                           //                 keymodel);
                      //                           //     int res2 =
                      //                           //         awaitFbHandeler
                      //                           //             .sendMsgs(modelM);
                      //                           //     if (res2 == 1 &&
                      //                           //         res2 == 1) {
                      //                           //       isfileload = false;
                      //                           //       isfilesending = false;
                      //                           //       isimg = false;
                      //                           //       setState(() {});
                      //                           //       loaddata();
                      //                           //       setscroll();
                      //                           //     } else {
                      //                           //       setState(() {
                      //                           //         isfilesending = false;
                      //                           //       });
                      //                           //       Customtost.commontost(
                      //                           //           "Sending failed",
                      //                           //           Colors.redAccent);
                      //                           //     }
                      //                           //   } else {
                      //                           //     setState(() {
                      //                           //       isfilesending = false;
                      //                           //     });
                      //                           //     Customtost.commontost(
                      //                           //         "Sending failed",
                      //                           //         Colors.redAccent);
                      //                           //   }
                      //                           // } else {
                      //                           //   if (textController
                      //                           //       .text.isNotEmpty) {
                      //                           //     final id =FbHandeler
                      //                           //             .user!.uid +
                      //                           //         Date.getDateTimeId();
                      //                           //     EnText enText =
                      //                           //         CryptoEncrpt.ecryptText(
                      //                           //             textController.text);
                      //                           //     Keymodel keymodel = Keymodel(
                      //                           //         id: id,
                      //                           //         key: enText.key,
                      //                           //         addeddate: Date
                      //                           //             .getDatetimenow(),
                      //                           //         extesion: "tmsg");

                      //                           //     MsgModel modelM = MsgModel(
                      //                           //         id: id,
                      //                           //         sendemail:
                      //                           //            FbHandeler
                      //                           //                 .user!.email!,
                      //                           //         reciveemail:
                      //                           //             widget.email,
                      //                           //         message: enText.msg,
                      //                           //         msgtype: "tmsg",
                      //                           //         datetime: Date
                      //                           //             .getDatetimenow(),
                      //                           //         datetimeid: Date
                      //                           //             .getDateTimeId(),
                      //                           //         sendid:FbHandeler
                      //                           //             .user!.uid,
                      //                           //         reciveid: widget.rid);
                      //                           //     awaitFbHandeler
                      //                           //         .sendKey(
                      //                           //             modelM, keymodel);
                      //                           //     awaitFbHandeler
                      //                           //         .sendMsgs(modelM);
                      //                           //     print("done");
                      //                           //     nochat = 1;
                      //                           //     setState(() {});
                      //                           //     textController.clear();
                      //                           //     loaddata();
                      //                           //     setscroll();
                      //                           //   }
                      //                           // }
                      //                           // if (_formKey.currentState!
                      //                           //     .validate()) {}
                      //                         },
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),