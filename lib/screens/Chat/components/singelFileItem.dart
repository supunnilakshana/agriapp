import 'dart:io';

import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/models/msgModel.dart';
import 'package:agriapp/services/date_time/date.dart';
import 'package:agriapp/services/upload/file_upload.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';

class SingelFileItem extends StatefulWidget {
  final MsgModel msgModel;
  final Color pcolor;

  SingelFileItem({Key? key, required this.msgModel, required this.pcolor})
      : super(key: key);

  @override
  _SingelFileItemState createState() => _SingelFileItemState();
}

class _SingelFileItemState extends State<SingelFileItem> {
  bool isdownloading = false;

  bool isdownload = false;

  String path = " ";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          color: widget.pcolor,
          child: ListTile(
            leading: Icon(
              Icons.file_present_outlined,
            ),
            title: Text(widget.msgModel.fname),
            trailing: isdownloading
                ? Lottie.asset("assets/animations/downloading.json",
                    width: size.width * 0.08)
                : isdownload
                    ? GestureDetector(
                        onTap: () {
                          // final pm = pathlist.firstWhere(
                          //     (element) => element.id == msgModel.id);

                          // print(pathlist.length.toString() +
                          //     "------------------");
                          OpenFile.open(path);
                        },
                        child: Icon(Icons.remove_red_eye_outlined))
                    : GestureDetector(
                        onTap: () async {
                          isdownload = false;
                          isdownloading = true;
                          setState(() {});
                          String downloadfilepath =
                              await FileUploader.downloadfile(
                                  widget.msgModel.message,
                                  Date.getDateTimeId() +
                                      widget.msgModel.extension);

                          path = downloadfilepath;

                          // pathlist.add(PathModel(
                          //     id: widget.msgModel.id, path: decryptfile.path));
                          isdownload = true;
                          isdownloading = false;
                          setState(() {});
                        },
                        child: Icon(Icons.download_for_offline_outlined)),
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
    );
  }
}
