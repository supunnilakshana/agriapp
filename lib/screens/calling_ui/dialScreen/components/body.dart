import 'package:agriapp/screens/calling_ui/constants.dart';

import 'package:flutter/material.dart';

import '../../components/dial_user_pic.dart';
import '../../components/rounded_button.dart';
import '../../size_config.dart';
import 'dial_button.dart';

class Body extends StatefulWidget {
  final String name;
  final String iurl;
  const Body({Key? key, required this.name, required this.iurl})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              widget.name,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.white),
            ),
            const Text(
              "Calling…",
              style: TextStyle(color: Colors.white60),
            ),
            const VerticalSpacing(),
            DialUserPic(image: widget.iurl),
            const Spacer(),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                DialButton(
                  iconSrc: "assets/icons/Icon Mic.svg",
                  text: "Audio",
                  press: () {},
                ),
                DialButton(
                  iconSrc: "assets/icons/Icon Volume.svg",
                  text: "Microphone",
                  press: () {},
                ),
                DialButton(
                  iconSrc: "assets/icons/Icon Video.svg",
                  text: "Video",
                  press: () {},
                ),
                DialButton(
                  iconSrc: "assets/icons/Icon Message.svg",
                  text: "Message",
                  press: () {},
                ),
                DialButton(
                  iconSrc: "assets/icons/Icon User.svg",
                  text: "Add contact",
                  press: () {},
                ),
                DialButton(
                  iconSrc: "assets/icons/Icon Voicemail.svg",
                  text: "Voice mail",
                  press: () {},
                ),
              ],
            ),
            const VerticalSpacing(),
            RoundedButton(
              iconSrc: "assets/icons/call_end.svg",
              press: () {
                Navigator.pop(context);
              },
              color: kRedColor,
              iconColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
