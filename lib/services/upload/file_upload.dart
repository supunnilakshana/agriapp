import 'dart:typed_data' show Uint8List;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FileUploader {
  static firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static Future<String> uploadImage(
      Uint8List data, String collection, String imgename) async {
    String downloadedData = "false";
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('$collection/$imgename.png');

    try {
      await ref.putData(data);
      print("uploaded");

      downloadedData = await ref.getDownloadURL();

      print(downloadedData);
    } on Exception catch (e) {
      print(e.toString());
    }
    return downloadedData;
  }

  static Future<int> deletefile(String collection, String imgename) async {
    int a = 0;
    try {
      await storage.ref('$collection/$imgename.png').delete();
    } on Exception catch (e) {
      print(e.toString());
    }
    a = 1;
    return a;
  }
}
