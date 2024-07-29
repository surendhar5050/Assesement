import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:userprofile/presentation/bloc/user_bloc.dart';
import 'data/repositories/user_repository_impl.dart';
import 'data/datasources/user_remote_data_source.dart';
import 'domine/usecases/get_users.dart';
import 'presentation/pages/user_list_page.dart';

void main() {
  final http.Client client = http.Client();
  final UserRemoteDataSource remoteDataSource = UserRemoteDataSource(client);
  final UserRepositoryImpl userRepository =
      UserRepositoryImpl(remoteDataSource);
  final GetUsers getUsers = GetUsers(userRepository);

  runApp(MyApp(getUsers: getUsers));
}

class MyApp extends StatelessWidget {
  final GetUsers ?getUsers;

  MyApp({required this.getUsers});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      fontFamily: GoogleFonts.inter().fontFamily
      ),
      home: BlocProvider(
        create: (context) => UserBloc(getUsers!),
        child: UserListPage(),
      ),
    );
  }
}
