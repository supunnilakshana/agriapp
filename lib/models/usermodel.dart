import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  String? uid;
  String name;
  String email;
  String emno;
  String phone;
  String role;
  String area;
  String address;
  String date;
  String imageurl;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.emno = "",
    this.area = "",
    this.address = "",
    required this.date,
    this.imageurl = "",
  });
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'emno': emno,
      'phone': phone,
      'role': role,
      'area': area,
      'address': address,
      'date': date,
      'imageurl': imageurl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> res) {
    return UserModel(
      uid: res['uid'],
      name: res['name'],
      email: res['email'],
      emno: res['emno'] ?? "",
      phone: res['phone'] ?? "",
      role: res['role'],
      area: res['area'] ?? "",
      date: res['date'],
      address: res['address'] ?? "",
      imageurl: res['imageurl'] ?? "",
    );
  }

  updateData(UserModel userModel) {
    uid = userModel.uid;
    name = userModel.name;
    email = userModel.email;
    phone = userModel.phone;
    role = userModel.role;
    area = userModel.area;
    date = userModel.date;
    address = userModel.address;
    imageurl = userModel.imageurl;
    notifyListeners();
  }
}
