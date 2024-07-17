import 'package:userprofile/data/models/user_model.dart';

import '../../domine/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Users> getUsers(int page) async {
    return await remoteDataSource.getUsers(page);
  }

  @override
  Future<UsersList> getUser(int id) async {
    return await remoteDataSource.getUser(id);
  }
}
