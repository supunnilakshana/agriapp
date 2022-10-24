const testbunimg =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQh5frP2WUiJbwPVf2Af1wi8sRmAggvSfXCzw&usqp=CAU";

const guserimg =
    "https://www.clipartmax.com/png/middle/319-3191274_male-avatar-admin-profile.png";

const userimagebucket = "images/users";
const postimagebucket = "images/posts/";

const int resok = 1;
const int resfail = 0;
const String sucesscode = "sucessfull";

class CollectionPath {
  static const userpath = "users/";
  static const postpath = "post";
}

class ItemType {
  static const bakery = "b";
  static const coffe = "c";
}

enum UserRole { farmer, fofficer, expert }

String getpossition(String role) {
  int r = int.parse(role);

  if (r == 0) {
    return "Farmer";
  } else if (r == 1) {
    return "Field Officer";
  } else if (r == 2) {
    return "Expert";
  } else {
    return "Unknown";
  }
}
