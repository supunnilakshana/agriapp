import 'package:agriapp/models/usermodel.dart';
import 'package:agriapp/screens/home/home_screen.dart';
import 'package:agriapp/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            UserModel(name: "", email: "", phone: "", role: "-1", date: ""),
        builder: (BuildContext context, child) {
          return GetMaterialApp(
            title: 'Smart Agri',
            theme: ThemeData(
                primarySwatch: Colors.green,
                textTheme: GoogleFonts.robotoTextTheme(
                  Theme.of(context).textTheme,
                )),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        });
  }
}
