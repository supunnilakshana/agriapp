import 'package:agriapp/models/usermodel.dart';

class PostModel {
  final String? id;
  final String title;
  final String context;
  final String addeddate;
  final String userid;
  final UserModel user;
  final String imageurl;

  PostModel(
      {this.id,
      required this.title,
      required this.context,
      required this.addeddate,
      required this.user,
      required this.userid,
      required this.imageurl});
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'titel': title,
      'context': context,
      'addeddate': addeddate,
      'user': user.toMap(),
      'userid': userid,
      'imageurl': imageurl
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> res, String id) {
    return PostModel(
        id: id,
        title: res['titel'],
        context: res['context'],
        user: UserModel.fromMap(res['user']),
        addeddate: res['addeddate'],
        userid: res['userid'],
        imageurl: res['imageurl']);
  }
}
