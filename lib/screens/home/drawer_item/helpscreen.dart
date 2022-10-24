import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:agriapp/components/roundedtextFiled.dart';
import 'package:agriapp/components/tots.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/constants/initdata.dart';
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
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../components/popup_dilog.dart';
import 'package:path/path.dart' as p;

class HelpScreen extends StatefulWidget {
  final bool isnew;

  const HelpScreen({
    Key? key,
    this.isnew = true,
  }) : super(key: key);
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> with AnimationMixin {
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
  final ScrollController _scrollController = ScrollController();

  late Future<int> futureData;
  int chatcreate = 0;
  bool islike = false;
  @override
  void initState() {
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
    var userModel = Provider.of<UserModel>(context);
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            titleSpacing: 0,
            leading: BackButton(
              color: Colors.white.withOpacity(0.8),
            ),
            title: Text(
              "Help",
              style: TextStyle(color: Colors.white.withOpacity(0.75)),
            ),
            backgroundColor: kPrimaryColordark,
          ),
          body: isdeleing
              ? Center(
                  child: Lottie.asset("assets/animations/loadinganimi.json",
                      width: size.width * 0.1),
                )
              : Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: size.height,
                  width: size.width,
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              controller: _scrollController,
                              // physics: ClampingScrollPhysics(),
                              // keyboardDismissBehavior:
                              //     ScrollViewKeyboardDismissBehavior
                              //         .onDrag,
                              itemCount: 1,
                              itemBuilder: (context, indext) {
                                return CommetItem(
                                  size: size,
                                  des:
                                      "Hi👋, I'm smart agri agent. What would you like to know? 🤔",
                                  name: 'Smart Agri Agent',
                                  url: guserimg,
                                );
                              })),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Card(
                          color: kPrimaryColorlight,
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
                                                            'Type your a message...',
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

class CommetItem extends StatefulWidget {
  final String name;
  final String url;
  final String des;
  const CommetItem({
    Key? key,
    required this.size,
    required this.name,
    required this.url,
    required this.des,
  }) : super(key: key);

  final Size size;

  @override
  State<CommetItem> createState() => _CommetItemState();
}

class _CommetItemState extends State<CommetItem> {
  bool islike = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 8, right: 30),
      child: Card(
        elevation: 0,
        color: kPrimaryColorlight,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(widget.size.width * 0.02)),
        ),
        child: ListTile(
          leading: Container(
              child: Container(
            child: CircleAvatar(
              backgroundColor: kPrimaryColorlight,
              radius: widget.size.width * 0.05,
              backgroundImage: NetworkImage(
                widget.url,
              ),
            ),
          )),
          title: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              widget.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: kBasefontColor,
                  fontWeight: FontWeight.w700,
                  fontSize: widget.size.width * 0.032),
            ),
          ),
          subtitle: Column(
            children: [
              Row(children: [
                Expanded(
                  child: Text(widget.des,
                      maxLines: 8,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: widget.size.width * 0.038,
                          color: kBasefontColor.withOpacity(0.8))),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    Text(
                      "just now",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: kBasefontColor.withOpacity(0.7)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: GestureDetector(
                        child: islike
                            ? LineIcon.heartAlt(
                                size: 22,
                                color: Colors.green.shade600.withOpacity(0.9))
                            : LineIcon.heart(
                                size: 22, color: Colors.black.withOpacity(0.7)),
                        onTap: () {
                          if (islike == false) {
                            islike = true;
                          } else {
                            islike = false;
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PathModel {
  final String id;
  final String path;

  PathModel({required this.id, required this.path});
}
