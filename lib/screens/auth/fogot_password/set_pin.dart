import 'package:agriapp/components/already_have_an_account_acheck.dart';
import 'package:agriapp/components/or_divider.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/constants/initdata.dart';
import 'package:agriapp/screens/auth/fogot_password/change_password.dart';
import 'package:agriapp/screens/auth/fogot_password/choose_fpmethod.dart';
import 'package:agriapp/screens/auth/load_userdata.dart';

import 'package:agriapp/screens/auth/select_user_screen.dart';
import 'package:agriapp/screens/auth/sign_up_famer.dart';

import 'package:agriapp/services/validator/validate_handeler.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SetPin extends StatefulWidget {
  const SetPin({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  State<SetPin> createState() => _SetPinState();
}

class _SetPinState extends State<SetPin> {
  String _email = "";
  String _passWord = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _uncon = TextEditingController();
  final TextEditingController _p1 = TextEditingController();
  final TextEditingController _p2 = TextEditingController();
  final TextEditingController _p3 = TextEditingController();
  final TextEditingController _p4 = TextEditingController();
  final TextEditingController _p5 = TextEditingController();
  final TextEditingController _p6 = TextEditingController();

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
            decoration: const BoxDecoration(gradient: kGradientGreen),
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
                        "Enter PIN Number",
                        style: TextStyle(color: Colors.white, fontSize: 38),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "We have sent you a ${widget.type == "1" ? "SMS " : "Email "} to with the 6 digts PIN",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      // SizedBox(
                      //   width: size.width,
                      //   child: Lottie.asset('assets/animations/sendpin.json',
                      //       height: size.height * 0.3),
                      // ),
                      SizedBox(height: size.height * 0.01),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: kPrimaryColorlight,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    77, 57, 104, 57),
                                                blurRadius: 5,
                                                offset: Offset(0, 4))
                                          ]),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            border: Border()),
                                        child: TextFormField(
                                          textAlign: TextAlign.center,
                                          maxLength: 1,
                                          keyboardType: TextInputType.number,
                                          controller: _p1,
                                          validator: (value) {
                                            return Validater.isNumeric(value!);
                                          },
                                          decoration: const InputDecoration(
                                              counter: SizedBox.shrink(),
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    77, 57, 104, 57),
                                                blurRadius: 5,
                                                offset: Offset(0, 4))
                                          ]),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            border: const Border()),
                                        child: TextFormField(
                                          textAlign: TextAlign.center,
                                          maxLength: 1,
                                          keyboardType: TextInputType.number,
                                          controller: _p2,
                                          validator: (value) {
                                            return Validater.isNumeric(value!);
                                          },
                                          decoration: const InputDecoration(
                                              counter: SizedBox.shrink(),
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    77, 57, 104, 57),
                                                blurRadius: 5,
                                                offset: Offset(0, 4))
                                          ]),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            border: const Border()),
                                        child: TextFormField(
                                          textAlign: TextAlign.center,
                                          maxLength: 1,
                                          keyboardType: TextInputType.number,
                                          controller: _p3,
                                          validator: (value) {
                                            return Validater.isNumeric(value!);
                                          },
                                          decoration: const InputDecoration(
                                              counter: SizedBox.shrink(),
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    77, 57, 104, 57),
                                                blurRadius: 5,
                                                offset: Offset(0, 4))
                                          ]),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            border: Border()),
                                        child: TextFormField(
                                          textAlign: TextAlign.center,
                                          maxLength: 1,
                                          keyboardType: TextInputType.number,
                                          controller: _p4,
                                          validator: (value) {
                                            return Validater.isNumeric(value!);
                                          },
                                          decoration: const InputDecoration(
                                              counter: SizedBox.shrink(),
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    77, 57, 104, 57),
                                                blurRadius: 5,
                                                offset: Offset(0, 4))
                                          ]),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            border: const Border()),
                                        child: TextFormField(
                                          textAlign: TextAlign.center,
                                          maxLength: 1,
                                          keyboardType: TextInputType.number,
                                          controller: _p5,
                                          validator: (value) {
                                            return Validater.isNumeric(value!);
                                          },
                                          decoration: const InputDecoration(
                                              counter: SizedBox.shrink(),
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    77, 57, 104, 57),
                                                blurRadius: 5,
                                                offset: Offset(0, 4))
                                          ]),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            border: Border()),
                                        child: TextFormField(
                                          textAlign: TextAlign.center,
                                          maxLength: 1,
                                          keyboardType: TextInputType.number,
                                          controller: _p6,
                                          validator: (value) {
                                            return Validater.isNumeric(value!);
                                          },
                                          decoration: const InputDecoration(
                                              counter: SizedBox.shrink(),
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const ChangePassword();
                                      },
                                    ),
                                  );
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
                                    "Continue",
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
}
