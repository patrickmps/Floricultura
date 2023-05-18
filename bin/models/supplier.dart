// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:xml/xml.dart';

class Supplier {
  int? id;
  String? name;
  int? addressId;
  String? email;
  String? phone;
  DateTime? createdAt;
  DateTime? updatedAt;

  Supplier();

  Supplier.create(
    this.id,
    this.name,
    this.addressId,
    this.email,
    this.phone,
    this.createdAt,
    this.updatedAt,
  );


  Supplier copyWith({
    int? id,
    String? name,
    int? addressId,
    String? email,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Supplier.create(
      id ?? this.id,
      name ?? this.name,
      addressId ?? this.addressId,
      email ?? this.email,
      phone ?? this.phone,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'addressId': addressId,
      'email': email,
      'phone': phone,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier()
      ..id = map['id'] 
      ..name = map['name'] 
      ..addressId = map['address_id'] 
      ..email = map['email'] 
      ..phone = map['phone'] 
      ..createdAt = map['created_at']
      ..updatedAt = map['updated_at'];
  }

  factory Supplier.fromRequest(Map<String, dynamic> map) {
    return Supplier()
      ..id = map['id']
      ..name = map['name']
      ..addressId = map['addressId'] 
      ..email = map['email'] 
      ..phone = map['phone'];
  }

  String toJson() => json.encode(toMap());

  XmlDocument toXml() {
    final builder = XmlBuilder();
    builder.element('supplier', nest: () {
      builder.element('id', nest: id);
      builder.element('name', nest: name);
      builder.element('addressId', nest: addressId);
      builder.element('email', nest: email);
      builder.element('phone', nest: phone);
      builder.element('createdAt', nest: createdAt!.millisecondsSinceEpoch);
      builder.element('updatedAt', nest: updatedAt!.millisecondsSinceEpoch);
    });
    final document = builder.buildDocument();
    return document;
  }

  factory Supplier.fromJson(String source) => Supplier.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Supplier(id: $id, name: $name, addressId: $addressId, email: $email, phone: $phone, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Supplier other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.addressId == addressId &&
      other.email == email &&
      other.phone == phone &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      addressId.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
