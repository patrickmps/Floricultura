import '../../DAO/address_dao.dart';
import '../../DAO/category_dao.dart';
import '../../DAO/order_dao.dart';
import '../../DAO/supplier_dao.dart';
import '../../apis/address_api.dart';
import '../../apis/category_api.dart';
import '../../apis/order_api.dart';
import '../../apis/products_api.dart';
import '../../DAO/product_dao.dart';
import '../../apis/supplier_api.dart';
import '../../services/address_service.dart';
import '../../services/category_service.dart';
import '../../services/order_service.dart';
import '../../services/product_service.dart';
import '../../services/supplier_service.dart';
import '../database/db_configuration.dart';
import '../database/mysql_db_configuration.dart';
import '../database/seeder/db_seeder.dart';
// import '../security/security_service.dart';
// import '../security/security_service_imp.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<DBConfiguration>(() => MySqlDBConfiguration());

    di.register(() => DBSeeder(di<AddressService>(), di<SupplierService>(),
        di<CategoryService>(), di<ProductService>(), di<OrderService>()));

    di.register<AddressDAO>(() => AddressDAO(di<DBConfiguration>()));
    di.register<AddressService>(() => AddressService(di<AddressDAO>()));
    di.register<AddressApi>(() => AddressApi(di<AddressService>()));

    di.register<ProductDAO>(() => ProductDAO(di<DBConfiguration>()));
    di.register<ProductService>(() => ProductService(di<ProductDAO>()));
    di.register<ProductApi>(() => ProductApi(di<ProductService>()));

    di.register<SupplierDAO>(() => SupplierDAO(di<DBConfiguration>()));
    di.register<SupplierService>(() => SupplierService(di<SupplierDAO>()));
    di.register<SupplierApi>(() => SupplierApi(di<SupplierService>()));

    di.register<CategoryDAO>(() => CategoryDAO(di<DBConfiguration>()));
    di.register<CategoryService>(() => CategoryService(di<CategoryDAO>()));
    di.register<CategoryApi>(() => CategoryApi(di<CategoryService>()));

    di.register<OrderDAO>(() => OrderDAO(di<DBConfiguration>()));
    di.register<OrderService>(() => OrderService(di<OrderDAO>()));
    di.register<OrderApi>(() => OrderApi(di<OrderService>()));

    return di;
  }
}
