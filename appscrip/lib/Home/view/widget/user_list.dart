import 'package:appscrip/Home/model/user_api_model.dart';
import 'package:appscrip/Home/view/user_details_screen.dart';
import 'package:flutter/material.dart';

class UserListWidget extends StatelessWidget {
  final List<UserApiResModel> filteredUserList;
  const UserListWidget({super.key, required this.filteredUserList});

  @override
  Widget build(BuildContext context) {
    return filteredUserList.isEmpty
        ? const Center(
            child: Text("No search found"),
          )
        : ListView.builder(
            itemCount: filteredUserList.length,
            itemBuilder: (context, index) {
              final user = filteredUserList[index];
              return ListTile(
                title: Text(user.name ?? 'No name'),
                subtitle: Text(user.email ?? 'No email'),
                trailing: Text(user.company?.name ?? 'No company'),
                onTap: () {
                  // Navigate to UserDetailsScreen on tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsScreen(user: user),
                    ),
                  );
                },
              );
            },
          );
  }
}
