const testbunimg =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQh5frP2WUiJbwPVf2Af1wi8sRmAggvSfXCzw&usqp=CAU";

const guserimg =
    "https://www.clipartmax.com/png/middle/319-3191274_male-avatar-admin-profile.png";

const userimagebucket = "images/users/";
const postimagebucket = "images/posts/";

const int resok = 1;
const int resfail = 0;
const String sucesscode = "sucessfull";

class CollectionPath {
  static const bakeryitempath = "products/data/bakeryItem";
  static const reorderdocmpath = "reorder";
  static const trashpath = "trash";
  static const invoicehpath = "invoice";
  static const customermpath = "customer";
  static const orderpath = "orders";
  static const supplier = "supplier";
  static const notitokenpath = "notitoken";
  static const promospath = "promos";
}

class ItemType {
  static const bakery = "b";
  static const coffe = "c";
}

final months = [
  'jan',
  'feb',
  'mar',
  'april',
  'may',
  'jun',
  'july',
  'aug',
  'sep',
  'oct',
  'nov',
  'dec'
];

enum UserRole { farmer, fofficer, expert }