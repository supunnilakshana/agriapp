import 'package:agriapp/components/already_have_an_account_acheck.dart';
import 'package:agriapp/components/or_divider.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/constants/initdata.dart';
import 'package:agriapp/models/usermodel.dart';
import 'package:agriapp/screens/auth/fogot_password/choose_fpmethod.dart';
import 'package:agriapp/screens/auth/load_userdata.dart';

import 'package:agriapp/screens/auth/select_user_screen.dart';
import 'package:agriapp/screens/auth/sign_in.dart';
import 'package:agriapp/screens/auth/sign_up_famer.dart';

import 'package:agriapp/services/validator/validate_handeler.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AddFreeTimeSlots extends StatefulWidget {
  const AddFreeTimeSlots({Key? key}) : super(key: key);

  @override
  State<AddFreeTimeSlots> createState() => _AddFreeTimeSlotsState();
}

class _AddFreeTimeSlotsState extends State<AddFreeTimeSlots> {
  String _email = "";
  String _passWord = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _uncon = TextEditingController();
  final TextEditingController _pwcon = TextEditingController();
  final TextEditingController _cpwcon = TextEditingController();
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
                SizedBox(height: size.height * 0.02),
                const BackButton(
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Add free time slots",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Add your free time slots to schedule the meetings",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: size.height * 0.01),
                      // SizedBox(
                      //   width: size.width,
                      //   child: Lottie.asset('assets/animations/sendpin.json',
                      //       height: size.height * 0.3),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
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
                                children: <Widget>[
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey.shade200),
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.shade200))),
                                      child: GestureDetector(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        child: ListTile(
                                            title: Text(
                                              date,
                                              style: TextStyle(
                                                fontSize: size.width * 0.033,
                                              ),
                                            ),
                                            leading: Icon(
                                              Icons.date_range_outlined,
                                              size: size.width * 0.075,
                                            )),
                                      )),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        color: Colors
                                                            .grey.shade200),
                                                    bottom: BorderSide(
                                                      color:
                                                          Colors.grey.shade200,
                                                    ))),
                                            child: GestureDetector(
                                              onTap: () {
                                                _selectTimes(context);
                                              },
                                              child: ListTile(
                                                  title: Text(
                                                    stime,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.033,
                                                    ),
                                                  ),
                                                  leading: Icon(
                                                    Icons.timer_outlined,
                                                    size: size.width * 0.075,
                                                  )),
                                            )),
                                      ),
                                      Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        color: Colors
                                                            .grey.shade200),
                                                    bottom: BorderSide(
                                                      color:
                                                          Colors.grey.shade200,
                                                    ))),
                                            child: GestureDetector(
                                              onTap: () {
                                                _selectTimee(context);
                                              },
                                              child: ListTile(
                                                  title: Text(
                                                    etime,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.033,
                                                    ),
                                                  ),
                                                  leading: Icon(
                                                    Icons.timer_outlined,
                                                    size: size.width * 0.075,
                                                  )),
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                                  Navigator.pop(context);
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
                                    "Save",
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

  Future<Null> _selectTimes(BuildContext context) async {
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

        stime = formatDate(
            DateTime(1999, 11, 30, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();

        print(_time);
        setState(() {});
      });
    }
  }

  Future<Null> _selectTimee(BuildContext context) async {
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

        etime = formatDate(
            DateTime(1999, 11, 30, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();

        print(_time);
        setState(() {});
      });
    }
  }

  String _setTime = "";
  String _hour = "", _minute = "", _time = "";
  String date = "Select your date";
  String stime = "Starting Time";
  String etime = "Ending Time";
  String dropdownValue = 'Choose a time slot';
  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
}
