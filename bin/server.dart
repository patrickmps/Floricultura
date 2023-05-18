import 'package:shelf/shelf.dart';
import 'apis/address_api.dart';
import 'apis/category_api.dart';
import 'apis/order_api.dart';
import 'apis/products_api.dart';
import 'apis/supplier_api.dart';
import 'infra/custom_server.dart';
import 'infra/database/seeder/db_seeder.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

main() async {
  var _di = Injects.initialize();

  _di.get<DBSeeder>().seeder();

  var cascadeHandler = Cascade()
      .add(_di.get<AddressApi>().getHandler())
      .add(_di.get<ProductApi>().getHandler())
      .add(_di.get<SupplierApi>().getHandler())
      .add(_di.get<CategoryApi>().getHandler())
      .add(_di.get<OrderApi>().getHandler())
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception.middlewareContentType)
      .addMiddleware(corsHeaders())
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
      handler: handler,
      address: await CustomEnv.get<String>(key: 'SERVER_ADDRESS'),
      port: await CustomEnv.get<int>(key: 'PORT'));
}
