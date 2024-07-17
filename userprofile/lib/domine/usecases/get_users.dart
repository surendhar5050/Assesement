import 'package:userprofile/data/models/user_model.dart';

import '../repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<Users> execute(int page) async {
    return await repository.getUsers(page);
  }
}
