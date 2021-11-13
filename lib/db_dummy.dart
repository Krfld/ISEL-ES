Map db = {
  'groups': {
    'groupId1': {
      'created': int,
      'name': String,
      'lists': {
        'listId1': {
          'created': int,
          'name': String,
          'products': {
            'productId1': {
              'created': int,
              'name': String,
              'brand': String,
              'details': String,
              'amount': int,
              'flag': bool,
            },
          },
          /*'archive': {
            'productId1': {
              'created': int,
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
      'lastSeen': int,
      'groups': {'groupId1': true},
    },
  },
};
