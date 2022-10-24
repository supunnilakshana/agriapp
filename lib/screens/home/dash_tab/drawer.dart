import 'package:agriapp/components/popup_dilog.dart';
import 'package:agriapp/components/tots.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/constants/initdata.dart';
import 'package:agriapp/models/usermodel.dart';
import 'package:agriapp/screens/auth/reset_password/reset_password.dart';
import 'package:agriapp/screens/auth/sign_in.dart';
import 'package:agriapp/screens/home/dash_tab/profile_page.dart';
import 'package:agriapp/screens/home/drawer_item/aboutus_screen.dart';
import 'package:agriapp/screens/home/drawer_item/appointmentList.dart';
import 'package:agriapp/screens/home/drawer_item/contact_us.dart';
import 'package:agriapp/screens/home/drawer_item/helpscreen.dart';
import 'package:agriapp/screens/home/drawer_item/privacy_screen.dart';
import 'package:agriapp/screens/language/select_lang.dart';
import 'package:agriapp/services/auth/signin_mannager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({
    Key? key,
  }) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    var userModel = Provider.of<UserModel>(context);
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: kPrimaryColordark),
                accountEmail: Text(user!.email.toString()),
                accountName:
                    Text("${userModel.name}(${getpossition(userModel.role)})"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      userModel.imageurl != "" ? userModel.imageurl : guserimg),
                )),

            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.person_outlined,
                  color: kPrimaryColordark,
                ),
                title: const Text('My Profile'),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
              ),
            ),
            int.parse(userModel.role) == UserRole.expert.index ||
                    int.parse(userModel.role) == UserRole.fofficer.index
                ? Card(
                    elevation: 0,
                    child: ListTile(
                      leading: const Icon(
                        Icons.list_rounded,
                        color: kPrimaryColordark,
                      ),
                      title: const Text('My Appoinments'),
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AppointmentsScreen()));
                      },
                    ),
                  )
                : Container(),
            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.password_outlined,
                  color: kPrimaryColordark,
                ),
                title: const Text('Change Password'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResetPassword()));
                },
              ),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                  leading: const Icon(
                    Icons.language_rounded,
                    color: kPrimaryColordark,
                  ),
                  title: const Text('Change Language'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectLang()));
                  }),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.help_outline_rounded,
                  color: kPrimaryColordark,
                ),
                title: const Text('Help'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpScreen()));
                },
              ),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.web,
                  color: kPrimaryColordark,
                ),
                title: const Text('About Us'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutUsScreen()));
                },
              ),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.contact_page_outlined,
                  color: kPrimaryColordark,
                ),
                title: const Text('Contact Us'),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactUsScreen()));
                },
              ),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.book_online_outlined,
                  color: kPrimaryColordark,
                ),
                title: const Text('Privacy & Policy'),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacyScreen()));
                },
              ),
            ),

            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: kPrimaryColordark,
                ),
                title: const Text('Logout'),
                onTap: () {
                  PopupDialog.showPopuplogout(
                      context, "Signout", "Do you want to signout ? ",
                      () async {
                    // context.read<UserModel>().updateData(UserModel(
                    //     name: "", email: "", phone: "", role: "-1", date: ""));

                    await SigninManager().signOut();

                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                    print("logingout");
                  });
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: CustRoundedButton(
            //     height: size.height * 0.06,
            //     width: size.width * 0.25,
            //     text: "Logout",
            //     onpress: () async {
            //       // print(user.providerData[0].providerId);

            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
