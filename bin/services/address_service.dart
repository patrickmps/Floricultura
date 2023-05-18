
import '../DAO/address_dao.dart';
import '../models/address.dart';
import 'generic_service.dart';

class AddressService implements GenericService<Address> {
  final AddressDAO _addressDAO;
  AddressService(this._addressDAO);
  
  @override
  Future<bool> delete(int id) async => await _addressDAO.delete(id);

  @override
  Future<List<Address>> findAll() async => await _addressDAO.findAll();

  @override
  Future<Address?> findOne(int id) async => await _addressDAO.findOne(id);

  @override
  Future<dynamic> save(Address value) async {
    if (value.id != null) {
      return await _addressDAO.update(value);
    } else {
      return await _addressDAO.create(value);
    }
  }

}