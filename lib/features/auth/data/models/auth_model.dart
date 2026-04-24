import '../../domain/entities/auth_entity.dart';

class AuthModel {

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  AuthModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  AuthModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AuthModel(
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