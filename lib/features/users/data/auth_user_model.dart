class AuthUserModel {

  final String id;
  final String email;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? lastSignInAt;
  final DateTime? emailConfirmedAt;
  final String? phone;
  final Map<String, dynamic> metadata;

  const AuthUserModel({
    required this.id,
    required this.email,
    required this.createdAt,
    this.updatedAt,
    this.lastSignInAt,
    this.emailConfirmedAt,
    this.phone,
    required this.metadata,
  });

  String get name => metadata['name'] ?? '';

  String get role => metadata['role'] ?? '';

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {

    return AuthUserModel(
      id: json['id'],
      email: json['email'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      lastSignInAt: json['last_sign_in_at'] != null
          ? DateTime.parse(json['last_sign_in_at'])
          : null,
      emailConfirmedAt: json['email_confirmed_at'] != null
          ? DateTime.parse(json['email_confirmed_at'])
          : null,
      phone: json['phone'],
      metadata: Map<String, dynamic>.from(
        json['metadata'] ?? {},
      ),
    );
  }
}