import '../../apis/entrega_api.dart';
import '../../apis/fornecedor_api.dart';
import '../../apis/planta_api.dart';
import '../../apis/venda_api.dart';
import '../../DAO/entrega_dao.dart';
import '../../DAO/fornecedor_dao.dart';
import '../../DAO/planta_dao.dart';
import '../../DAO/venda_dao.dart';
import '../../services/entrega_service.dart';
import '../../services/fornecedor_service.dart';
import '../../services/planta_service.dart';
import '../../services/venda_service.dart';
import '../database/db_configuration.dart';
import '../database/mysql_db_configuration.dart';
import '../database/seeder/db_seeder.dart';
import '../security/security_service.dart';
import '../security/security_service_imp.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<DBConfiguration>(() => MySqlDBConfiguration());
    
    di.register<PlantaDAO>(() => PlantaDAO(di<DBConfiguration>()));
    di.register<PlantaService>(() => PlantaService(di<PlantaDAO>()));
    di.register<PlantaApi>(() => PlantaApi(di<PlantaService>()));

    di.register<FornecedorDAO>(() => FornecedorDAO(di<DBConfiguration>()));
    di.register<FornecedorService>(() => FornecedorService(di<FornecedorDAO>()));
    di.register<FornecedorApi>(() => FornecedorApi(di<FornecedorService>()));    

    di.register<VendaDAO>(() => VendaDAO(di<DBConfiguration>()));
    di.register<VendaService>(() => VendaService(di<VendaDAO>()));
    di.register<VendaApi>(() => VendaApi(di<VendaService>()));  

    di.register<EntregaDAO>(() => EntregaDAO(di<DBConfiguration>()));
    di.register<EntregaService>(() => EntregaService(di<EntregaDAO>()));
    di.register<EntregaApi>(() => EntregaApi(di<EntregaService>()));  

    di.register(() => DBSeeder(di<PlantaService>(), di<FornecedorService>()));


    
    return di;
  }
}
