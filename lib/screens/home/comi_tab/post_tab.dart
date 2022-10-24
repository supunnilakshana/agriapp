import 'package:agriapp/components/errorpage.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/models/postmodel.dart';
import 'package:agriapp/screens/home/comi_tab/create_post.dart';
import 'package:agriapp/screens/home/comi_tab/news_item.dart';
import 'package:agriapp/services/firebase/fb_handeler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lottie/lottie.dart';

class PostTab extends StatefulWidget {
  const PostTab({
    Key? key,
  }) : super(key: key);
  @override
  _PostTabState createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  late Future<List<PostModel>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = FbHandeler.getallPost();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return const CreatePostScreen();
              //     },
              //   ),
              // );
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreatePostScreen()))
                  .then((val) => val ? loaddata() : null);
            },
            label: const Text("Create a post")),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColordark,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LineIcon.globe(
                size: size.width * 0.073,
                color: Colors.white,
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
              Text(
                "Smart Commiunity",
                style: TextStyle(
                    fontSize: size.width * 0.063, color: Colors.white),
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: FutureBuilder(
                    future: futureData,
                    builder: (context, snapshot) {
                      print(snapshot.hasData);
                      if (snapshot.hasData) {
                        List<PostModel> data = snapshot.data as List<PostModel>;
                        print(data);
                        if (data.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset("assets/animations/newsno.json",
                                  width: size.width * 0.75),
                              Text(
                                "No Posts just",
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * 0.045,
                                    color: Colors.black54),
                              ),
                            ],
                          ); //nodatafound.json
                        } else {
                          return Container(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, indext) {
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.01,
                                          right: size.width * 0.01),
                                      child: NewsItem(
                                        postmodel: data[indext],
                                      ));
                                }),
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Errorpage(size: size.width * 0.7);
                      }
                      // By default show a loading spinner.
                      return Center(
                          child: Lottie.asset(
                              "assets/animations/loadinganimi.json",
                              width: size.width * 0.6));
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  loaddata() async {
    futureData = FbHandeler.getallPost();
    setState(() {});
  }
}
