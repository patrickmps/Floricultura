// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:xml/xml.dart';

// CREATE TABLE vendas (
//   id_venda INT PRIMARY KEY,
//   data DATE,
//   id_planta INT,
//   quantidade INT,
//   valor_total DECIMAL(10,2),
//   FOREIGN KEY (id_planta) REFERENCES plantas(id_planta)
// );

class Venda {
  int? id;
  DateTime? date;
  int? idPlanta;
  int? amount;
  double? value;

  Venda();

  Venda.create(
    this.id,
    this.date,
    this.idPlanta,
    this.amount,
    this.value,
  );

  Venda copyWith({
    int? id,
    DateTime? date,
    int? idPlanta,
    int? amount,
    double? value,
  }) {
    return Venda.create(
      id ?? this.id,
      date ?? this.date,
      idPlanta ?? this.idPlanta,
      amount ?? this.amount,
      value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date?.millisecondsSinceEpoch,
      'idPlanta': idPlanta,
      'amount': amount,
      'value': value,
    };
  }

  factory Venda.fromMap(Map<String, dynamic> map) {

    return Venda()
      ..id = map['id_venda']
      ..date = map['dt_criacao']
      ..idPlanta = map['id_planta']
      ..amount = map['quantidade']
      ..value = map['valor_total'];
  }

  factory Venda.fromRequest(Map<String, dynamic> map) {
    return Venda()
      ..idPlanta = map['idPlanta']
      ..amount = map['amount']
      ..value = map['value'];
  }

  String toJson() => json.encode(toMap());

  XmlDocument toXml() {
    final builder = XmlBuilder();
    builder.element('venda', nest: () {
      builder.element('id', nest: id);
      builder.element('data', nest: date?.microsecondsSinceEpoch);
      builder.element('id_planta', nest: idPlanta);
      builder.element('quantidade', nest: amount);
      builder.element('valor_total', nest: value);
    });
    final document = builder.buildDocument();
    return document;
  }

  factory Venda.fromJson(String source) =>
      Venda.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Venda(id: $id, date: $date, idPlanta: $idPlanta, amount: $amount, value: $value)';
  }

  @override
  bool operator ==(covariant Venda other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.date == date &&
        other.idPlanta == idPlanta &&
        other.amount == amount &&
        other.value == value;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        idPlanta.hashCode ^
        amount.hashCode ^
        value.hashCode;
  }
}
