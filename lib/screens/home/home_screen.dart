import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/models/usermodel.dart';
import 'package:agriapp/screens/chat/components/chatList.dart';
import 'package:agriapp/screens/home/comi_tab/post_tab.dart';
import 'package:agriapp/screens/home/dash_tab/dashboard_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final int index;

  const HomeScreen({Key? key, this.index = 0}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<UserModel> futureData;
  final user = FirebaseAuth.instance.currentUser;

  int _selectedIndex = 0;
  @override
  void initState() {
    _selectedIndex = widget.index;
    super.initState();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);
    List<Widget> _widgetOptions = [DashTab(), ChatList(), const PostTab()];
    return WillPopScope(
      onWillPop: () {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          final snack = SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return Future<bool>.value(false);
        } else {
          return Future<bool>.value(true);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: kPrimaryColorlight,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: kPrimaryColordark,
                hoverColor: Colors.greenAccent,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 300),
                tabBackgroundColor: Colors.green.shade800.withOpacity(0.7),
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.rocketChat,
                    text: 'Inbox',
                  ),
                  GButton(
                    icon: LineIcons.globe,
                    text: 'Commiunity',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
