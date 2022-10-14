import 'package:agriapp/components/errorpage.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/models/postmodel.dart';
import 'package:agriapp/screens/home/comi_tab/news_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lottie/lottie.dart';

class PetNewsTab extends StatefulWidget {
  const PetNewsTab({
    Key? key,
  }) : super(key: key);
  @override
  _PetNewsTabState createState() => _PetNewsTabState();
}

class _PetNewsTabState extends State<PetNewsTab> {
  late Future<List<PostModel>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = FireDBHandeler.getallPetNews();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.green.withOpacity(0.2),
        body: Container(
          child: Column(
            children: [
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  height: size.height * 0.2,
                  color: kPrimaryColordark,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.05, bottom: size.height * 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LineIcon.globe(
                            size: size.width * 0.09,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Text(
                            "SmartCommiunity",
                            style: TextStyle(
                                fontSize: size.width * 0.08,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
                                "No News just",
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
                              "assets/animations/loadingdots.json",
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
    futureData = FireDBHandeler.getallPetNews();
    setState(() {});
  }
}
