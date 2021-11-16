Map db = {
  'groups': {
    'groupId1': {
      'name': String,
      'lists': {
        'listId1': {
          'name': String,
          'products': {
            'productId1': {
              'added': int,
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
      'groups': ['groupId1'],
    },
  },
};
