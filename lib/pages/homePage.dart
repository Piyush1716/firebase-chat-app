import 'package:flutter/material.dart';
import 'package:temp/components/drawer.dart';
import 'package:temp/components/user_tile.dart';
import 'package:temp/pages/chatPage.dart';
import 'package:temp/pages/settings.dart';
import 'package:temp/services/auth/auth_services.dart';
import 'package:temp/services/chat/chat_services.dart';

class HomePage extends StatelessWidget {
  final void Function() ontap;
  HomePage({Key? key, required this.ontap}) : super(key: key);

  // Chat and Auth services
  final ChatServices _chatServices = ChatServices();
  final Authentication _authservices = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('ChatApp',
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage(ontap:(){})));
            },
          )
        ],
      ),
      drawer: MyDrawer(),
      body: buildUserList(),
    );
  }

  Widget buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text('Error loading users',
                  style: Theme.of(context).textTheme.bodyLarge));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary));
        }

        // Handle case where there are no users
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Text('No users found',
                  style: Theme.of(context).textTheme.bodyLarge));
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((user) => _buildUserListItem(user, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> user, BuildContext context) {
    if (user['email'] != _authservices.getCureUser()?.email) {
      return UserTile(
        email: user['email'],
        ontap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(receiveremail: user['email'], receiverId: user['uid'])),
          );
        },
      );
    } else {
      return SizedBox
          .shrink(); // More efficient than returning an empty Container
    }
  }
}
