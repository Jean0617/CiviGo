import '../data/auth_user_model.dart';

abstract interface class UserRepository {

  Future<List<AuthUserModel>> getUsers();

}