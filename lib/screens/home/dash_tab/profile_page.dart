// ignore_for_file: sort_child_properties_last

import 'dart:io';
import 'dart:typed_data';

import 'package:agriapp/components/already_have_an_account_acheck.dart';
import 'package:agriapp/components/or_divider.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/constants/initdata.dart';
import 'package:agriapp/models/usermodel.dart';
import 'package:agriapp/screens/auth/load_userdata.dart';
import 'package:agriapp/screens/auth/check_signIn.dart';
import 'package:agriapp/screens/auth/sign_in.dart';
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

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _email = "";
  String _passWord = "";
  String _name = "";
  String _mobile = "";
  String _city = "";
  String _addr = "";
  String _emno = "";
  final TextEditingController _emnocon = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _uncon = TextEditingController();
  final TextEditingController _pwcon = TextEditingController();
  final TextEditingController _namecon = TextEditingController();
  final TextEditingController _mobilecon = TextEditingController();
  final TextEditingController _citycon = TextEditingController();
  final TextEditingController _addrcon = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;
    var userModel = Provider.of<UserModel>(context);
    _namecon.text = userModel.name;
    _uncon.text = userModel.email;
    _addrcon.text = userModel.address;
    _emnocon.text = userModel.emno;
    _citycon.text = userModel.area;
    _mobilecon.text = userModel.phone;

    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(gradient: kGradientGreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: size.height * 0.02),
                const BackButton(
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "My Profile",
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.width * 0.28,
                            width: size.height * 0.15,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                isimgload
                                    ? CircleAvatar(
                                        radius: size.width * 0.20,
                                        backgroundImage:
                                            FileImage(File(_image!.path)),
                                      )
                                    : CircleAvatar(
                                        backgroundColor:
                                            Colors.lightGreen.shade200,
                                        radius: size.width * 0.20,
                                        backgroundImage:
                                            NetworkImage(userModel.imageurl),
                                      ),
                                Positioned(
                                    bottom: 0,
                                    right: -25,
                                    child: RawMaterialButton(
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        // _imgFromGallery();
                                      },
                                      elevation: 2.0,
                                      fillColor: const Color(0xFFF5F6F9),
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.green,
                                      ),
                                      padding: const EdgeInsets.all(5.0),
                                      shape: const CircleBorder(),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${userModel.name} (${getpossition(userModel.role)})",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 23),
                            ),
                          ],
                        ),
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
                              height: 5,
                            ),
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
                                      enabled: false,
                                      controller: _namecon,
                                      onChanged: (value) {
                                        _name = value;
                                      },
                                      validator: (value) {
                                        return Validater.genaralvalid(value!);
                                      },
                                      decoration: const InputDecoration(
                                          labelText: "Name",
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
                                      enabled: false,
                                      controller: _uncon,
                                      onChanged: (value) {
                                        _email = value;
                                      },
                                      validator: (value) {
                                        return Validater.vaildemail(value!);
                                      },
                                      decoration: const InputDecoration(
                                          labelText: "Email",
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
                                      enabled: false,
                                      controller: _mobilecon,
                                      onChanged: (value) {
                                        _mobile = value;
                                      },
                                      validator: (value) {
                                        return Validater.vaildmobile(value!);
                                      },
                                      decoration: const InputDecoration(
                                          labelText: "Mobile No",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  int.parse(userModel.role) !=
                                          UserRole.farmer.index
                                      ? Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade200))),
                                          child: TextFormField(
                                            enabled: false,
                                            controller: _emnocon,
                                            onChanged: (value) {
                                              _emno = value;
                                            },
                                            validator: (value) {
                                              return Validater.genaralvalid(
                                                  value!);
                                            },
                                            decoration: const InputDecoration(
                                                labelText: "Employement No",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                          ),
                                        )
                                      : Container(),
                                  int.parse(userModel.role) ==
                                          UserRole.fofficer.index
                                      ? Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade200))),
                                          child: TextFormField(
                                            enabled: false,
                                            controller: _citycon,
                                            onChanged: (value) {
                                              _city = value;
                                            },
                                            validator: (value) {
                                              return Validater.genaralvalid(
                                                  value!);
                                            },
                                            decoration: const InputDecoration(
                                                labelText: "Responsible Area",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                          ),
                                        )
                                      : Container(),
                                  int.parse(userModel.role) ==
                                          UserRole.expert.index
                                      ? Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade200))),
                                          child: TextFormField(
                                            enabled: false,
                                            controller: _citycon,
                                            onChanged: (value) {
                                              _city = value;
                                            },
                                            validator: (value) {
                                              return Validater.genaralvalid(
                                                  value!);
                                            },
                                            decoration: const InputDecoration(
                                                labelText: "Specailized Area",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                          ),
                                        )
                                      : Container(),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      enabled: false,
                                      maxLines: 2,
                                      controller: _addrcon,
                                      onChanged: (value) {
                                        _addr = value;
                                      },
                                      validator: (value) {
                                        return Validater.genaralvalid(value!);
                                      },
                                      decoration: const InputDecoration(
                                          labelText: "Employment place address",
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
          await FileUploader.uploadImage(imgunitfile, userimagebucket, imgid);
    } else {
      imgurl = guserimg;
    }
    print(imgurl);
    return imgurl;
  }
}
