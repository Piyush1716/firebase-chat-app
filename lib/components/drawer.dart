import 'package:flutter/material.dart';
import 'package:temp/services/auth/auth_services.dart';
import 'package:temp/pages/settings.dart';

class MyDrawer extends StatelessWidget {
  final String userEmail;

  
  MyDrawer({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // logo and user email
          Column(
            children: [
              Center(
                child: DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat, size: 40, color: Theme.of(context).colorScheme.primary),
                      SizedBox(height: 10),
                      Text(
                        userEmail,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1.2,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // home
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ListTile(
                  title: Text('H O M E',
                      style: TextStyle(
                          fontFamily: 'lufga',
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold)),
                  leading: Icon(Icons.home,
                      color: Theme.of(context).colorScheme.primary),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // settings
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ListTile(
                  title: Text('S E T T I N G S',
                      style: TextStyle(
                          fontFamily: 'lufga',
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold)),
                  leading: Icon(Icons.settings,
                      color: Theme.of(context).colorScheme.primary),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(ontap: () {})));
                  },
                ),
              ),
            ],
          ),

          // logout
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 20),
            child: ListTile(
              title: Text('L O G O U T',
                  style: TextStyle(
                      fontFamily: 'lufga',
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold)),
              leading: Icon(Icons.logout,
                  color: Theme.of(context).colorScheme.primary),
              onTap: () {
                Authentication auth = Authentication();
                try {
                  auth.signout();
                } on Exception catch (e) {
                  print(e);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
