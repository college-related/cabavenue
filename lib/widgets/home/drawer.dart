import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.customKey}) : super(key: key);
  final GlobalKey customKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            accountName: Text('Salipa Gurung'),
            accountEmail: Text('salipagurung@gmail.com'),
            currentAccountPicture: FlutterLogo(),
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
            ),
            title: const Text('Ride history'),
            onTap: () {
              Navigator.pushNamed(context, '/ride-history');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.edit_note_outlined,
            ),
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile-edit');
            },
          ),
        ],
      ),
    );
  }
}
