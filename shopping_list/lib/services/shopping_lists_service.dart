import 'dart:async';
import '../entities/shopping_list.dart';
import '../repositories/shopping_lists_repository.dart';

import '../services/groups_service.dart';

class ShoppingListsService {
  static final ShoppingListsRepository _shoppingListsRepository = ShoppingListsRepositoryCloudFirestore();

  static List<ShoppingList> shoppingLists = [];

  static String? _currentShoppingListId;
  static ShoppingList get currentShoppingList => getList(_currentShoppingListId!);
  static set currentShoppingList(ShoppingList? list) => _currentShoppingListId = list?.id;

  static ShoppingList getList(String listId) => shoppingLists.singleWhere((list) => list.id == listId);

  /// Operations

  static Future<void> createList(String listName) =>
      _shoppingListsRepository.createList(GroupsService.currentGroup.id, listName);
  static Future<bool> updateList(String listId, String listName) =>
      _shoppingListsRepository.updateList(GroupsService.currentGroup.id, listId, listName);

  /// Streams

  static Stream<List<ShoppingList>> get listsStream =>
      _shoppingListsRepository.listsStream(GroupsService.currentGroup.id);

  static final StreamController<void> _customListsStreamController = StreamController.broadcast();
  static void sinkCustomListsStream() => _customListsStreamController.sink.add(null);
  static Stream<void> get customListsStream => _customListsStreamController.stream;
}
