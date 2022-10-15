import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/constants/initdata.dart';
import 'package:agriapp/models/usermodel.dart';
import 'package:agriapp/screens/home/dash_tab/drawer.dart';
import 'package:agriapp/screens/home/dash_tab/news_web_view.dart';
import 'package:agriapp/screens/user_list/user_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

class DashTab extends StatelessWidget {
  DashTab({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var userModel = Provider.of<UserModel>(context);
    return Scaffold(
      drawer: MenuDrawer(),
      key: _scaffoldKey,
      backgroundColor: Colors.green.withOpacity(0.2),
      appBar: AppBar(
          actions: [
            Container(
                margin: const EdgeInsets.only(top: 2, right: 5),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: size.width * 0.08,
                  backgroundImage: NetworkImage(
                      userModel.imageurl == "" ? guserimg : userModel.imageurl),
                )),
          ],
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: kPrimaryColordark,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.white.withOpacity(.8),
              size: size.width * 0.1,
            ),
          )),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipPath(
            clipper: WaveClipperOne(),
            child: Container(
              height: size.height * 0.17,
              color: kPrimaryColordark,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.06,
                        top: size.height * 0.01,
                        bottom: size.height * 0.01),
                    child: Row(
                      children: [
                        Text(
                          'Hello  ' + userModel.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.06,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/icons/temp.png',
                                width: size.width * 0.09,
                              ),
                              Text(
                                '20°C',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.0354,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/icons/wind.png',
                                width: size.width * 0.09,
                              ),
                              Text(
                                '25 mph',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.0354,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/icons/humidity.png',
                                width: size.width * 0.08,
                              ),
                              Text(
                                '27°C',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.0354,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/icons/rain.png',
                                width: size.width * 0.09,
                              ),
                              Text(
                                '70 ml',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.0354,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(55.0)),
                  // color: Colors.green.withOpacity(0.7),
                ),
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1,
                    autoPlay: true,
                  ),
                  items: imageSliders,
                )),
          ),
          userModel.role != "1"
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 3, top: 3),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserListScreen(
                                    role: "1",
                                  )));
                    },
                    child: Card(
                      elevation: 2,
                      color: const Color.fromARGB(255, 184, 226, 201),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 0.05)),
                      ),
                      child: ListTile(
                        leading: Image.asset("assets/icons/officer.png"),
                        subtitle: const SizedBox(
                          height: 8,
                        ),
                        title: Text(
                          "Contact a Filed Officer",
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          userModel.role != "0"
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 3, top: 3),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserListScreen(
                                    role: "0",
                                  )));
                    },
                    child: Card(
                      elevation: 2,
                      color: const Color.fromARGB(255, 184, 226, 201),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 0.05)),
                      ),
                      child: ListTile(
                        leading: Image.asset("assets/icons/farmer.png"),
                        subtitle: const SizedBox(
                          height: 8,
                        ),
                        title: Text(
                          "Contact a Farmer",
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          userModel.role != "2"
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 3, top: 3),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserListScreen(
                                    role: "2",
                                  )));
                    },
                    child: Card(
                      elevation: 2,
                      color: const Color.fromARGB(255, 184, 226, 201),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 0.05)),
                      ),
                      child: ListTile(
                        leading: Image.asset("assets/icons/expert.png"),
                        subtitle: const SizedBox(
                          height: 8,
                        ),
                        title: Text(
                          "Contact a Expert",
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          Row(
            children: [
              Expanded(
                child: HomeItem(
                  img: "assets/icons/videos.png",
                  size: size,
                  titel: "Videos",
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewsWebView()));
                  },
                  child: HomeItem(
                    size: size,
                    img: "assets/icons/news.png",
                    titel: "News",
                  ),
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}

final List<String> imgList = [
  "https://firebasestorage.googleapis.com/v0/b/agri-app-f387a.appspot.com/o/appdata%2Fistockphoto-1178095816-612x612.jpg?alt=media&token=57da41ae-e063-4abb-8602-f3d6a16cb9eb",
  "https://firebasestorage.googleapis.com/v0/b/agri-app-f387a.appspot.com/o/appdata%2F1200px-Pana_Banaue_Rice_Terraces_(Cropped).jpg?alt=media&token=d53087be-a8cf-484b-b342-e337ad5a8404",
  "https://firebasestorage.googleapis.com/v0/b/agri-app-f387a.appspot.com/o/appdata%2Fs3.jpg?alt=media&token=44882175-ae78-4d05-ac56-c33a47113e26",
  "https://firebasestorage.googleapis.com/v0/b/agri-app-f387a.appspot.com/o/appdata%2F1-33.jpg?alt=media&token=cca2a12b-c054-4def-9d5e-9a0b8444eac9"
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(15.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(
                    item,
                    fit: BoxFit.cover,
                    width: 1000.0,
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                    ),
                  ),
                ],
              )),
        ))
    .toList();

class HomeItem extends StatelessWidget {
  final String titel;
  final String img;

  const HomeItem({
    Key? key,
    required this.size,
    required this.titel,
    this.img = "assets/icons/farmer.png",
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.05,
      ),
      child: Card(
        color: Colors.white.withOpacity(0.8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(size.width * 0.05))),
        elevation: 3,
        child: Container(
          width: size.width * 0.42,
          // height: size.height * 0.2,

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 0.05)),
                  child: Image.asset(
                    img,
                    width: size.width * 0.1,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.005, bottom: size.height * 0.005),
                child: Text(
                  titel,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: Colors.black.withOpacity(0.9),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
