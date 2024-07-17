import 'package:userprofile/data/models/user_model.dart';


abstract class UserRepository {
  Future<Users> getUsers(int page);
  Future<UsersList> getUser(int id);
}
