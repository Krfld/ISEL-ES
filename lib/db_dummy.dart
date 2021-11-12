import 'package:firebase_database/firebase_database.dart';

Map db = {
  'groups': {
    'groupId1': {
      'created': ServerValue.timestamp,
      'name': String,
      'lists': {
        'listId1': {
          'created': ServerValue.timestamp,
          'name': String,
          'products': {
            'productId1': {
              'created': ServerValue.timestamp,
              'name': String,
              'brand': String,
              'details': String,
              'amount': int,
              'flag': bool,
            },
          },
          /*'archive': {
            'productId1': {
              'created': DateTime,
              'name': String,
              'details': String,
              'amount': int,
              'flag': bool,
            },
          },*/
        },
      },
    },
  },
  'users': {
    'userId1': {
      'name': String,
      'lastSeen': DateTime,
      'groups': {'groupId1': true},
    },
  },
};
