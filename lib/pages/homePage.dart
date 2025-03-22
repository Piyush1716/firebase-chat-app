import 'package:flutter/material.dart';
import 'package:temp/components/drawer.dart';
import 'package:temp/components/user_tile.dart';
import 'package:temp/pages/chatPage.dart';
import 'package:temp/pages/settings.dart';
import 'package:temp/services/auth/auth_services.dart';
import 'package:temp/services/chat/chat_services.dart';

class HomePage extends StatelessWidget {
  final String userEmail;
  HomePage({Key? key, required this.userEmail}) : super(key: key);

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
      drawer: MyDrawer(userEmail: userEmail,),
      body: buildUserList(),
    );
  }

  Widget buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUserStream(),  // Any change in the user collection (addition, deletion, or update) automatically triggers a rebuild of the widget.
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text('Error loading users',
                  style: Theme.of(context).textTheme.bodyLarge));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary));
        }

        // Handle case where there are no users
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Text('No users found',
                  style: Theme.of(context).textTheme.bodyLarge));
        }

        return ListView(
          /*
          snapshot.data! holds the latest list of users from Firestore.
          Each user is a Map<String, dynamic> object (like a JSON object).
          Example snapshot.data!:
          [
            { "uid": "U1", "email": "alice@example.com" },
            { "uid": "U2", "email": "bob@example.com" },
            { "uid": "U3", "email": "charlie@example.com" }
          ]
    
          .map<Widget>(...) iterates over each user and calls _buildUserListItem(user, context).
          _buildUserListItem(user, context) converts each user object into a UserTile widget.
          */
          children: snapshot.data!
              .map<Widget>((user) => _buildUserListItem(user, context))
              .toList(), // Converts the mapped users into a List<Widget>, which is required by ListView.
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> user, BuildContext context) {
    if (user['email'] != _authservices.getCurrentUser()?.email) {
      return UserTile(
        email: user['email'],
        ontap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(receiverEmail: user['email'], receiverId: user['uid'])),
          );
        },
      );
    } 
    // The else part is required to prevent return null, which isn't a valid widget in Flutter.
    else {
      return SizedBox.shrink(); 
      // we have to return something bc 
      // SizedBox.shrink() takes zero space.
      // Container() still consumes layout space.
    }
  }
}
