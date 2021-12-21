Map users = {
  'userId1': {
    'name': String,
    'groups': ['groupId1', 'groupId2'],
  },
  'userId2': {
    'name': String,
    'groups': ['groupId3', 'groupId4'],
  },
};

Map product = {
  'added': int,
  'name': String,
  'brand': String,
  'store': String,
  'info': String,
  'amount': int,
  'bought': bool,
  'tag': bool,
};

Map dbV1 = {
  'users': users,
  'groups': {
    'groupId1': {
      'name': String,
      'lists': {
        'listId1': {
          'name': String,
          'deleted': DateTime, //?
          'products': {
            'productId1': {
              'added': DateTime,
              'name': String,
              'brand': String, //?
              'store': String, //?
              'info': String, //?
              'amount': int, //?
              'bought': DateTime, //?
              'tag': int, // 0 - None | 1 - Important | 2 - Discount
            },
          },
        },
      },
    },
  },
};

/*Map dbV2 = {
  'users': users,
  'groups': {
    'groupId1': {'name': String},
    'groupId2': {'name': String},
  },
  'lists': {
    'groupId1': {
      'listId1': {'name': String},
      'listId2': {'name': String},
    },
    'groupId2': {
      'listId3': {'name': String},
      'listId4': {'name': String},
    },
  },
  'products': {
    'listId1': {
      'productId1': product,
      'productId2': product,
    },
    'listId2': {
      'productId3': product,
      'productId4': product,
    },
  },
};*/
