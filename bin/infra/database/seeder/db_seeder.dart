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
  DBSeeder(this._addressService, this._supplierService, this._categoryService,
      this._productService, this._orderService);

  Future<Map> _readJsonFile(String path) async {
    var file = await File(path).readAsString();
    var map = jsonDecode(file);

    return map;
  }

  void _addressSeed() async {
    var map = await _readJsonFile("bin/infra/database/seeder/data_seeder.json");

    try {
      await map['addresses'].forEach((e) async {
        Address address = Address.fromRequest(e);
        await _addressService.save(address);
      });
      print('Address seed: OK!');
    } catch (e) {
      print(e);
    }
  }

  void _suppliersSeed() async {
    var map = await _readJsonFile("bin/infra/database/seeder/data_seeder.json");

    try {
      await map['suppliers'].forEach((e) async {
        Supplier supplier = Supplier.fromRequest(e);
        await _supplierService.save(supplier);
      });
      print('Suppliers seed: OK!');
    } catch (e) {
      print(e);
    }
  }

  void _categoriesSeed() async {
    var map = await _readJsonFile("bin/infra/database/seeder/data_seeder.json");

    try {
      await map['categories'].forEach((e) async {
        Category category = Category.fromRequest(e);
        await _categoryService.save(category);
      });
      print('Categories seed: OK!');
    } catch (e) {
      print(e);
    }
  }

  void _productSeed() async {
    var map = await _readJsonFile("bin/infra/database/seeder/data_seeder.json");
    try {
      await map['products'].forEach((e) async {
        Product product = Product.fromRequest(e);
        await _productService.save(product);
      });
      print('Products seed: OK!');
    } catch (e) {
      print(e);
    }
  }

  void _orderSeed() async {
    var map = await _readJsonFile("bin/infra/database/seeder/data_seeder.json");
    try {
      await map['orders'].forEach((e) async {
        Order order = Order.fromRequest(e);
        await _orderService.save(order);
      });
      print('Orders seed: OK!');
    } catch (e) {
      print(e);
    }
  }

  void seeder() async {
    Future.wait([
      Future.delayed(const Duration(milliseconds: 200), () => _addressSeed()),
      Future.delayed(const Duration(milliseconds: 400), () => _categoriesSeed()),
      Future.delayed(const Duration(milliseconds: 600), () => _suppliersSeed()),
      Future.delayed(const Duration(milliseconds: 800), () => _productSeed()),
      Future.delayed(const Duration(milliseconds: 1000), () => _orderSeed()),
    ]);
  }
}
