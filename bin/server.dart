import 'package:shelf/shelf.dart';
import 'apis/entrega_api.dart';
import 'apis/fornecedor_api.dart';
import 'apis/planta_api.dart';
import 'apis/venda_api.dart';
import 'infra/custom_server.dart';
import 'infra/database/seeder/db_seeder.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

main() async {
  var _di = Injects.initialize();

  // _di.get<DBSeeder>().seeder();

  var cascadeHandler = Cascade()
      .add(_di.get<PlantaApi>().getHandler())
      .add(_di.get<FornecedorApi>().getHandler())
      .add(_di.get<VendaApi>().getHandler())
      .add(_di.get<EntregaApi>().getHandler())
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception.cors)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
      handler: handler,
      address: await CustomEnv.get<String>(key: 'SERVER_ADDRESS'),
      port: await CustomEnv.get<int>(key: 'PORT'));
}
