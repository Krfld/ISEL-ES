import 'dart:async';
import '../models/shopping_list.dart';
import '../repositories/shopping_lists_repository.dart';

import '../services/groups_service.dart';

class ShoppingListsService {
  static final ShoppingListsRepository _shoppingListsRepository = ShoppingListsRepository();

  static List<ShoppingList> lists = [];

  static String? _currentListId;
  static ShoppingList get currentList => getList(_currentListId!);
  static set currentList(ShoppingList? list) => _currentListId = list?.id;

  static ShoppingList getList(String listId) => lists.singleWhere((list) => list.id == listId);

  /// Repository

  static Future<void> createList(String listName) =>
      _shoppingListsRepository.createList(GroupsService.currentGroup.id, listName);
  static Future<bool> updateList(String listId, String listName) =>
      _shoppingListsRepository.updateList(GroupsService.currentGroup.id, listId, listName);

  /// Streams

  static Stream<List<ShoppingList>> get firestoreListsStream => _shoppingListsRepository
      .firestoreListsStream(GroupsService.currentGroup.id)
      .map((snapshot) => snapshot.docs.map((doc) => ShoppingList.fromMap(doc.id, doc.data())).toList()..sort());

  static final StreamController<void> _listsStreamController = StreamController.broadcast();
  static void sinkListsStream() => _listsStreamController.sink.add(null);
  static Stream<void> get listsStream => _listsStreamController.stream;
}
