part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}


class UsersLoading extends UserState{}
 
class UsersLoaded extends UserState {
  final Users users;

  UsersLoaded(this.users);
   @override
  List<Object> get props => [users];
}

class UserDetailLoaded extends UserState {
  final UsersList user;

  UserDetailLoaded(this.user);
}

class UserLoadError extends UserState {
  final String message;

  UserLoadError(this.message);
}