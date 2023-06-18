// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:xml/xml.dart';


class Order {
  int? id;
  int? productId;
  // int? customerId;
  int? amount;
  double? totalPrice;
  int? shippingAddressId;
  DateTime? expectedDate;
  DateTime? deliveryDate;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Order();

  Order.create(
    this.id,
    this.productId,
    this.amount,
    this.totalPrice,
    this.shippingAddressId,
    this.expectedDate,
    this.deliveryDate,
    this.status,
    this.createdAt,
    this.updatedAt,
  );


  Order copyWith({
    int? id,
    int? productId,
    int? customerId,
    int? amount,
    double? totalPrice,
    int? shippingAddressId,
    DateTime? expectedDate,
    DateTime? deliveryDate,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order.create(
      id ?? this.id,
      productId ?? this.productId,
      amount ?? this.amount,
      totalPrice ?? this.totalPrice,
      shippingAddressId ?? this.shippingAddressId,
      expectedDate ?? this.expectedDate,
      deliveryDate ?? this.deliveryDate,
      status ?? this.status,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'amount': amount,
      'totalPrice': totalPrice,
      'shippingAddressId': shippingAddressId,
      'expectedDate': expectedDate?.millisecondsSinceEpoch,
      'deliveryDate': deliveryDate?.millisecondsSinceEpoch,
      'status': status,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order()
      ..id = map['id']
      ..productId = map['product_id']
      ..amount = map['amount']
      ..totalPrice = map['total_price']
      ..shippingAddressId = map['shipping_address_id']
      ..expectedDate = map['expected_date']
      ..deliveryDate = map['delivery_date']
      ..status = map['status']
      ..createdAt = map['created_at']
      ..updatedAt = map['updated_at'];
  }

  factory Order.fromRequest(Map<String, dynamic> map) {
    return Order()
      ..id = map['id']
      ..productId = map['productId']
      ..amount = map['amount']
      ..totalPrice = map['totalPrice']
      ..shippingAddressId = map['shippingAddressId'] != null ? (map['shippingAddressId'] is int ? map['shippingAddressId'] : int.parse(map['shippingAddressId'])) : null
      ..expectedDate = DateTime.tryParse(map['expectedDate'])?.toUtc()
      ..deliveryDate = map['deliveryDate'] == Null ? DateTime.tryParse(map['deliveryDate'])?.toUtc() : null
      ..status = map['status'];
  }

  String toJson() => json.encode(toMap());

  XmlDocument toXml() {
    final builder = XmlBuilder();
    builder.element('order', nest: () {
      builder.element('id', nest: id);
      builder.element('productId', nest: productId);
      builder.element('amount', nest: amount);
      builder.element('totalPrice', nest: totalPrice);
      builder.element('shippingAddressId', nest: shippingAddressId);
      builder.element('expectedDate', nest: expectedDate);
      builder.element('deliveryDate', nest: deliveryDate);
      builder.element('status', nest: status);
      builder.element('createdAt', nest: createdAt!.millisecondsSinceEpoch);
      builder.element('updatedAt', nest: updatedAt!.millisecondsSinceEpoch);
    });
    final document = builder.buildDocument();
    return document;
  }
  
  factory Order.fromJson(String source) => Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, productId: $productId, amount: $amount, totalPrice: $totalPrice, shippingAddressId: $shippingAddressId, expectedDate: $expectedDate, deliveryDate: $deliveryDate, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.productId == productId &&
      other.amount == amount &&
      other.totalPrice == totalPrice &&
      other.shippingAddressId == shippingAddressId &&
      other.expectedDate == expectedDate &&
      other.deliveryDate == deliveryDate &&
      other.status == status &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      productId.hashCode ^
      amount.hashCode ^
      totalPrice.hashCode ^
      shippingAddressId.hashCode ^
      expectedDate.hashCode ^
      deliveryDate.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
