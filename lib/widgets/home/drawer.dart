import 'package:cabavenue/providers/profile_provider.dart';
import 'package:cabavenue/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.customKey}) : super(key: key);
  final GlobalKey customKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.blueAccent),
                accountName: Text(
                  profile.getUserData.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                accountEmail: Text(
                  profile.getUserData.email,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                currentAccountPicture: Image.network(
                  profile.getUserData.profileUrl,
                  width: 100,
                  height: 100,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Iconsax.activity,
                ),
                title: const Text('Ride history'),
                onTap: () {
                  Navigator.pushNamed(context, '/ride-history');
                },
              ),
              ListTile(
                leading: const Icon(
                  Iconsax.edit,
                ),
                title: const Text('Edit Profile'),
                onTap: () {
                  Navigator.pushNamed(context, '/profile-edit');
                },
              ),
              ListTile(
                leading: const Icon(Iconsax.heart),
                title: const Text('Favorites'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Iconsax.logout,
                ),
                iconColor: Colors.redAccent,
                textColor: Colors.redAccent,
                title: const Text('Logout'),
                onTap: () {
                  AuthService().logout(context);
                  Navigator.pushNamed(context, '/auth');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
