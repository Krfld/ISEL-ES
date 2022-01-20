import 'dart:async';
import '../entities/shopping_list.dart';
import '../repositories/shopping_lists_repository.dart';

import '../services/groups_service.dart';

class ShoppingListsService {
  static final ShoppingListsRepository _shoppingListsRepository = ShoppingListsRepositoryCloudFirestore();

  // Lista de listas de compras que estará sempre atualizada
  static List<ShoppingList> shoppingLists = [];

  // Guardar informação da lista que o utilizador irá entrar
  static String? _currentShoppingListId;
  static ShoppingList get currentShoppingList => getList(_currentShoppingListId!);
  static set currentShoppingList(ShoppingList? list) => _currentShoppingListId = list?.id;

  // Obter uma lista de compras da lista de listas de compras que está sempre atualizada
  static ShoppingList getList(String listId) => shoppingLists.singleWhere((list) => list.id == listId);

  /// Streams

  // Stream que atualiza a lista de listas de compras sempre que houver uma alteração
  static Stream<List<ShoppingList>> get listsStream =>
      _shoppingListsRepository.listsStream(GroupsService.currentGroup.id);

  // Stream para atualizar os widgets nas vistas sempre que houver uma alteração
  static final StreamController<void> _customListsStreamController = StreamController.broadcast();
  static void sinkCustomListsStream() => _customListsStreamController.sink.add(null);
  static Stream<void> get customListsStream => _customListsStreamController.stream;
}
