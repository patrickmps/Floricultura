import 'dart:convert';
import 'dart:io';

import '../../../models/address.dart';
import '../../../models/category.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../../models/supplier.dart';
import '../../../services/address_service.dart';
import '../../../services/category_service.dart';
import '../../../services/order_service.dart';
import '../../../services/product_service.dart';
import '../../../services/supplier_service.dart';

class DBSeeder {
  final AddressService _addressService;
  final SupplierService _supplierService;
  final CategoryService _categoryService;
  final ProductService _productService;
  final OrderService _orderService;
  DBSeeder(this._addressService, this._supplierService, this._categoryService, this._productService, this._orderService);

  Future<Map> _readJsonFile(String path) async {
    var file = await File(path).readAsString();
    var map = jsonDecode(file);

    return map;
  }

  void _addressSeed() async {
    var map = await _readJsonFile("bin/infra/database/seeder/data_seeder.json");

    await map['addresses'].forEach((e) async {
      Address address = Address.fromRequest(e);
      print(address);
      await _addressService
          .save(address)
          .then((response) => response['statusCode'] == 200 ? print('Ok') : print('Erro'));
    });
  }

  void _suppliersSeed() async {
    var map = await _readJsonFile("bin/infra/database/seeder/data_seeder.json");

    await map['suppliers'].forEach((e) async {
      Supplier supplier = Supplier.fromRequest(e);
      print(supplier);
      await _supplierService
          .save(supplier)
         .then((response) => response['statusCode'] == 200 ? print('Ok') : print('Erro'));
    });
  }

  void _categoriesSeed() async {
    var map = await _readJsonFile("bin/infra/database/seeder/data_seeder.json");

    await map['categories'].forEach((e) async {
      Category category = Category.fromRequest(e);
      print(category);
      await _categoryService
          .save(category)
          .then((response) => response['statusCode'] == 200 ? print('Ok') : print('Erro'));
    });
  }

  void _productSeed() async {
    var map = await _readJsonFile("bin/infra/database/seeder/data_seeder.json");

    await map['products'].forEach((e) async {
      Product product = Product.fromRequest(e);
      print(product);
      await _productService
          .save(product)
          .then((response) => response['statusCode'] == 200 ? print('Ok') : print('Erro'));
    });
  }

  void _orderSeed() async {
    var map = await _readJsonFile("bin/infra/database/seeder/data_seeder.json");

    await map['orders'].forEach((e) async {
      Order order = Order.fromRequest(e);
      print(order);
      await _orderService
          .save(order)
          .then((response) => response['statusCode'] == 200 ? print('Ok') : print('Erro'));
    });
  }

  void seeder() async {
    // _addressSeed();
    // _suppliersSeed();
    // _categoriesSeed();
    // _productSeed();
    // _orderSeed();
  }
}
