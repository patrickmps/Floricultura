// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:xml/xml.dart';

class Product {
  int? id;
  String? name;
  String? description;
  double? price;
  int? amount;
  int? categoryId;
  int? supplierId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product();

  Product.create(
    this.id,
    this.name,
    this.description,
    this.price,
    this.amount,
    this.categoryId,
    this.supplierId,
    this.createdAt,
    this.updatedAt,
  );

  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    int? amount,
    int? categoryId,
    int? supplierId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product.create(
      id ?? this.id,
      name ?? this.name,
      description ?? this.description,
      price ?? this.price,
      amount ?? this.amount,
      categoryId ?? this.categoryId,
      supplierId ?? this.supplierId,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "amount": amount,
      "categoryId": categoryId,
      "supplierId": supplierId,
      "createdAt": createdAt!.millisecondsSinceEpoch,
      "updatedAt": updatedAt!.millisecondsSinceEpoch,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product()
      ..id = map['id']
      ..name = map['name']
      ..description = map['description'].toString()
      ..price = map['price']
      ..amount = map['amount']
      ..categoryId = map['category_id']
      ..supplierId = map['supplier_id']
      ..createdAt = map['created_at']
      ..updatedAt = map['updated_at'];
  }

  factory Product.fromRequest(Map<String, dynamic> map) {
    return Product()
      ..id = map['id']
      ..name = map['name']
      ..description =
          map.containsKey('description') ? map['description'].toString() : null
      ..price = map.containsKey('price')
          ? double.parse(map['price'].toString())
          : null
      ..amount =
          map.containsKey('amount') ? int.parse(map['amount'].toString()) : null
      ..categoryId = map.containsKey('categoryId')
          ? int.parse(map['categoryId'].toString())
          : null
      ..supplierId = map.containsKey('supplierId')
          ? int.parse(map['supplierId'].toString())
          : null;
  }

  String toJson() => json.encode(toMap());

  XmlDocument toXml() {
    final builder = XmlBuilder();
    builder.element('product', nest: () {
      builder.element('id', nest: id);
      builder.element('name', nest: name);
      builder.element('description', nest: description);
      builder.element('price', nest: price);
      builder.element('amount', nest: amount);
      builder.element('categoryId', nest: categoryId);
      builder.element('supplierId', nest: supplierId);
      builder.element('createdAt', nest: createdAt!.millisecondsSinceEpoch);
      builder.element('updatedAt', nest: updatedAt!.millisecondsSinceEpoch);
    });
    final document = builder.buildDocument();
    return document;
  }

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, amount: $amount, categoryId: $categoryId, supplierId: $supplierId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.amount == amount &&
        other.categoryId == categoryId &&
        other.supplierId == supplierId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        amount.hashCode ^
        categoryId.hashCode ^
        supplierId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
