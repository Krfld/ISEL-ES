import 'dart:async';
import '../models/shopping_list.dart';
import '../repositories/shopping_lists_repository.dart';

class ShoppingListsService {
  static List<ShoppingList> lists = [];

  static String? _currentListId;
  static ShoppingList get currentList => getList(_currentListId!);
  static set currentList(ShoppingList? list) => _currentListId = list?.id;

  static ShoppingList getList(String listId) => lists.singleWhere((list) => list.id == listId);

  /// Streams
  static Stream<List<ShoppingList>> get firestoreListsStream => ShoppingListsRepository.firestoreListsStream
      .map((snapshot) => snapshot.docs.map((doc) => ShoppingList.fromMap(doc.id, doc.data())).toList()..sort());

  static final StreamController<void> _listsStreamController = StreamController.broadcast();
  static void sinkListsStream() => _listsStreamController.sink.add(null);
  static Stream<void> get listsStream => _listsStreamController.stream;
}
