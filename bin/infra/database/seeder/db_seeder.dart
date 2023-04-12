import 'dart:convert';
import 'dart:io';

import '../../../models/fornecedor.dart';
import '../../../models/planta.dart';
import '../../../services/fornecedor_service.dart';
import '../../../services/planta_service.dart';

class DBSeeder {
  final PlantaService _plantaService;
  final FornecedorService _fornecedorService;
  DBSeeder(this._plantaService, this._fornecedorService);

  Future<Map> _readJsonFile(String path) async {
    var file = await File(path).readAsString();
    var map = jsonDecode(file);

    return map;
  }

  void _plantaSeed() async {
    var map = await _readJsonFile("bin/infra/database/seeder/data_seeder.json");

    await map['plantas'].forEach((e) async {
      Planta planta = Planta()
        ..idFornecedor = e['id_fornecedor']
        ..name = e['nome']
        ..species = e['especie']
        ..description = e['descricao']
        ..price = e['preco']
        ..amount = e['quantidade_em_estoque'];

      await _plantaService.save(planta).then((status) => status == 200 ? print('Ok') : print('Erro'));
    });
  }

  void _fornecedorSeed() async {
    var map = await _readJsonFile("bin/infra/database/seeder/data_seeder.json");

    await map['fornecedores'].forEach((e) async {
      Fornecedor fornecedor = Fornecedor()
        ..name = e['nome']
        ..address = e['endereco']
        ..phone = e['telefone'];

      await _fornecedorService.save(fornecedor).then((status) => status == 200 ? print('Ok') : print('Erro'));
    });
  }

  void seeder() {
    _fornecedorSeed();
    _plantaSeed();
  }

}
