// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:xml/xml.dart';

class Planta {
  int? id;
  int? idFornecedor;
  String? name;
  String? species;
  String? description;
  double? price;
  int? amount;

  Planta();

  Planta.create(
    this.id,
    this.idFornecedor,
    this.name,
    this.species,
    this.description,
    this.price,
    this.amount,
  );

  Planta copyWith({
    int? id,
    int? idFornecedor,
    String? name,
    String? species,
    String? description,
    double? price,
    int? amount,
  }) {
    return Planta.create(
      id ?? this.id,
      idFornecedor ?? this.idFornecedor,
      name ?? this.name,
      species ?? this.species,
      description ?? this.description,
      price ?? this.price,
      amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idFornecedor': idFornecedor,
      'name': name,
      'species': species,
      'description': description,
      'price': price,
      'amount': amount,
    };
  }

  factory Planta.fromMap(Map<String, dynamic> map) {
    return Planta()
      ..id = map['id_planta']
      ..idFornecedor = map['id_fornecedor']
      ..name = map['nome']
      ..species = map['especie']
      ..description = map['descricao'].toString()
      ..price = map['preco']
      ..amount = map['quantidade_em_estoque'];
  }

  factory Planta.fromRequest(Map<String, dynamic> map) {
    return Planta()
      ..id = map.containsKey('id') ? int.parse(map['id'].toString()) : null
      ..idFornecedor = map.containsKey('idFornecedor') ? int.parse(map['idFornecedor'].toString()) : null
      ..name = map['name']
      ..species = map['species']
      ..description = map['description'].toString()
      ..price = map.containsKey('price') ? double.parse(map['price'].toString()) : null
      ..amount = map.containsKey('amount') ? int.parse(map['amount'].toString()) : null;
  }

  String toJson() => json.encode(toMap());

  XmlDocument toXml() {
    final builder = XmlBuilder();
    builder.element('planta', nest: () {
      builder.element('id', nest: id);
      builder.element('idFornecedor', nest: idFornecedor);
      builder.element('name', nest: name);
      builder.element('species', nest: species);
      builder.element('description', nest: description);
      builder.element('price', nest: price);
      builder.element('amount', nest: amount);
    });
    final document = builder.buildDocument();
    return document;
  }

  factory Planta.fromJson(String source) =>
      Planta.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Planta(id: $id, idFornecedor: $idFornecedor, name: $name, species: $species, description: $description, price: $price, amount: $amount)';
  }

  @override
  bool operator ==(covariant Planta other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.idFornecedor == idFornecedor &&
        other.name == name &&
        other.species == species &&
        other.description == description &&
        other.price == price &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idFornecedor.hashCode ^
        name.hashCode ^
        species.hashCode ^
        description.hashCode ^
        price.hashCode ^
        amount.hashCode;
  }
}
