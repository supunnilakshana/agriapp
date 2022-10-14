class PostModel {
  final String id;
  final String title;
  final String context;
  final String addeddate;
  final String userid;
  final String userrole;
  final String imageurl;

  PostModel(
      {required this.id,
      required this.title,
      required this.context,
      required this.addeddate,
      required this.userrole,
      this.userid = "",
      this.imageurl = ""});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titel': title,
      'context': context,
      'addeddate': addeddate,
      'userole': userrole,
      'userid': userid,
      'imageurl': imageurl
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> res) {
    return PostModel(
        id: res['id'],
        title: res['titel'],
        context: res['context'],
        userrole: res['userole'],
        addeddate: res['addeddate'],
        userid: res['userid'],
        imageurl: res['imageurl']);
  }
}
