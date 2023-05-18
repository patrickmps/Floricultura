// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:xml/xml.dart';

class Address {
  int? id;
  String? street;
  int? number;
  String? complement;
  String? neighborhood;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  DateTime? createdAt;
  DateTime? updatedAt;

  Address();

  Address.create(
    this.id,
    this.street,
    this.number,
    this.complement,
    this.neighborhood,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.createdAt,
    this.updatedAt,
  );

  Address copyWith({
    int? id,
    String? street,
    int? number,
    String? complement,
    String? neighborhood,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Address.create(
      id ?? this.id,
      street ?? this.street,
      number ?? this.number,
      complement ?? this.complement,
      neighborhood ?? this.neighborhood,
      city ?? this.city,
      state ?? this.state,
      country ?? this.country,
      postalCode ?? this.postalCode,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'street': street,
      'number': number,
      'complement': complement,
      'neighborhood': neighborhood,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address()
      ..id = map['id']
      ..street = map['street']
      ..number = map['number']
      ..complement = map['complement']
      ..neighborhood = map['neighborhood']
      ..city = map['city']
      ..state = map['state']
      ..country = map['country']
      ..postalCode = map['postal_code']
      ..createdAt = map['created_at']
      ..updatedAt = map['updated_at'];
  }

  factory Address.fromRequest(Map<String, dynamic> map) {
    return Address()
      ..id = map['id']
      ..street = map['street']
      ..number = map['number']
      ..complement = map['complement']
      ..neighborhood = map['neighborhood']
      ..city = map['city']
      ..state = map['state']
      ..country = map['country']
      ..postalCode = map['postalCode'];
  }

  String toJson() => json.encode(toMap());

  XmlDocument toXml() {
    final builder = XmlBuilder();
    builder.element('address', nest: () {
      builder.element('id', nest: id);
      builder.element('street', nest: street);
      builder.element('number', nest: number);
      builder.element('complement', nest: complement);
      builder.element('neighborhood', nest: neighborhood);
      builder.element('city', nest: city);
      builder.element('state', nest: state);
      builder.element('country', nest: country);
      builder.element('postalCode', nest: postalCode);
      builder.element('createdAt', nest: createdAt!.millisecondsSinceEpoch);
      builder.element('updatedAt', nest: updatedAt!.millisecondsSinceEpoch);
    });
    final document = builder.buildDocument();
    return document;
  }

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(id: $id, street: $street, number: $number, complement: $complement, neighborhood: $neighborhood, city: $city, state: $state, country: $country, postalCode: $postalCode, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.street == street &&
        other.number == number &&
        other.complement == complement &&
        other.neighborhood == neighborhood &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.postalCode == postalCode &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        street.hashCode ^
        number.hashCode ^
        complement.hashCode ^
        neighborhood.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode ^
        postalCode.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
