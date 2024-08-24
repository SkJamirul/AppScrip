import 'package:flutter/material.dart';
import 'package:appscrip/Home/model/user_api_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserApiResModel user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name ?? 'User Details'),
        // backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // User profile picture (Placeholder if URL is not available)
            CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: NetworkImage(user.website ?? ''),
                child: const Icon(Icons.person, size: 70, color: Colors.grey)),
            const SizedBox(height: 16),
            // User Details Card
            Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDetailRow(Icons.person, 'Name', user.name),
                    buildDetailRow(
                        Icons.person_outline, 'Username', user.username),
                    buildDetailRow(Icons.email, 'Email', user.email),
                    buildDetailRow(Icons.phone, 'Phone', user.phone),
                    buildDetailRow(Icons.web, 'Website', user.website),
                    buildDetailRow(
                        Icons.business, 'Company', user.company?.name),
                    buildDetailRow(Icons.location_on, 'Address',
                        '${user.address?.street}, ${user.address?.city}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label: ${value ?? 'Not available'}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
