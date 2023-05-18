// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:xml/xml.dart';

class Category {
  int? id;
  String? category;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category();

  Category.create(
    this.id,
    this.category,
    this.createdAt,
    this.updatedAt,
  );


  Category copyWith({
    int? id,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category.create(
      id ?? this.id,
      category ?? this.category,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category()
      ..id= map['id']
      ..category= map['category']
      ..createdAt= map['created_at']
      ..updatedAt= map['updated_at'];
  }

  factory Category.fromRequest(Map<String, dynamic> map) {
    return Category()
      ..id= map['id']
      ..category= map['category'];

  }

  String toJson() => json.encode(toMap());

  XmlDocument toXml() {
    final builder = XmlBuilder();
    builder.element('category', nest: () {
      builder.element('id', nest: id);
      builder.element('categoryName', nest: category);
      builder.element('createdAt', nest: createdAt!.millisecondsSinceEpoch);
      builder.element('updatedAt', nest: updatedAt!.millisecondsSinceEpoch);
    });
    final document = builder.buildDocument();
    return document;
  }

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(id: $id, category: $category, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.category == category &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      category.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
