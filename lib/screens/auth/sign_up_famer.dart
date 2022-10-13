import 'package:agriapp/components/already_have_an_account_acheck.dart';
import 'package:agriapp/components/or_divider.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/screens/auth/auth_checking.dart';
import 'package:agriapp/screens/auth/sign_in.dart';
import 'package:agriapp/services/auth/signin_mannager.dart';

import 'package:agriapp/services/validator/validate_handeler.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignUpFamer extends StatefulWidget {
  const SignUpFamer({Key? key}) : super(key: key);

  @override
  State<SignUpFamer> createState() => _SignUpFamerState();
}

class _SignUpFamerState extends State<SignUpFamer> {
  String _email = "";
  String _passWord = "";
  String _name = "";
  String _mobile = "";
  String _city = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _uncon = TextEditingController();
  final TextEditingController _pwcon = TextEditingController();
  final TextEditingController _namecon = TextEditingController();
  final TextEditingController _mobilecon = TextEditingController();
  final TextEditingController _citycon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "You are welcome",
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
                              height: 5,
                            ),
                            SizedBox(
                              height: size.width * 0.25,
                              width: size.height * 0.12,
                              child: Stack(
                                clipBehavior: Clip.none,
                                fit: StackFit.expand,
                                children: [
                                  // cropedimg != null
                                  //     ? CircleAvatar(
                                  //         radius: size.width * 0.17,
                                  //         backgroundImage: FileImage(
                                  //             File(cropedimg!.path)),
                                  //       )
                                  //     :
                                  CircleAvatar(
                                    radius: size.width * 0.17,
                                    backgroundImage: const AssetImage(
                                        "assets/icons/farmer.png"),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: -25,
                                      child: RawMaterialButton(
                                        onPressed: () async {
                                          FocusScope.of(context).unfocus();
                                          // _showPicker(context);
                                        },
                                        elevation: 2.0,
                                        fillColor: Color(0xFFF5F6F9),
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.green,
                                        ),
                                        padding: EdgeInsets.all(15.0),
                                        shape: CircleBorder(),
                                      )),
                                ],
                              ),
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
                                      controller: _namecon,
                                      onChanged: (value) {
                                        _name = value;
                                      },
                                      validator: (value) {
                                        return Validater.genaralvalid(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Name",
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
                                      controller: _citycon,
                                      onChanged: (value) {
                                        _city = value;
                                      },
                                      validator: (value) {
                                        return Validater.genaralvalid(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "City",
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
                                      controller: _uncon,
                                      onChanged: (value) {
                                        _email = value;
                                      },
                                      validator: (value) {
                                        return Validater.vaildemail(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Email",
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
                                      controller: _uncon,
                                      onChanged: (value) {
                                        _mobile = value;
                                      },
                                      validator: (value) {
                                        return Validater.vaildmobile(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Mobile No",
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
                                      controller: _pwcon,
                                      onChanged: (value) {
                                        _passWord = value;
                                      },
                                      validator: (value) {
                                        return Validater.signupPassword(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Password",
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
                                  print(_email.trim());
                                  print(_passWord);
                                  int r = await SigninManager()
                                      .signIn(_email.trim(), _passWord);
                                  print(r.toString() +
                                      "------------------------------------------");
                                  if (r == 0) {
                                    print("loged");
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return AuthCheckScreen();
                                        },
                                      ),
                                    );
                                  } else if (r == 1) {
                                    Get.snackbar(
                                      "SignUp failed",
                                      "Please enter the correct email or password",
                                      icon: const Icon(Icons.error,
                                          color: Colors.white),
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  } else if (r == 2) {
                                    Get.snackbar(
                                      "SignUp failed",
                                      "Please enter the correct email or password",
                                      colorText: Colors.red,
                                      backgroundColor: Colors.yellow,
                                      icon: const Icon(Icons.error,
                                          color: Colors.black),
                                      snackPosition: SnackPosition.TOP,
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
                                    "Sign In",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            OrDivider(),
                            AlreadyHaveAnAccountCheck(
                              login: false,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const SignIn();
                                    },
                                  ),
                                );
                              },
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
}
