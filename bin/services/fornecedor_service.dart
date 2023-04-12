import '../models/fornecedor.dart';
import '../DAO/fornecedor_dao.dart';
import 'generic_service.dart';

class FornecedorService implements GenericService<Fornecedor> {
  final FornecedorDAO _fornecedorDAO;
  FornecedorService(this._fornecedorDAO);

  @override
  Future<bool> delete(int id) async => await _fornecedorDAO.delete(id);

  @override
  Future<List<Fornecedor>> findAll() async => await _fornecedorDAO.findAll();

  @override
  Future<Fornecedor?> findOne(int id) async => await _fornecedorDAO.findOne(id);

  @override
  Future<int> save(Fornecedor value) async {
    if (value.id != null) {
      return await _fornecedorDAO.update(value);
    } else {
      return await _fornecedorDAO.create(value);
    }
  }
}
