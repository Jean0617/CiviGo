import '../../domain/user_repository.dart';
import '../auth_user_model.dart';
import '../remote/users_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {

  final UserDatasource datasource;

  UserRepositoryImpl(
    this.datasource,
  );

  @override
  Future<List<AuthUserModel>> getUsers() async {
    final response = await datasource.getUsers();
    return response.map( (e) => AuthUserModel.fromJson(e)).toList();
  }

}