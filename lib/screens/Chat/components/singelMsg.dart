import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/models/msgModel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SingelMsg extends StatefulWidget {
  const SingelMsg({
    Key? key,
    required this.msgModel,
    required this.mcolor,
    required this.align,
  }) : super(key: key);

  final MsgModel msgModel;
  final Color mcolor;
  final CrossAxisAlignment align;

  @override
  _SingelMsgState createState() => _SingelMsgState();
}

class _SingelMsgState extends State<SingelMsg> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
        color: kPrimaryColorlight,
        elevation: 0,
        child: Padding(
          padding:
              EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.05),
          child: Column(
            crossAxisAlignment: widget.align,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: widget.mcolor,
                    borderRadius: BorderRadius.circular(28)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.msgModel.message,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 100,
                    style: TextStyle(
                      color: kBasefontColor,
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.005),
              Text(
                widget.msgModel.datetime,
                style: TextStyle(
                  color: kBasefontColor.withOpacity(0.75),
                  fontSize: size.width * 0.025,
                ),
              )
            ],
          ),
        ));
  }
}
