import 'package:flutter/material.dart';
import 'package:userprofile/data/models/user_model.dart';

import '../pages/user_details_page.dart';

class UserListItem extends StatelessWidget {
  final UsersList user;

  const UserListItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.avatar),
      ),
      title: Text('${user.firstName} ${user.lastName}'),
      subtitle: Text(user.email),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailPage(user: user),
          ),
        );
      },
    );
  }
}
