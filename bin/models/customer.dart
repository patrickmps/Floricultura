// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:xml/xml.dart';

class Customer {
  int? id;
  String? name;
  String? email;
  // String? password;
  String? addressId;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;

  Customer();

  Customer.create(
    this.id,
    this.name,
    this.email,
    this.addressId,
    this.role,
    this.createdAt,
    this.updatedAt,
  );


  Customer copyWith({
    int? id,
    String? name,
    String? email,
    String? addressId,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer.create(
      id ?? this.id,
      name ?? this.name,
      email ?? this.email,
      addressId ?? this.addressId,
      role ?? this.role,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'addressId': addressId,
      'role': role,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer()
      ..id = map['id']
      ..name = map['name']
      ..email = map['email']
      ..addressId = map['address_id']
      ..role = map['role']
      ..createdAt = map['created_at']
      ..updatedAt = map['updated_at'];
  }

  factory Customer.fromRequest(Map<String, dynamic> map) {
    return Customer()
      ..id = map['id']
      ..name = map['name']
      ..email = map['email']
      ..addressId = map['addressId']
      ..role = map['role'];
  }

  String toJson() => json.encode(toMap());

  
  XmlDocument toXml() {
    final builder = XmlBuilder();
    builder.element('customer', nest: () {
      builder.element('id', nest: id);
      builder.element('name', nest: name);
      builder.element('email', nest: email);
      builder.element('addressId', nest: addressId);
      builder.element('role', nest: role);
      builder.element('createdAt', nest: createdAt!.millisecondsSinceEpoch);
      builder.element('updatedAt', nest: updatedAt!.millisecondsSinceEpoch);
    });
    final document = builder.buildDocument();
    return document;
  }

  factory Customer.fromJson(String source) => Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, email: $email, addressId: $addressId, role: $role, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.addressId == addressId &&
      other.role == role &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      addressId.hashCode ^
      role.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
