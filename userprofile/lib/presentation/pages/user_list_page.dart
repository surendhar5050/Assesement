import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animations/animations.dart';
import 'package:userprofile/presentation/bloc/user_bloc.dart';
import 'package:userprofile/presentation/pages/user_details_page.dart';

import '../widgets/user_list_item.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    context.read<UserBloc>().add(LoadUsers(2));
    // _bloc.add(LoadUsers(_currentPage));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        _loadMoreUsers();
      }
    });
  }

  void _loadMoreUsers() async {
    _currentPage++;
    // _bloc.add(LoadUsers(_currentPage));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
        ),
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UsersLoaded) {
              isLoading = false;
            }
          },
          builder: (context, state) {
            if (state is UserLoadError) {
              return Center(child: Text(state.message));
            } else if (state is UsersLoaded) {
              if (state.users.usersList.isEmpty) {
                return const Center(child: Text('No users'));
              } else {
                final users = state.users.usersList;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.separated(
                        controller: _scrollController, // Attach the controller
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return OpenContainer(
                            openColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            closedColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            openElevation: 0,
                            closedElevation: 0,
                            closedShape: const RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0,
                                    color: Colors.transparent,
                                    style: BorderStyle.none),
                                borderRadius: BorderRadius.all(Radius.zero)),
                            openShape: const RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0,
                                    color: Colors.transparent,
                                    style: BorderStyle.none),
                                borderRadius: BorderRadius.all(Radius.zero)),
                            tappable: true,
                            transitionType: ContainerTransitionType.fadeThrough,
                            transitionDuration:
                                const Duration(milliseconds: 1000),
                            closedBuilder: (context, action) {
                              return UserListItem(user: users[index]);
                            },
                            openBuilder: (context, action) {
                              return UserDetailPage(user: users[index]);
                            },
                          );
                          // child: UserListItem(user: users[index])
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.grey.withOpacity(0.2),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: Row(
                        children: List.generate(
                          state.users.totalPages,
                          (index) {
                            return TextButton(
                              onPressed: () {
                                context
                                    .read<UserBloc>()
                                    .add(LoadUsers(index + 1));
                              },
                              child: Text((index + 1).toString()),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              }
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
