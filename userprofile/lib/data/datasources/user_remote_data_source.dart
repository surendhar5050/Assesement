import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSource(this.client);

  Future<Users> getUsers(int page) async {
   try {
      final response =
        await client.get(Uri.parse('https://reqres.in/api/users?page=$page'));
    if (response.statusCode == 200) {
      // print(response.body);
      final jsonData = json.decode(response.body);
      print(jsonData);
      return usersFromJson(response.body);
    } else {
      
      throw Exception('Failed to load users');
    }
   } catch (e) {
     print(e.toString());
           throw Exception('Failed to load users');

   }
  }

  Future<UsersList> getUser(int id) async {
    final response =
        await client.get(Uri.parse('https://reqres.in/api/users/$id'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return UsersList.fromJson(jsonData);
    } else {
      throw Exception('Failed to load user');
    }
  }
}