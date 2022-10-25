// ignore_for_file: sort_child_properties_last

import 'dart:io';
import 'dart:typed_data';

import 'package:agriapp/components/already_have_an_account_acheck.dart';
import 'package:agriapp/components/or_divider.dart';
import 'package:agriapp/components/tots.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:date_format/date_format.dart';
import '../../auth/fogot_password/change_password.dart';

class ScheduleAp extends StatefulWidget {
  const ScheduleAp({Key? key, required this.userModel, this.val = "1"})
      : super(key: key);
  final UserModel userModel;
  final String val;
  @override
  State<ScheduleAp> createState() => _ScheduleApState();
}

class _ScheduleApState extends State<ScheduleAp> {
  String _email = "";
  String _passWord = "";
  String _name = "";
  String _mobile = "";
  String _city = "";
  String _addr = "";
  String _emno = "";
  String date = "Select Date";
  String time = "Select Time";
  String dropdownValue = 'Choose a time slot';

  final atimeslots = [
    'Choose a time slot',
    '8.00 - 9.00',
    '10.00 - 11.00',
    '12.00 - 13.00',
    '15.00 - 16.00',
    '17.00 - 1.00',
    '18.00 - 19.00',
    '20.00 - 21.00',
  ];

  final TextEditingController _emnocon = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _uncon = TextEditingController();
  final TextEditingController _pwcon = TextEditingController();
  final TextEditingController _namecon = TextEditingController();
  final TextEditingController _mobilecon = TextEditingController();
  final TextEditingController _citycon = TextEditingController();
  final TextEditingController _addrcon = TextEditingController();
  String _value = "1";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _value = widget.val;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;
    var userModel = widget.userModel;
    _namecon.text = userModel.name;
    _uncon.text = userModel.email;
    _mobilecon.text = userModel.phone;

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
              children: [
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
                        "Schedule a call appointments",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: SizedBox(
                          width: size.width * 0.8,
                          child: Lottie.asset('assets/animations/schedule.json',
                              height: size.height * 0.3),
                        ),
                      ),
                      //SizedBox(height: size.height * 0.01),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: RadioListTile(
                                            value: "1",
                                            title: const Text(
                                              "Meting via voice ",
                                            ),
                                            groupValue: _value,
                                            onChanged: (value) {
                                              setState(() {
                                                _value = value.toString();
                                              });
                                            }),
                                      ),
                                      Expanded(
                                        child: RadioListTile(
                                            title: const Text(
                                              "Meting via video",
                                            ),
                                            value: "2",
                                            groupValue: _value,
                                            onChanged: (value) {
                                              setState(() {
                                                _value = value.toString();
                                              });
                                            }),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    top: BorderSide(
                                                        color: Colors
                                                            .grey.shade200),
                                                    bottom: BorderSide(
                                                        color: Colors
                                                            .grey.shade200))),
                                            child: GestureDetector(
                                              onTap: () {
                                                _selectDate(context);
                                              },
                                              child: ListTile(
                                                  title: Text(
                                                    date,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.033,
                                                    ),
                                                  ),
                                                  leading: Icon(
                                                    Icons.date_range_outlined,
                                                    size: size.width * 0.075,
                                                  )),
                                            )),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  top: BorderSide(
                                                      color:
                                                          Colors.grey.shade200),
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade200))),
                                          child: DropdownButton<String>(
                                            value: dropdownValue,
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            elevation: 1,
                                            style: TextStyle(
                                                color: kDarkBrownButton,
                                                fontWeight: FontWeight.w500,
                                                fontSize: size.width * 0.044),
                                            underline: Container(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownValue = newValue!;
                                                print(dropdownValue);
                                              });
                                            },
                                            items: atimeslots
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.037,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey.shade200),
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
                                  // Container(
                                  //   padding: const EdgeInsets.all(10),
                                  //   decoration: BoxDecoration(
                                  //       border: Border(
                                  //           bottom: BorderSide(
                                  //               color: Colors.grey.shade200))),
                                  //   child: TextFormField(
                                  //     enabled: false,
                                  //     controller: _mobilecon,
                                  //     onChanged: (value) {
                                  //       _mobile = value;
                                  //     },
                                  //     validator: (value) {
                                  //       return Validater.vaildmobile(value!);
                                  //     },
                                  //     decoration: const InputDecoration(
                                  //         labelText: "Mobile No",
                                  //         hintStyle:
                                  //             TextStyle(color: Colors.grey),
                                  //         border: InputBorder.none),
                                  //   ),
                                  // ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      maxLines: 2,
                                      controller: _addrcon,
                                      onChanged: (value) {
                                        _addr = value;
                                      },
                                      validator: (value) {
                                        return Validater.genaralvalid(value!);
                                      },
                                      decoration: const InputDecoration(
                                          labelText: "Message",
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
                                  Customtost.commontost(
                                      "Scheduled Successfully",
                                      kPrimaryColordark);
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
                                    "Schedule",
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

  _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        date = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
        setState(() {});
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ':' + _minute;

        ///  Date.timeBetween(_time,Date.daysBetween(from));

        time = formatDate(
            DateTime(1999, 11, 30, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();

        print(_time);
        setState(() {});
      });
    }
  }

  String _setTime = "";
  String _hour = "", _minute = "", _time = "";

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
}
