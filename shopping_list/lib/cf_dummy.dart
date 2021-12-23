import 'package:cloud_firestore/cloud_firestore.dart'; // For timestamp

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
  'deleted': {'user': String, 'timestamp': Timestamp}, //?
};

Map product = {
  'name': String,
  'brand': String, //?
  'store': String, //?
  'info': String, //?
  'amount': int, //?
  'tag': int, // 0 - None | 1 - Important | 2 - Discount
  'added': {'user': String, 'timestamp': Timestamp},
  'bought': {'user': String, 'timestamp': Timestamp}, //?
  'removed': {'user': String, 'timestamp': Timestamp}, //?
};
