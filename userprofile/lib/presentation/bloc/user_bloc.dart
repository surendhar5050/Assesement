import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:userprofile/data/models/user_model.dart';
import 'package:userprofile/domine/usecases/get_users.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;

  UserBloc(this.getUsers) : super(UserInitial()) {
       on<LoadUsers>((event, emit) async {
      try {
        final users = await getUsers.execute(event.page);

        emit(UsersLoaded(users));
      } catch (e) {
        emit(UserLoadError(e.toString()));
      }
    });
  }
}
