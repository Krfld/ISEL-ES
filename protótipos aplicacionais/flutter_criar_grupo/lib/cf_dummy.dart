import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

Map user = {
  'name': String, //?
  'isGuest': bool,
};

Map group = {
  'name': String,
  'users': List<String>,
};

Map list = {
  'name': String,
  'deleted': signature, //?
};

Map product = {
  'name': String,
  'brand': String, //?
  'store': String, //?
  'details': String, //?
  'amount': int, //?
  'tag': int, // 0 - None | 1 - Important | 2 - Discount
  'added': signature,
  'bought': signature, //?
  'removed': signature, //?
};

Map signature = {
  'user': String,
  'timestamp': Timestamp,
};
