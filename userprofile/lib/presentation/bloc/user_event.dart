part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}
class LoadUsers extends UserEvent {
  final int page;

  LoadUsers(this.page);
}

class LoadUserDetails extends UserEvent {
  final int userId;

  LoadUserDetails(this.userId);
}