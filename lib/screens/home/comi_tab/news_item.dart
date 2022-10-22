import 'package:agriapp/constants/initdata.dart';
import 'package:agriapp/models/postmodel.dart';
import 'package:agriapp/screens/home/comi_tab/comment.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:readmore/readmore.dart';

class NewsItem extends StatefulWidget {
  final PostModel postmodel;

  const NewsItem({
    Key? key,
    required this.postmodel,
  }) : super(key: key);

  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  bool isedit = false;
  bool isShadow = false;
  bool islike = false;
  String date = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.025),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: size.width * 0.06,
                              backgroundImage:
                                  NetworkImage(widget.postmodel.user.imageurl),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.postmodel.user.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: size.width * 0.04,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    getpossition(widget.postmodel.user.role),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: size.width * 0.03,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Icon(
                            Icons.share,
                            color: Colors.black.withOpacity(0.7),
                          )
                        ],
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.015,
                    right: size.width * 0.015,
                    // top: size.height * 0.012,
                    bottom: size.height * 0.015),
                child: Text(
                  widget.postmodel.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.04,
                  right: size.width * 0.04,
                ),
                child: Container(
                    // width: size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 0)),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.blueGrey.shade100,
                      //     blurRadius: 2.0,
                      //     spreadRadius: 2.0,
                      //     offset: Offset(
                      //       3.0,
                      //       3.0,
                      //     ),
                      //   )
                      // ],
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 0.05)),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.postmodel.imageurl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Container(
                          //  height: size.height * 0.01,
                          child: Center(
                            child: CircularProgressIndicator(
                                color: Colors.green.shade800,
                                value: downloadProgress.progress),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.023, bottom: size.height * 0.018),
                child: ReadMoreText(
                  widget.postmodel.context,
                  trimLength: 250,
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: GestureDetector(
                                child: islike
                                    ? LineIcon.heartAlt(
                                        color: Colors.green.shade600
                                            .withOpacity(0.9))
                                    : LineIcon.heart(
                                        color: Colors.black.withOpacity(0.9)),
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
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CommentScreen(name: "test")));
                              },
                              child: LineIcon.comments(
                                  color: Colors.black.withOpacity(0.9)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            LineIcon.pen(color: Colors.black.withOpacity(0.6)),
                            Text(
                              widget.postmodel.addeddate,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  setshadow() {
    Future.delayed(const Duration(milliseconds: 3700), () {
      isShadow = true;
      setState(() {});
    });
  }
}
