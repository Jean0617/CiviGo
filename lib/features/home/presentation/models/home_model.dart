import '../../domain/entities/home_entity.dart';

class HomeModel {

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  HomeModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  HomeModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HomeModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  HomeEntity toEntity() {
    return HomeEntity(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
  
}