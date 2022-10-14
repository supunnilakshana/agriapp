import 'dart:io';
import 'dart:typed_data';

import 'package:agriapp/components/already_have_an_account_acheck.dart';
import 'package:agriapp/components/or_divider.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/constants/initdata.dart';
import 'package:agriapp/models/postmodel.dart';
import 'package:agriapp/models/usermodel.dart';
import 'package:agriapp/screens/auth/load_userdata.dart';
import 'package:agriapp/screens/auth/check_signIn.dart';
import 'package:agriapp/screens/auth/sign_in.dart';
import 'package:agriapp/screens/home/home_screen.dart';
import 'package:agriapp/services/auth/signin_mannager.dart';
import 'package:agriapp/services/date_time/date.dart';
import 'package:agriapp/services/firebase/fb_handeler.dart';
import 'package:agriapp/services/upload/file_upload.dart';

import 'package:agriapp/services/validator/validate_handeler.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String _passWord = "";
  String _desc = "";
  String _mobile = "";
  String _titel = "";
  String _description = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titelcon = TextEditingController();
  final TextEditingController _descriptioncon = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final usermodel = Provider.of<UserModel>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color.fromARGB(255, 8, 235, 65),
              Color.fromARGB(255, 18, 157, 59),
              Color.fromARGB(255, 7, 175, 102)
            ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Create a new post",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Share your knowledge ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: size.height * 0.01),
                    ],
                  ),
                ),
                const SizedBox(height: 1),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              width: size.width * 0.2,
                              child: GestureDetector(
                                child: Image.asset("assets/icons/addphoto.png"),
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  _imgFromGallery();
                                },
                              ),
                            ),
                            isimgload
                                ? SizedBox(
                                    width: size.width * 0.6,
                                    child: Image.file(File(_image!.path)),
                                  )
                                : Container(),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromARGB(85, 25, 167, 17),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      controller: _titelcon,
                                      onChanged: (value) {
                                        _titel = value;
                                      },
                                      validator: (value) {
                                        return Validater.genaralvalid(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "titel",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      maxLines: 12,
                                      controller: _descriptioncon,
                                      onChanged: (value) {
                                        _description = value;
                                      },
                                      validator: (value) {
                                        return Validater.genaralvalid(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "descriptioness",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  print("press login");
                                  _scaffoldKey.currentState!
                                      // ignore: deprecated_member_use
                                      .showSnackBar(SnackBar(
                                    duration: const Duration(seconds: 4),
                                    backgroundColor: kPrimaryColordark,
                                    content: Row(
                                      children: const <Widget>[
                                        CircularProgressIndicator(),
                                        Text("Creating...")
                                      ],
                                    ),
                                  ));
                                  print(_titel.trim());
                                  print(_passWord);

                                  String iurl = await _imageUpload();
                                  final user =
                                      FirebaseAuth.instance.currentUser;
                                  final pmodel = PostModel(
                                      title: _titelcon.text,
                                      context: _descriptioncon.text,
                                      addeddate: Date.getStringdatetimenow(),
                                      userid: user!.uid,
                                      user: usermodel,
                                      imageurl: iurl);
                                  int r = await FbHandeler.createDocAuto(
                                    pmodel.toMap(),
                                    CollectionPath.postpath,
                                  );
                                  // ignore: use_build_context_synchronously
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return const HomeScreen(
                                  //         index: 2,
                                  //       );
                                  //     },
                                  //   ),
                                  // );

                                  if (r == resok) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context, true);
                                  } else if (r == resfail) {
                                    Get.snackbar(
                                      "Somthing went wromg",
                                      "Please try again",
                                      colorText: Colors.red,
                                      backgroundColor: Colors.yellow,
                                      icon: const Icon(Icons.error,
                                          color: Colors.black),
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                } else {
                                  print("Not Complete");
                                }
                              },
                              child: Container(
                                height: 50,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: kPrimaryColordark),
                                child: const Center(
                                  child: Text(
                                    "Create",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  bool isimgload = false;

  Future<void> _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = image;
        isimgload = true;
      });
    }
  }

  Future<String> _imageUpload() async {
    String imgurl = guserimg;
    print(isimgload.toString() + "----------------------------------------");
    if (isimgload) {
      Uint8List imgunitfile = await _image!.readAsBytes();
      String imgid = Date.getDateTimeId();

      imgurl =
          await FileUploader.uploadImage(imgunitfile, postimagebucket, imgid);
    } else {
      imgurl = guserimg;
    }
    print(imgurl);
    return imgurl;
  }
}
