// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:xml/xml.dart';

class Entrega {
  int? id;
  int? idVenda;
  DateTime? expectedDate;
  DateTime? deliveryDate;

  Entrega();

  Entrega.create(
    this.id,
    this.idVenda,
    this.expectedDate,
    this.deliveryDate,
  );
  

  Entrega copyWith({
    int? id,
    int? idVenda,
    int? idFornecedor,
    DateTime? expectedDate,
    DateTime? deliveryDate,
  }) {
    return Entrega.create(
      id ?? this.id,
      idVenda ?? this.idVenda,
      expectedDate ?? this.expectedDate,
      deliveryDate ?? this.deliveryDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idVenda': idVenda,
      'expectedDate': expectedDate?.millisecondsSinceEpoch,
      'deliveryDate': deliveryDate?.millisecondsSinceEpoch,
    };
  }

  factory Entrega.fromMap(Map<String, dynamic> map) {
    return Entrega()
      ..id = map['id_entrega']
      ..idVenda = map['id_venda']
      ..expectedDate = map['data_prevista']
      ..deliveryDate = map['data_entrega'];
  }

  factory Entrega.fromRequest(Map<String, dynamic> map) {
    return Entrega()
      ..id = map.containsKey('id') ? int.parse(map['id'].toString()) : null
      ..idVenda = map.containsKey('idVenda') ? int.parse(map['idVenda'].toString()) : null
      ..expectedDate = map.containsKey('expectedDate') ? DateTime.parse(map['expectedDate'].toString()) : null
      ..deliveryDate = map.containsKey('deliveryDate') ? DateTime.parse(map['deliveryDate'].toString()) : null;
  }

  String toJson() => json.encode(toMap());

  XmlDocument toXml() {
    final builder = XmlBuilder();
    builder.element('delivery', nest: () {
      builder.element('id', nest: id);
      builder.element('idVenda', nest: idVenda);
      builder.element('expectedDate', nest: expectedDate?.millisecondsSinceEpoch);
      builder.element('deliveryDate', nest: deliveryDate?.millisecondsSinceEpoch);
    });
    final document = builder.buildDocument();
    return document;
  }

  factory Entrega.fromJson(String source) => Entrega.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Entrega(id: $id, idVenda: $idVenda, expectedDate: $expectedDate, deliveryDate: $deliveryDate)';
  }

  @override
  bool operator ==(covariant Entrega other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.idVenda == idVenda &&
      other.expectedDate == expectedDate &&
      other.deliveryDate == deliveryDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      idVenda.hashCode ^
      expectedDate.hashCode ^
      deliveryDate.hashCode;
  }
}
