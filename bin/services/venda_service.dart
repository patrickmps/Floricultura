
import '../models/venda.dart';
import '../DAO/venda_dao.dart';
import 'generic_service.dart';

class VendaService implements GenericService<Venda> {
  final VendaDAO _vendaDAO;
  VendaService(this._vendaDAO);

  @override
  Future<bool> delete(int id) async => await _vendaDAO.delete(id);

  @override
  Future<List<Venda>> findAll() async => await _vendaDAO.findAll();

  @override
  Future<Venda?> findOne(int id) async => await _vendaDAO.findOne(id);

  @override
  Future<int> save(Venda value) async {
    if (value.id != null) {
      return await _vendaDAO.update(value);
    } else {
      return await _vendaDAO.create(value);
    }
  }
  
}