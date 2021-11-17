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
  'details': String,
  'amount': int,
  'flag': bool,
};

Map dbV2 = {
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
};

Map dbV1 = {
  'users': users,
  'groups': {
    'groupId1': {
      'name': String,
      'lists': {
        'listId1': {
          'name': String,
          'products': {
            'productId1': product,
            'productId2': product,
          },
        },
        'listId2': {
          'name': String,
          'products': {
            'productId3': product,
            'productId4': product,
          },
        },
      },
    },
    'groupId2': {
      'name': String,
      'lists': {
        'listId3': {
          'name': String,
          'products': {
            'productId5': product,
            'productId6': product,
          },
        },
        'listId4': {
          'name': String,
          'products': {
            'productId7': product,
            'productId8': product,
          },
        },
      },
    },
  },
};
