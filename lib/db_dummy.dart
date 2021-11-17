Map dbV2 = {
  'users': {
    'userId1': {
      'name': String,
      'groups': ['groupId1', 'groupId2'],
    },
    'userId2': {
      'name': String,
      'groups': ['groupId3', 'groupId4'],
    },
  },
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
};

Map product = {
  'added': int,
  'name': String,
  'brand': String,
  'details': String,
  'amount': int,
  'flag': bool,
};

Map dbV1 = {
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
