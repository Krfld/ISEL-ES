import 'dart:io';

import './services/products_service.dart';
import './entities/product.dart';
import './entities/signature.dart';

import './services/groups_service.dart';
import './entities/group.dart';

// Apenas para verificar os grupos já guardados na base de dados
import './repositories/groups_repository.dart';

void main(List<String> arguments) async {
  print('');
  print('-' * 100);
  print('Assuming user is "u1"\n');

  final TestBuyProducts testBuyProducts = TestBuyProducts();
  await testBuyProducts.execute();

  final TestCreateGroup testCreateGroup = TestCreateGroup();
  await testCreateGroup.execute();

  print('-' * 100);
  print('Press enter to close...');
  stdin.readLineSync();
}

class TestBuyProducts {
  final List<Product> expectedBuyingProducts = [
    Product(
      id: 'p1',
      name: 'a',
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
    ),
    Product(
      id: 'p2',
      name: 'b',
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
      bought: Signature(user: 'u1', timestamp: currentTime.subtract(Duration(hours: 2))),
    ),
  ];

  final List<Product> expectedBuyingProductsAfterBuyingP1 = [
    Product(
      id: 'p1',
      name: 'a',
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
      bought: Signature(user: 'u1', timestamp: currentTime),
    ),
    Product(
      id: 'p2',
      name: 'b',
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
      bought: Signature(user: 'u1', timestamp: currentTime.subtract(Duration(hours: 2))),
    ),
  ];

  final List<Product> expectedBuyingProductsAfterUnbuyingP2 = [
    Product(
      id: 'p1',
      name: 'a',
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
      bought: Signature(user: 'u1', timestamp: currentTime),
    ),
    Product(
      id: 'p2',
      name: 'b',
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
    ),
  ];

  static final DateTime currentTime = DateTime.utc(2021, 6, 15, 13); // For testing
  static final DateTime dateAdded = currentTime.subtract(Duration(days: 2)); // For testing

  Future execute() async {
    print('-' * 100);
    print('Executing use case - Buy Products\n');

    // Assumir um tempo atual
    print('-' * 100);
    print('Assuming current time: $currentTime\n');

    print('-' * 100);
    await verifyProducts();
    print('-' * 100);
    await verifyBuyProduct();
    print('-' * 100);
    await verifyUnbuyProduct();
  }

  Future verifyProducts() async {
    // Atualizar a lista de produtos
    await ProductsService.productsStream.listen((event) => ProductsService.products = event).asFuture();
    // await garante ter terminado a receção da base de dados de teste e atualização dos produtos

    // Produtos na base de dados
    print('Produtos atuais na base de dados:\n${ProductsService.products}\n');

    // Produtos que o utilizador devia ver
    print('Produtos que o utilizador devia ver:\n$expectedBuyingProducts\n');
    // Produtos que o utilizador vê
    print('Produtos que o utilizador vê:\n${ProductsService.buyingProducts}\n');
  }

  Future verifyBuyProduct() async {
    ProductsService.buyProduct(ProductsService.getProduct('p1'));

    // Atualizar a lista de produtos
    await ProductsService.productsStream.listen((event) => ProductsService.products = event).asFuture();

    print('Produtos que o utilizador devia ver após comprar p1:\n$expectedBuyingProductsAfterBuyingP1\n');

    print('Produtos que o utilizador vê após comprar p1:\n${ProductsService.buyingProducts}\n');
  }

  Future verifyUnbuyProduct() async {
    ProductsService.unbuyProduct(ProductsService.getProduct('p2'));

    // Atualizar a lista de produtos
    await ProductsService.productsStream.listen((event) => ProductsService.products = event).asFuture();

    print(
        'Produtos que o utilizador devia ver após cancelar a compra de p2:\n$expectedBuyingProductsAfterUnbuyingP2\n');

    print('Produtos que o utilizador vê após cancelar a compra de p2:\n${ProductsService.buyingProducts}\n');
  }
}

class TestCreateGroup {
  final List<Group> _expectedGroups = [
    Group(id: 'g1', name: 'group 1', users: ['u1']),
    Group(id: 'g2', name: 'group 2', users: ['u1', 'u2']),
  ];

  final List<Group> _expectedGroupsAfterCreatingGroup4 = [
    Group(id: 'g1', name: 'group 1', users: ['u1']),
    Group(id: 'g2', name: 'group 2', users: ['u1', 'u2']),
    Group(id: 'g4', name: 'group 4', users: ['u1']),
  ];

  Future execute() async {
    print('-' * 100);
    print('Executing use case - Create group\n');

    print('-' * 100);
    await verifyGroups();
    print('-' * 100);
    await verifyCreateGroup();
  }

  Future verifyGroups() async {
    // Atualizar a lista de grupos
    await GroupsService.groupsStream.listen((event) => GroupsService.groups = event).asFuture();

    // Grupos na base de dados
    print('Grupos atuais na base de dados:\n${GroupsRepositoryTest().groups}\n');

    // Grupos a que o utilizador pertence
    print('Grupos a que o utilizador pertence:\n${GroupsService.groups}\n');

    // Grupos a que o utilizador devia pertencer
    print('Grupos a que o utilizador devia pertencer:\n$_expectedGroups\n');
  }

  Future verifyCreateGroup() async {
    GroupsService.createGroup('group 4');

    // Atualizar a lista de grupos
    await GroupsService.groupsStream.listen((event) => GroupsService.groups = event).asFuture();

    // Grupos a que o utilizador devia pertencer após criar o grupo 4
    print('Grupos a que o utilizador devia pertencer após criar o grupo 4:\n$_expectedGroupsAfterCreatingGroup4\n');

    // Grupos a que o utilizador pertence após criar o grupo 4
    print('Grupos a que o utilizador pertence após criar o grupo 4:\n${GroupsService.groups}\n');
  }
}
