
import '../models/entrega.dart';
import '../DAO/entrega_dao.dart';
import 'generic_service.dart';

class EntregaService implements GenericService<Entrega> {
  final EntregaDAO _entregaDAO;
  EntregaService(this._entregaDAO);

 @override
  Future<bool> delete(int id) async => await _entregaDAO.delete(id);

  @override
  Future<List<Entrega>> findAll() async => await _entregaDAO.findAll();

  @override
  Future<Entrega?> findOne(int id) async => await _entregaDAO.findOne(id);

  @override
  Future<int> save(Entrega value) async {
    if (value.id != null) {
      return await _entregaDAO.update(value);
    } else {
      return await _entregaDAO.create(value);
    }
  }
  
}