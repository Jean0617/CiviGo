import '../../domain/entities/auth_entity.dart';

class BaseModel {

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  BaseModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  BaseModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BaseModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  BaseEntity toEntity() {
    return BaseEntity(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
  
}