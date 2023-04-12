// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:xml/xml.dart';
// CREATE TABLE fornecedores (
//   id_fornecedor INT PRIMARY KEY,
//   nome VARCHAR(255),
//   endereco VARCHAR(255),
//   telefone VARCHAR(20)
// );

class Fornecedor {
  int? id;
  String? name;
  String? address;
  String? phone;

  Fornecedor();

  Fornecedor.create(
    this.id,
    this.name,
    this.address,
    this.phone,
  );

  Fornecedor copyWith({
    int? id,
    String? name,
    String? address,
    String? phone,
  }) {
    return Fornecedor.create(
      id ?? this.id,
      name ?? this.name,
      address ?? this.address,
      phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
    };
  }

  factory Fornecedor.fromMap(Map<String, dynamic> map) {
    return Fornecedor()
      ..id = map['id_fornecedor']
      ..name = map['nome']
      ..address = map['endereco']
      ..phone = map['telefone'];
  }

  factory Fornecedor.fromRequest(Map<String, dynamic> map) {
    return Fornecedor()
      ..id = map.containsKey('id') ? int.parse(map['id'].toString()) : null
      ..name = map['name']
      ..address = map['address']
      ..phone = map['phone'];
  }

  String toJson() => json.encode(toMap());

  XmlDocument toXml() {
    final builder = XmlBuilder();
    builder.element('fornecedor', nest: () {
      builder.element('id', nest: id);
      builder.element('nome', nest: name);
      builder.element('address', nest: address);
      builder.element('phone', nest: phone);
    });
    final document = builder.buildDocument();
    return document;
  }

  factory Fornecedor.fromJson(String source) =>
      Fornecedor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Forncedor(id: $id, name: $name, address: $address, phone: $phone)';
  }

  @override
  bool operator ==(covariant Fornecedor other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.address == address &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ address.hashCode ^ phone.hashCode;
  }
}
