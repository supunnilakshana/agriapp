import 'package:agriapp/components/popup_dilog.dart';
import 'package:agriapp/components/tots.dart';
import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/constants/initdata.dart';
import 'package:agriapp/models/usermodel.dart';
import 'package:agriapp/screens/auth/sign_in.dart';
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
        color: Colors.green.withOpacity(0.2),
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
              child: ListTile(
                leading: const Icon(
                  Icons.account_circle,
                  color: kPrimaryColordark,
                ),
                title: const Text('Reset Password'),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.web,
                  color: kPrimaryColordark,
                ),
                title: const Text('Visit our Website'),
                onTap: () async {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.people,
                  color: kPrimaryColordark,
                ),
                title: const Text('About Us'),
                onTap: () {
                  Customtost.commontost(
                      "We are Atext Developers", Colors.amber);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: kPrimaryColordark,
                ),
                title: const Text('App Version'),
                onTap: () {
                  Customtost.commontost("Version 1.0.0", Colors.amber);
                },
              ),
            ),
            Card(
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
                    context.read<UserModel>().updateData(UserModel(
                        name: "", email: "", phone: "", role: "-1", date: ""));

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
