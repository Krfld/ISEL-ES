Map user = {
  // 'name': String,
  'isGuest': bool,
};

Map group = {
  'name': String,
  'users': List<String>,
};

Map list = {
  'name': String,
  'deleted': DateTime, //?
};

Map product = {
  'added': DateTime,
  'name': String,
  'brand': String, //?
  'store': String, //?
  'info': String, //?
  'amount': int, //?
  'bought': {
    'user': String,
    'time': DateTime,
  }, //?
  'tag': int, // 0 - None | 1 - Important | 2 - Discount
};
