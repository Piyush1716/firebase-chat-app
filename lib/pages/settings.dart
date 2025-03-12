import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temp/services/auth/auth_services.dart';
import 'package:temp/themes/themes_provider.dart';

class SettingsPage extends StatelessWidget {
  final void Function() ontap;
  SettingsPage({Key? key, required this.ontap}) : super(key: key);

  void logut(context) {
    Authentication auth = Authentication();
    auth.signout();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('SETTINGS'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: ()=>logut(context),
          )
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          color:  Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Dark Mode'),
            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode, 
              onChanged: (value)=> Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
            )
          ],
        ),
      ),
    );
  }
}
