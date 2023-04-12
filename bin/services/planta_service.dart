import '../models/planta.dart';
import '../DAO/planta_dao.dart';
import 'generic_service.dart';

class PlantaService implements GenericService<Planta> {
  final PlantaDAO _plantaDAO;
  PlantaService(this._plantaDAO);

  @override
  Future<bool> delete(int id) async => await _plantaDAO.delete(id);

  @override
  Future<List<Planta>> findAll() async => await _plantaDAO.findAll();

  @override
  Future<Planta?> findOne(int id) async => await _plantaDAO.findOne(id);

  @override
  Future<int> save(Planta value) async {
    if (value.id != null) {
      return await _plantaDAO.update(value);
    } else {
      return await _plantaDAO.create(value);
    }
  }
}
